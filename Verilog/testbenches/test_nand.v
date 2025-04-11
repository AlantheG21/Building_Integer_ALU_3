`timescale 1ns/1ps
module test_nand;
    reg [3:0] A, B;
    wire [3:0] Y;

    nand_gate uut(.A(A), .B(B), .result(Y));

    initial begin
        $dumpfile("Waveforms/nand_gate.vcd");
        $dumpvars(0, test_nand);

        $monitor("A = %b, B = %b, Y = %b", A, B, Y);
        A = 4'b1010; B = 4'b1011; #10;
        A = 4'b0000; B = 4'b1111; #10;
        #10; #10; #10;
        $finish;
    end
endmodule