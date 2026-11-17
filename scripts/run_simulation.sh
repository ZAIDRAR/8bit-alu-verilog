#!/usr/bin/env bash
set -euo pipefail
mkdir -p build
iverilog -g2012 -Wall -s alu_tb -o build/alu_tb.vvp rtl/alu.v testbench/alu_tb.v
vvp build/alu_tb.vvp
echo "Waveforms (if generated): build/alu_waveforms.vcd"
echo "You can open them using: gtkwave build/alu_waveforms.vcd"
