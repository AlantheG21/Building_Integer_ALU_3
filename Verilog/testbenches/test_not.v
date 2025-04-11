`timescale 1ns/1ps
module test_not;
    reg [3:0] A;
    wire [3:0] Y;

    not_gate uut(.A(A), .result(Y));

    initial begin
        $dumpfile("Waveforms/not_gate.vcd");
        $dumpvars(0, test_not);

        $monitor("A = %b, Y = %b", A, Y);
        A = 4'b1100; #10;
        #10; #10; #10; #10;#10;#10;#10;#10;#10;#10;#10;#10;
    end
endmodule