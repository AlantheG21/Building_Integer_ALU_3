`timescale 1ns/1ps
module test_xor;
    reg [3:0] A, B;
    wire [3:0] Y;

    xor_gate uut(.A(A), .B(B), .result(Y));

    initial begin
        $dumpfile("Waveforms/xor_gate.vcd");
        $dumpvars(0, test_xor);

        $monitor("A = %b, B = %b, Y = %b", A, B, Y);
        A = 4'b1100; B = 4'b1001; #10;
        A = 4'b0000; B = 4'b0011; #10;
        #10; #10; #10;
        $finish;
    end
endmodule