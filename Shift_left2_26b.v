module Shift_left2_26b(in, out, clk);

    input wire [25:0] in;
    input wire clk;

    output reg [25:0] out;

    always@(posedge clk)
    begin
        out <= in << 2;
    end
endmodule
