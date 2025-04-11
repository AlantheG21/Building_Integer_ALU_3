module arithmetic_shifter(
    input [3:0] A, B,
    output reg [3:0] X,
    output reg [3:0] Y
);
    reg [3:0] fill_bit;

    always @(*) begin
        fill_bit = {4{B[3]}}; //B[3] as the fill bit
        X = 4'b0000;
        Y = 4'b0000;

        case(B[0])
            1'b0: begin //Left shift
                X = A << B[2:1];
                Y = A >> (4 - B[2:1]);
                X = X | (fill_bit & ~(4'b1111 << B[2:1]));
            end

            1'b1: begin //Right shift
                X = A >> B[2:1];
                Y = A << (4 - B[2:1]);
                X = X | (fill_bit & (4'b1111 << B[2:1]));
            end
        endcase
    end
endmodule