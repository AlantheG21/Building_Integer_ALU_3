`timescale 1ns/1ps
module test_alu_arithmetic;
    reg [3:0] A, B;
    reg carry_in;
    reg [2:0] opcode;
    wire [3:0] result, left_over;
    wire carry_out;

    alu_arithmetic uut(
        .A(A),
        .B(B),
        .carry_in(carry_in),
        .opcode(opcode),
        .result(result),
        .left_over(left_over),
        .carry_out(carry_out)
    );

    initial begin
        $dumpfile("Waveforms/alu_arithmetic.vcd");
        $dumpvars(0, test_alu_arithmetic);

        $monitor("A = %b, B = %b, Opcode = %b, Carry_in = %b, Result = %b, Left_over = %b, Carry_out = %b",
                A, B, opcode, carry_in, result, left_over, carry_out);
        
        A = 4'b1010; B = 4'b0101; carry_in = 1'b0;

        // Test Addition
        opcode = 3'b000; #10;

        // Test Subtraction
        opcode = 3'b001; #10;

        // Test Multiplication
        opcode = 3'b010; #10;

        // Test Division
        opcode = 3'b011; #10;

        // Test Addition with caryy_in = 1
        carry_in = 1'b1; opcode = 3'b000; #10;

        #10;#10;#10;#10;#10;#10;#10;#10;

        $finish;
    end
endmodule