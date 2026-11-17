# 8-bit ALU — Verilog and Digital Design

**Status:** Starter RTL and testbench published; execution and verification not yet confirmed.

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
| 111 | reserved | result and flags set to zero |

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

This script compiles and executes the starter testbench, creating an output in the ignored `build/` directory. A successful future test run must be documented with its actual simulator version, console output, and any waveforms.

## Roadmap
- [ ] Run and validate the supplied testbench
- [ ] Add randomized or exhaustive test vectors
- [ ] Examine waveforms using GTKWave
- [ ] Synthesize with Yosys and inspect resource usage
- [ ] Compare power, timing and area after an appropriate design flow

No physical IC tape-out, implementation measurements, or verified test results are claimed.
