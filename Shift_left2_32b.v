module Shift_left2_32b(in, out, clk);

    input wire [31:0] in;
    input wire clk;

    output reg [31:0] out;

    always@(posedge clk)
    begin
        out <= in << 2;
    end
endmodule
