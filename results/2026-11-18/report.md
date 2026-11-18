# ALU verification — 2026-11-18

## Scope and finding

Baseline: `2486376f8a9eca407a02df353a639629bcea2e4f`.
The existing `rtl/alu.v` was tested without modification. No functional RTL defect was found for the specified binary-input behavior. This does not certify unknown-state behavior, physical timing, or operation on an FPGA.

One documentation bug was confirmed: opcode `111` was described as clearing every flag, while the RTL and starter test produce `y=0, zero=1, carry=0, overflow=0`. The documentation now follows the existing invariant `zero == (y == 0)`. No opcode or hardware behavior changed.

## Executed checks

| Check | Observed result |
|---|---|
| Unmodified starter testbench | 14 / 14 checks passed |
| Independent integer-oracle test | 524,288 / 524,288 vectors passed |
| Input coverage | All 8 opcodes × 256 values of a × 256 values of b |
| Outputs checked | y, zero, carry, signed overflow on every vector |
| Yosys `check -assert` | 0 reported problems |
| Latch absence assertion | Passed; no inferred latches |
| Generic synthesis, `-noabc` | 278 generic cells, no registers |

The oracle uses integer addition/subtraction, `a >= b` for no-borrow, and signed mathematical range checks for overflow. It does not copy the RTL's sign-bit overflow equations. Shift expectations use multiply/divide by two. Coverage is exhaustive over binary inputs; X/Z propagation and path delays are outside this regression.

## Reproduce

Requirements: Bash, Icarus Verilog 12.0 and Yosys 0.52. From the repository root:

```bash
bash scripts/run_verification.sh
bash scripts/run_synthesis.sh
```

The runner preserves the existing smoke test and adds a separate exhaustive bench. Both fail with a nonzero exit status on a mismatch. The exhaustive run does not dump a large waveform. The original bench produces `build/alu_waveforms.vcd`.

## Evidence and limits

- [Original run log](baseline-smoke.log)
- [Complete regression log](verification.log)
- [Generic synthesis log](synthesis.log)
- [Tool versions and source SHA-256 hashes](provenance.json)
- [Actual starter waveform](alu-smoke.vcd)

Icarus warns that the RTL module has no explicit timescale. It contains no delays, so this does not change the tested combinational behavior; the testbenches declare `1ns/1ps`. A `#1` testbench settling interval is not an ALU propagation-delay measurement. GTKWave GUI review has not been performed.

The 278 cells are Yosys generic primitives after `synth -noabc`, with no ASIC library, FPGA part, timing constraints, placement, routing or power model. They must not be presented as LUT usage, silicon area, maximum clock frequency, or measured energy. No formal equivalence proof was run.

## Next engineering milestone

Add a registered wrapper with a precise request/result interface, then choose a real FPGA or standard-cell target and constrain the clock. Keep the verified combinational ALU as the baseline. The original learning exercises remain open until the learner can explain carry versus signed overflow independently.
