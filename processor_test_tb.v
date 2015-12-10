module processor_test_tb;

reg clk;
reg rst;
reg en;
reg [31:0] in;

wire [31:0] out;

processor_test DUT(clk, rst, en);

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

    //Step 1 - test if PC resets to 0x3000
    //Step 2 - test if adder does PC+4
    //Step 3 - Check if instruction memory is getting an address
    //          and returning an instruction address
    rst=1;
    en=1;

    #15
    rst=0;


end

endmodule
