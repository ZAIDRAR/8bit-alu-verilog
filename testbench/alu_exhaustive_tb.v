`timescale 1ns/1ps
// Independent integer oracle: overflow uses mathematical range checks.
// Exhausts every binary input combination; does not claim X/Z or timing coverage.
module alu_exhaustive_tb;
    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] y;
    wire zero, carry, overflow;
    integer ai, bi, oi, sa, sb, value, signed_value, count;
    reg [7:0] expected_y;
    reg expected_carry, expected_overflow;
    alu dut(a, b, op, y, zero, carry, overflow);

    initial begin
        count = 0;
        for (oi = 0; oi < 8; oi = oi + 1)
            for (ai = 0; ai < 256; ai = ai + 1)
                for (bi = 0; bi < 256; bi = bi + 1) begin
                    sa = (ai >= 128) ? ai - 256 : ai;
                    sb = (bi >= 128) ? bi - 256 : bi;
                    value = 0;
                    signed_value = 0;
                    expected_carry = 0;
                    expected_overflow = 0;
                    case (oi)
                        0: begin
                            value = ai + bi;
                            signed_value = sa + sb;
                            expected_carry = (value >= 256);
                        end
                        1: begin
                            value = ai - bi;
                            signed_value = sa - sb;
                            expected_carry = (ai >= bi);
                        end
                        2: value = ai & bi;
                        3: value = ai | bi;
                        4: value = ai ^ bi;
                        5: begin
                            value = ai * 2;
                            expected_carry = (ai >= 128);
                        end
                        6: begin
                            value = ai / 2;
                            expected_carry = (ai % 2 != 0);
                        end
                        7: value = 0;
                    endcase
                    if (oi < 2)
                        expected_overflow = (signed_value < -128 || signed_value > 127);
                    expected_y = value & 255;
                    a = ai; b = bi; op = oi;
                    #1;
                    if ({y, zero, carry, overflow} !==
                        {expected_y, (expected_y == 0), expected_carry, expected_overflow})
                        $fatal(1, "ALU mismatch op=%0d a=%0d b=%0d y=%h flags=%b%b%b expected_y=%h flags=%b%b%b",
                            oi, ai, bi, y, zero, carry, overflow, expected_y,
                            expected_y == 0, expected_carry, expected_overflow);
                    count = count + 1;
                end
        $display("PASS: %0d exhaustive ALU vectors (8 opcodes x 256 x 256); result and all flags checked", count);
        $finish;
    end
endmodule
