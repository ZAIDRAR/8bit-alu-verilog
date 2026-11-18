#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
bash scripts/run_simulation.sh
iverilog -g2012 -Wall -s alu_exhaustive_tb -o build/alu_exhaustive.vvp rtl/alu.v testbench/alu_exhaustive_tb.v
vvp build/alu_exhaustive.vvp
