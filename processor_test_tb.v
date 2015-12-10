module processor_test_tb;

reg clk;
reg rst;
reg en;
reg [31:0] in;

wire [31:0] out;

pc DUT(in, clk, rst, en, out);

// Initial Conditions
initial begin
    clk=0;
    rst=0;
    en=0;
end

// Clock
always #5 clk=~clk;

// Input Waveform
initial begin
    rst=1;
    en=1;

    #15
    rst=0;
end

endmodule
