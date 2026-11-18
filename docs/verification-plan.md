# Verification Plan

## Stage 1 — Functional smoke tests
Run the provided testbench. It checks arithmetic, signed overflow, carry/no-borrow, logical functions, shifts, and reserved opcodes.

## Stage 2 — Additional coverage
- [x] Every opcode
- [x] All-zero and all-one inputs
- [x] Plus 1, minus 1 and unsigned wraparound
- [x] Signed min/max overflow edges
- [ ] Random inputs and software-reference comparison
- [ ] VCD waveforms inspected
- [x] Check combinational outputs under changing inputs

## Stage 3 — Synthesis
- [x] Synthesize with Yosys
- [x] Check for unintended latches
- [x] Record cell counts, target library and tool versions
- [ ] Do not describe synthesis cell count as fabricated chip area

## Results discipline
Log actual tool versions, console output, test coverage and known gaps. Until tests run, write **not yet verified**.

## Executed audit

See [2026-11-18 evidence](../results/2026-11-18/report.md). Exhaustive binary-input checking supersedes the planned random sampling for the current combinational contract. Synthesis was generic with no target library. GUI waveform review and target-specific physical implementation remain open.
