# 8-bit ALU — Verilog and Digital Design

**Status:** RTL simulation and generic synthesis verified on 2026-11-18.
The existing RTL passed 14 starter checks and 524,288 exhaustive binary-input
vectors. See the [verification report](results/2026-11-18/report.md).
FPGA implementation, physical timing, power and silicon measurements remain pending.

This project introduces combinational RTL design, arithmetic flags, testbench construction, and eventually synthesis. It is part of [my semiconductor engineering portfolio](https://github.com/ZAIDRAR/semiconductor-learning-journey).

## Initial design
- Two unsigned 8-bit bit-vector inputs: `a` and `b`
- 3-bit operation selector `op`
- 8-bit result `y`
- Flags: `zero`, `carry`, `overflow`
- Arithmetic is 8-bit modulo 256; overflow is **signed two's-complement** overflow
- For subtraction, `carry=1` indicates **no unsigned borrow**
- For logical operations, carry and overflow are zero

| Opcode | Operation | Description |
|---|---|---|
| 000 | ADD | a + b |
| 001 | SUB | a - b |
| 010 | AND | a & b |
| 011 | OR | a \| b |
| 100 | XOR | a ^ b |
| 101 | SHL | a << 1 |
| 110 | SHR | a >> 1 |
| 111 | reserved | y=0, zero=1, carry=0, overflow=0 |

For shift operations, `carry` is the bit shifted out. See [specification](docs/specification.md) for precise behavior.

## Folder guide
- [rtl/alu.v](rtl/alu.v): Synthesizable ALU source
- [testbench/alu_tb.v](testbench/alu_tb.v): Starter functional testbench
- [scripts/run_simulation.sh](scripts/run_simulation.sh): Commands to run with Icarus Verilog
- [docs/specification.md](docs/specification.md): Architecture and flag definitions
- [docs/verification-plan.md](docs/verification-plan.md): Tests to add
- [results/README.md](results/README.md): Where actual results belong
- [reports/report-template.md](reports/report-template.md): Engineering report template

## Run locally
Install Icarus Verilog, then from the repository root run:

```bash
bash scripts/run_simulation.sh
```

This script compiles and executes the original starter testbench in `build/`.
Run the complete regression with `bash scripts/run_verification.sh` and generic
synthesis with `bash scripts/run_synthesis.sh` (Yosys required). Dated evidence
includes exact tool versions, logs, source hashes and the starter VCD.

## Roadmap
- [x] Run and validate the supplied testbench
- [x] Exhaust all 8 × 256 × 256 binary input combinations and every output flag
- [ ] Examine waveforms using GTKWave
- [x] Synthesize with Yosys; inspect generic cells and check for latches
- [ ] Compare power, timing and area after an appropriate design flow

No physical IC tape-out or implementation measurements are claimed. Generic
Yosys cells are not FPGA LUTs, physical area, or a power estimate.
