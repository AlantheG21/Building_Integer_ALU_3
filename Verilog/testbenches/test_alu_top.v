module test_alu_top;
    reg [3:0] A, B, opcode;
    reg carry_in;
    wire [3:0] result, secondary_out;
    wire carry_out;

    alu_top uut (
        .A(A), .B(B), .carry_in(carry_in),
        .opcode(opcode),
        .result(result),
        .secondary_out(secondary_out),
        .carry_out(carry_out)
    );

    initial begin
         $dumpfile("Waveforms/alu_top.vcd");
         $dumpvars(0, test_alu_top);
        $monitor("Time=%0t | Opcode=%b | A=%b, B=%b | Result=%b, Secondary=%b, CarryOut=%b",
                 $time, opcode, A, B, result, secondary_out, carry_out);

        A = 4'b1010; B = 4'b0101; carry_in = 1'b0;

        opcode = 4'b0000; #10; // AND
        opcode = 4'b0001; #10; // NAND
        opcode = 4'b0010; #10; // OR
        opcode = 4'b0011; #10; // NOR
        opcode = 4'b0100; #10; // XOR
        opcode = 4'b0101; #10; // XNOR
        opcode = 4'b0110; #10; // NOT
        opcode = 4'b0111; #10; // Shift
        opcode = 4'b1000; #10; // ADD
        carry_in = 1; opcode = 4'b1000; #10; // ADD with carry
        carry_in = 0; opcode = 4'b1001; #10; // SUB
        opcode = 4'b1010; #10; // MUL
        opcode = 4'b1011; #10; // DIV

        $finish;
    end
endmodule
