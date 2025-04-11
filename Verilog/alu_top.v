module alu_top (
    input  [3:0] A,
    input  [3:0] B,
    input        carry_in,
    input  [3:0] opcode,
    output reg [3:0] result,
    output reg [3:0] secondary_out, // For overflow, remainder, or shifted-out bits
    output reg       carry_out
);

    wire [3:0] and_out, nand_out, or_out, nor_out, xor_out, xnor_out, not_out;
    wire [3:0] arith_result, arith_remainder;
    wire       arith_carry_out;
    wire [3:0] shift_result, shift_overflow;

    // Instantiate logic gate modules
    and_gate   u_and   (.A(A), .B(B), .result(and_out));
    nand_gate  u_nand  (.A(A), .B(B), .result(nand_out));
    or_gate    u_or    (.A(A), .B(B), .result(or_out));
    nor_gate   u_nor   (.A(A), .B(B), .result(nor_out));
    xor_gate   u_xor   (.A(A), .B(B), .result(xor_out));
    xnor_gate  u_xnor  (.A(A), .B(B), .result(xnor_out));
    not_gate   u_not   (.A(A), .result(not_out));

    // Arithmetic ALU
    alu_arithmetic u_arith (
        .A(A), .B(B), .carry_in(carry_in), .opcode(opcode[2:0]),
        .result(arith_result), .left_over(arith_remainder), .carry_out(arith_carry_out)
    );

    // Arithmetic Shifter
    arithmetic_shifter u_shift (
        .A(A), .B(B), .X(shift_result), .Y(shift_overflow)
    );

    // Control Circuit (opcode-based multiplexer)
    always @(*) begin
        carry_out = 0;
        secondary_out = 4'b0000;

        case (opcode)
            4'b0000: result = and_out;
            4'b0001: result = nand_out;
            4'b0010: result = or_out;
            4'b0011: result = nor_out;
            4'b0100: result = xor_out;
            4'b0101: result = xnor_out;
            4'b0110: result = not_out;
            4'b0111: begin
                result = shift_result;
                secondary_out = shift_overflow;
            end
            4'b1000: begin // ADD
                result = arith_result;
                carry_out = arith_carry_out;
            end
            4'b1001: begin // SUB
                result = arith_result;
                carry_out = arith_carry_out;
            end
            4'b1010: begin // MUL
                result = arith_result;
                secondary_out = arith_remainder;
            end
            4'b1011: begin // DIV
                result = arith_result;
                secondary_out = arith_remainder;
            end
            default: result = 4'b0000;
        endcase
    end

endmodule
