# Verification Plan

## Stage 1 — Functional smoke tests
Run the provided testbench. It checks arithmetic, signed overflow, carry/no-borrow, logical functions, shifts, and reserved opcodes.

## Stage 2 — Additional coverage
- [ ] Every opcode
- [ ] All-zero and all-one inputs
- [ ] Plus 1, minus 1 and unsigned wraparound
- [ ] Signed min/max overflow edges
- [ ] Random inputs and software-reference comparison
- [ ] VCD waveforms inspected
- [ ] Check combinational outputs under changing inputs

## Stage 3 — Synthesis
- [ ] Synthesize with Yosys
- [ ] Check for unintended latches
- [ ] Record cell counts, target library and tool versions
- [ ] Do not describe synthesis cell count as fabricated chip area

## Results discipline
Log actual tool versions, console output, test coverage and known gaps. Until tests run, write **not yet verified**.
