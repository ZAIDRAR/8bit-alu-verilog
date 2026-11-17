// Starter functional tests; status unverified until run
`timescale 1ns/1ps

module alu_tb;
    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] y;
    wire zero, carry, overflow;
    integer pass_count;

    alu dut(
        .a(a), .b(b), .op(op), .y(y),
        .zero(zero), .carry(carry), .overflow(overflow)
    );

    task check;
        input [7:0] aa, bb;
        input [2:0] operation;
        input [7:0] expected_y;
        input expected_carry, expected_overflow;
        begin
            a = aa;
            b = bb;
            op = operation;
            #1;
            if ((y !== expected_y) ||
                (carry !== expected_carry) ||
                (overflow !== expected_overflow) ||
                (zero !== (expected_y == 8'h00))) begin
                $display("FAIL op=%b a=%h b=%h y=%h carry=%b ov=%b zero=%b",
                    op, a, b, y, carry, overflow, zero);
                $fatal(1, "ALU test failed");
            end
            pass_count = pass_count + 1;
        end
    endtask

    initial begin
        $dumpfile("build/alu_waveforms.vcd");
        $dumpvars(0, alu_tb);
        pass_count = 0;

        check(8'h12, 8'h34, 3'b000, 8'h46, 0, 0);
        check(8'hFF, 8'h01, 3'b000, 8'h00, 1, 0);
        check(8'h7F, 8'h01, 3'b000, 8'h80, 0, 1);
        check(8'h80, 8'h80, 3'b000, 8'h00, 1, 1);
        check(8'h09, 8'h03, 3'b001, 8'h06, 1, 0);
        check(8'h03, 8'h09, 3'b001, 8'hFA, 0, 0);
        check(8'h80, 8'h01, 3'b001, 8'h7F, 1, 1);
        check(8'h7F, 8'hFF, 3'b001, 8'h80, 0, 1);
        check(8'hF0, 8'h0F, 3'b010, 8'h00, 0, 0);
        check(8'hF0, 8'h0F, 3'b011, 8'hFF, 0, 0);
        check(8'hAA, 8'hFF, 3'b100, 8'h55, 0, 0);
        check(8'h81, 8'h00, 3'b101, 8'h02, 1, 0);
        check(8'h81, 8'h00, 3'b110, 8'h40, 1, 0);
        check(8'h22, 8'h33, 3'b111, 8'h00, 0, 0);

        $display("All %0d starter checks passed", pass_count);
        $finish;
    end
endmodule
