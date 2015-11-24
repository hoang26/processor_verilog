module sign_extender_tb;

reg clk;
reg [15:0] in;

wire [31:0] out;

sign_extender DUT(clk, in, out);

// Initial Conditions
initial begin
    clk=0;
end

// Clock
always #5 clk=~clk;

// Input Waveform
initial begin
    in = 16'b0000000000000000;

    #15
    in = 16'b1000000000000000;
end

endmodule
