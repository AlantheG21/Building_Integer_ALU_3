module alu_arithmetic(
    input [3:0] A, B,
    input carry_in,
    input [2:0] opcode,     // 000=Add, 001=Sub, 010=Mul, 011=Div
    output reg [3:0] result,
    output reg [3:0] left_over, // For multiplication and division (overflow and remainder)
    output reg carry_out
);

    always @(*) begin
        carry_out = 0;
        left_over = 4'b0000;
        case(opcode)
            3'b000: {carry_out , result} = A + B + carry_in;
            3'b001: {carry_out, result} = A - B - carry_in;
            3'b010: {left_over, result} = A * B;
            3'b011: begin
                if (B != 0) begin
                    result = A / B;
                    left_over = A % B;
                end
                else begin
                    result = 4'b0000;
                    left_over = 4'b0000;
                end
            end
            default: result = 4'b0000;
        endcase
    end
endmodule