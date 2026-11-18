#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p build
yosys -p 'read_verilog rtl/alu.v; synth -top alu -noabc; check -assert; select -assert-none t:$_DLATCH_* t:$dlatch; stat; write_json build/alu-generic.json'
