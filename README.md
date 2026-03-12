![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout S3FDP Seq+Comb MLIR Flow (`ttsky26a`)

This repository contains a Tiny Tapeout project where the compute core is generated from MLIR through Emeraude + CIRCT, then wrapped by a TinyTapeout top module.

Top module: `tt_um_lledoux_s3fdp_seqcomb`

## One-command core generation

```sh
./scripts/generate_s3fdp_core.sh
```

Default tool paths used by the script:

- `EMERAUDE_REPO=/home/lledoux/Documents/work/repositories/emeraude-mlir`
- `EMERAUDE_MLIR_OPT=$EMERAUDE_REPO/build/bin/emeraude-mlir-opt`
- `CIRCT_BIN_DIR=/home/lledoux/Documents/work/postdoc/circt/build/bin`
- `CIRCT_OPT=$CIRCT_BIN_DIR/circt-opt`

Environment overrides are supported (`EMERAUDE_REPO`, `EMERAUDE_MLIR_OPT`, `CIRCT_BIN_DIR`, `CIRCT_OPT`, `INPUT_MLIR`, `ARTIFACT_DIR`, `CORE_SV_OUT`).

## Fixed S3FDP configuration

The flow pins this specialization:

- `lowering-mode=specialized`
- `target-frequency=5e7`
- `specializations=enable=s3fdp,s3fdp.ovf=5,s3fdp.msb=6,s3fdp.lsb=-6,s3fdp.chunk_size=16`

## Artifact map

- Canonical input MLIR: `flow/mlir/s3fdp_loop_accum.mlir`
- Stage snapshots: `generated/ir-stages/*.mlir`
- Generated core SV: `src/generated/s3fdp_core.sv`
- TinyTapeout wrapper + embedded generated core for CI: `src/project.v`

Main staged outputs:

- `10-input.mlir`
- `20-flopoco-comb.mlir`
- `40-seq.mlir`
- `90-hw-to-sv.mlir`
- `99-export.mlir`

## Pass chain used

1. `memref-return-to-out-param`
2. `flatten-memref`, `flatten-memref-args`, `flatten-memref-globals`, `lower-memref-view-to-linear`
3. `flopoco-arith-to-comb` (specialized S3FDP)
4. `func-to-hw-module`, `lower-scf-to-seq-stream`, `realize-memref-as-seq-hw`, `lower-scf-if-to-seq-enable`, `convert-index-to-uint`
5. CIRCT: `map-arith-to-comb`, `hw-aggregate-to-comb`, `lower-seq-hlmem`, `lower-seq-to-sv`, `lower-hw-to-sv`, `--export-verilog`

## Input/output protocol (wrapper contract)

The wrapper consumes a raw continuous byte stream on `ui_in[7:0]`:

- 36-byte frame, little-endian
- `a[4]` IEEE754 `f32`: 16 bytes
- `b[4]` IEEE754 `f32`: 16 bytes
- `c0` IEEE754 `f32`: 4 bytes

Execution schedule:

- Core held in reset while loading bytes.
- After byte 36, reset is released.
- Wait exactly 6 cycles.
- Output `r` on `uo_out[7:0]` as 4 little-endian bytes.
- Frame cadence is 46 cycles total (`36 load + 6 run + 4 output`).
- For continuous streaming, send one frame every 46 cycles.

`uio_out` and `uio_oe` are zero.

## IR and generated HDL examples

### Input IR (`generated/ir-stages/10-input.mlir`)

```mlir
scf.for %k = %c0 to %c4 step %c1 {
  %x = memref.load %a[%k] : memref<4xf32>
  %y = memref.load %b[%k] : memref<4xf32>
  %acc = memref.load %c[%c0] : memref<2xf32>
  %m = arith.mulf %x, %y : f32
  %s = arith.addf %acc, %m : f32
  memref.store %s, %c[%c0] : memref<2xf32>
}
```

### Comb/S3FDP IR (`generated/ir-stages/20-flopoco-comb.mlir`)

```mlir
%s3fdp_accum.r = hw.instance "s3fdp_accum" @s3fdp_accum_core_wE8_wF23_cs16(
  clk: %3: !seq.clock, reset: %arg1: i1, x: %1: i32, y: %2: i32
) -> (r: i32)
```

### Seq/HW IR (`generated/ir-stages/40-seq.mlir`)

```mlir
%0 = seq.compreg %8, %clk_0 reset %reset, %c0_i32 : i32
scf.if %1 {
  %s3fdp_accum.r = hw.instance "s3fdp_accum" @s3fdp_accum_core_wE8_wF23_cs16(...)
  memref.store %s3fdp_accum.r, %c[%c0] : memref<2xi32>
}
```

### Final generated core header (`src/generated/s3fdp_core.sv`)

```systemverilog
module fpmult_loop_muladd_s3fdp(
  input              clk,
                     reset,
  input  [3:0][31:0] a,
                     b,
  input  [1:0][31:0] c,
  input              clk_0,
  output [31:0]      r
);
```

## Test

Run RTL test:

```sh
python3 -m venv .venv
. .venv/bin/activate
pip install -r test/requirements.txt
cd test
make clean
make -B
```

The test sends two identical bounded frames in continuous slots and checks the same expected 32-bit output both times (`0x3EF00000`).

## Tiny Tapeout notes

- `info.yaml` is configured for SystemVerilog and 50 MHz.
- Source listed for submission:
  - `project.v` (contains wrapper + embedded generated core module)
- Datasheet content is in `docs/info.md`.
