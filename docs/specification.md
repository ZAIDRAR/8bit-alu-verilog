# ALU Specification

## Ports
| Signal | Direction | Width | Meaning |
|---|---|---|---|
| a | input | 8 | First input bit vector |
| b | input | 8 | Second input bit vector |
| op | input | 3 | Opcode |
| y | output | 8 | Low 8 result bits |
| zero | output | 1 | 1 iff y is zero |
| carry | output | 1 | Addition carry-out, subtraction no-borrow, or shifted-out bit |
| overflow | output | 1 | Signed overflow for addition/subtraction only |

## Arithmetic semantics
The ALU is combinational. Addition and subtraction wrap modulo 256 in `y`.

- **ADD:** carry = 9th bit of unsigned addition. Signed overflow when input signs agree but output sign differs.
- **SUB:** carry = 1 when no unsigned borrow; implemented using `a + (~b) + 1`. Signed overflow when input signs differ and result sign differs from `a`.
- **AND/OR/XOR:** both arithmetic flags = 0.
- **SHL:** y = a shifted left by 1; carry = original a[7].
- **SHR:** logical right shift; carry = original a[0].
- **Reserved op (`111`):** `y=0`, `carry=0`, `overflow=0`, **`zero=1`**.
  The zero flag always describes the result, including this opcode. The previous
  statement that all flags were zero contradicted the RTL and starter testbench.

`b` is not used for shift operations.

## Design boundary
No clock, reset, pipeline, register file or processor instruction encoding is implemented. This is a fundamental block, not a CPU.
