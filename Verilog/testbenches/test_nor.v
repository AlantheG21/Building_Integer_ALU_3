`timescale 1ns/1ps
module test_nor;
    reg [3:0] A, B;
    wire [3:0] Y;

    nor_gate uut(.A(A), .B(B), .result(Y));

    initial begin
        $dumpfile("Waveforms/nor_gate.vcd");
        $dumpvars(0, test_nor);

        $monitor("A = %b, B = %b, Y = %b", A, B, Y);
        A = 4'b1001; B = 4'b1010; #10;
        A = 4'b0000; B = 4'b1111; #10;
        #10; #10; #10;#10;#10;#10;#10;#10;#10;#10;#10;
        $finish;
    end
endmodule