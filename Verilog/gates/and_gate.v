module and_gate(
    input [3:0] A, B,
    output [3:0] result
);
    assign result = A & B;
endmodule