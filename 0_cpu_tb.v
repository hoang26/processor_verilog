`timescale 1ns/100ps
module processor_tb;

reg clk, pc_reset, pc_enable;

//wire [31:0] regFile [31:0];

reg [4:0] i;
reg [4:0] j;

processor DUT(clk, reset, pc_enable);

// Initial Conditions
initial begin
    clk=0;
	pc_reset=0;
	pc_enable=1;
end

// Clock
always #5 clk=~clk;

// Input Waveform
initial begin

//for (i=0; i<32; i=i+1) begin
	//$display ("%h", regFile[i]);
	// for (j=0; j<32; j=j+1) begin
	//end
end
endmodule
