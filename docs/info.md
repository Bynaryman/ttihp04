## How it works

This project wraps a generated S3FDP sequential+combinational floating-point accumulation core.

The hardware core is generated from an MLIR `scf.for` loop that computes:

`c0 = c0 + a[k] * b[k]` for `k = 0..3`

The TinyTapeout top-level module (`tt_um_lledoux_s3fdp_seqcomb`) streams input bytes, runs the generated core, and streams result bytes.

Protocol:

- Input stream on `ui_in[7:0]` is a continuous 36-byte frame, little-endian:
  - `a[0..3]` IEEE754 `f32` words (16 bytes)
  - `b[0..3]` IEEE754 `f32` words (16 bytes)
  - `c0` IEEE754 `f32` seed (4 bytes)
- During frame loading, the core is held in reset.
- After frame load, the wrapper releases reset and waits 6 cycles.
- The wrapper outputs one 32-bit result word as 4 bytes on `uo_out[7:0]`, little-endian.
- One full frame slot is 46 cycles (`36 load + 6 run + 4 output`).
- For continuous streaming, send one frame every 46 cycles.

`uio` pins are unused.

## How to test

1. Generate the core and stage snapshots:

```sh
./scripts/generate_s3fdp_core.sh
```

2. Run RTL simulation:

```sh
cd test
make clean
make -B
```

The cocotb test sends two identical bounded frames and checks deterministic repeated outputs.

## External hardware

No external hardware is required.
