#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

EMERAUDE_REPO="${EMERAUDE_REPO:-}"
CIRCT_BIN_DIR="${CIRCT_BIN_DIR:-}"
EMERAUDE_MLIR_OPT="${EMERAUDE_MLIR_OPT:-${EMERAUDE_REPO:+$EMERAUDE_REPO/build/bin/emeraude-mlir-opt}}"
CIRCT_OPT="${CIRCT_OPT:-${CIRCT_BIN_DIR:+$CIRCT_BIN_DIR/circt-opt}}"
EMERAUDE_MLIR_OPT="${EMERAUDE_MLIR_OPT:-emeraude-mlir-opt}"
CIRCT_OPT="${CIRCT_OPT:-circt-opt}"

INPUT_MLIR="${INPUT_MLIR:-$repo_root/flow/mlir/s3fdp_loop_accum.mlir}"
ARTIFACT_DIR="${ARTIFACT_DIR:-$repo_root/generated/ir-stages}"
CORE_SV_OUT="${CORE_SV_OUT:-$repo_root/src/generated/s3fdp_core.sv}"
WRAPPER_SV_IN="${WRAPPER_SV_IN:-$repo_root/src/project.sv}"
PROJECT_V_OUT="${PROJECT_V_OUT:-$repo_root/src/project.v}"

S3FDP_OPTS='lowering-mode=specialized target-frequency=5e7 specializations=enable=s3fdp,s3fdp.ovf=4,s3fdp.msb=5,s3fdp.lsb=-6,s3fdp.chunk_size=16'

resolve_tool() {
  local tool="$1"
  if [[ "$tool" == */* ]]; then
    if [[ ! -x "$tool" ]]; then
      echo "error: required executable not found: $tool" >&2
      exit 1
    fi
    echo "$tool"
    return 0
  fi

  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "error: required executable not found in PATH: $tool" >&2
    exit 1
  fi
  command -v "$tool"
}

EMERAUDE_MLIR_OPT="$(resolve_tool "$EMERAUDE_MLIR_OPT")"
CIRCT_OPT="$(resolve_tool "$CIRCT_OPT")"

if [[ ! -f "$INPUT_MLIR" ]]; then
  echo "error: input MLIR not found: $INPUT_MLIR" >&2
  exit 1
fi

mkdir -p "$ARTIFACT_DIR" "$(dirname "$CORE_SV_OUT")"

cp "$INPUT_MLIR" "$ARTIFACT_DIR/10-input.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/10-input.mlir" \
  --memref-return-to-out-param \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/12-outparam.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/12-outparam.mlir" \
  --flatten-memref --flatten-memref-args \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/14-flat.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/14-flat.mlir" \
  --flatten-memref-globals \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/16-flat-globals.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/16-flat-globals.mlir" \
  --lower-memref-view-to-linear \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/18-linear.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/18-linear.mlir" \
  --flopoco-arith-to-comb="$S3FDP_OPTS" \
  --reconcile-unrealized-casts \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/20-flopoco-comb.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/20-flopoco-comb.mlir" \
  --func-to-hw-module \
  -o "$ARTIFACT_DIR/30-hw.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/30-hw.mlir" \
  --lower-affine --lower-scf-to-seq-stream \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/40-seq.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/40-seq.mlir" \
  --realize-memref-as-seq-hw \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/42-seq-mem.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/42-seq-mem.mlir" \
  --lower-scf-if-to-seq-enable \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/44-seq-enable.mlir"

"$EMERAUDE_MLIR_OPT" "$ARTIFACT_DIR/44-seq-enable.mlir" \
  --convert-index-to-uint \
  --canonicalize --cse --symbol-dce \
  -o "$ARTIFACT_DIR/46-index-to-uint.mlir"

"$CIRCT_OPT" "$ARTIFACT_DIR/46-index-to-uint.mlir" \
  --map-arith-to-comb \
  --canonicalize --cse --symbol-dce \
  -o "$ARTIFACT_DIR/50-comb-lowered.mlir"

"$CIRCT_OPT" "$ARTIFACT_DIR/50-comb-lowered.mlir" \
  --hw-aggregate-to-comb \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/60-hw-aggregate.mlir"

"$CIRCT_OPT" "$ARTIFACT_DIR/60-hw-aggregate.mlir" \
  --lower-seq-hlmem \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/70-seq-hlmem.mlir"

"$CIRCT_OPT" "$ARTIFACT_DIR/70-seq-hlmem.mlir" \
  --lower-seq-to-sv \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/80-seq-to-sv.mlir"

"$CIRCT_OPT" "$ARTIFACT_DIR/80-seq-to-sv.mlir" \
  --lower-hw-to-sv \
  --canonicalize --cse \
  -o "$ARTIFACT_DIR/90-hw-to-sv.mlir"

"$CIRCT_OPT" "$ARTIFACT_DIR/90-hw-to-sv.mlir" \
  --test-apply-lowering-options='options=locationInfoStyle=none' \
  --export-verilog \
  -o "$ARTIFACT_DIR/99-export.mlir" > "$CORE_SV_OUT"

# Sanitize CIRCT-emitted clock-gating latch pattern to keep Verilator lint clean
# in TinyTapeout CI while preserving functional behavior for this core.
perl -0777 -i -pe 's/\n\s*reg\s+cg_en_latch;.*?end \/\/ always @\*\n/\n/s; s/clk\s*&\s*cg_en_latch/clk/g' "$CORE_SV_OUT"

if [[ -f "$WRAPPER_SV_IN" ]]; then
  cat "$WRAPPER_SV_IN" "$CORE_SV_OUT" > "$PROJECT_V_OUT"
fi

echo "generated: $CORE_SV_OUT"
echo "combined:  $PROJECT_V_OUT"
echo "stages:    $ARTIFACT_DIR"
