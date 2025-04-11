`timescale 1ns/1ps
module test_arithmetic_shifter;
    reg [3:0] A, B;
    wire [3:0] X, Y;

    arithmetic_shifter uut(.A(A), .B(B), .X(X), .Y(Y));

    initial begin
        $dumpfile("Waveforms/arithmetic_shifter.vcd");
        $dumpvars(0, test_arithmetic_shifter);

        $monitor("A = %b, B = %b, X(Shifted) = %b, Y(Overflow) = %b", A, B , X, Y);
        A = 4'b1010;

        //Test 1: Left shift by 1, fill 0 (B[3]=0)
        B = 4'b0010; #10;

        //Test 2: Right shift by 2, fill 1 (B[3]=1)
        B = 4'b1101; #10;

        //Test 3: Left shift by 3, fill 1
        B = 4'b1110; #10;

        //Test 4: Right shift 1, fill 0
        B = 4'b0011; #10;
        #10;

        $finish;
    end
endmodule