// Educational 8-bit combinational ALU
// Status: reference implementation; verify with your simulator before claiming results
module alu (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [2:0] op,
    output reg  [7:0] y,
    output reg        zero,
    output reg        carry,
    output reg        overflow
);
    reg [8:0] extended;

    always @* begin
        y        = 8'h00;
        zero     = 1'b1;
        carry    = 1'b0;
        overflow = 1'b0;
        extended = 9'h000;

        case (op)
            3'b000: begin // Addition
                extended = {1'b0, a} + {1'b0, b};
                y = extended[7:0];
                carry = extended[8];
                overflow = (~(a[7] ^ b[7])) & (a[7] ^ y[7]);
            end
            3'b001: begin // Subtraction; carry=1 means no borrow
                extended = {1'b0, a} + {1'b0, ~b} + 9'd1;
                y = extended[7:0];
                carry = extended[8];
                overflow = (a[7] ^ b[7]) & (a[7] ^ y[7]);
            end
            3'b010: y = a & b;
            3'b011: y = a | b;
            3'b100: y = a ^ b;
            3'b101: begin
                y = a << 1;
                carry = a[7];
            end
            3'b110: begin
                y = a >> 1;
                carry = a[0];
            end
            default: y = 8'h00;
        endcase
        zero = (y == 8'h00);
    end
endmodule
