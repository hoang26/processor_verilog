// Taken from HW6
module reg_file(regWrite, clk, readReg1, readReg2, writeReg, writeData, readData1, readData2);

	input wire regWrite;
	input wire clk;
	input wire [4:0] readReg1;
	input wire [4:0] readReg2;
	input wire [4:0] writeReg;
	input wire [31:0] writeData;
	
	output reg [31:0] readData1; 
	output reg [31:0] readData2;

	reg [31:0] regFile [31:0];
	
	integer i;
	initial begin
		for (i=0; i<32; i=i+1)
			regFile[i] <=0;
	end

	always@(readReg1 or readReg2 or regFile)
	begin
		 readData1 <= regFile[readReg1];
		 readData2 <= regFile[readReg2];
	end

	always@(posedge clk) 
	begin
		if(regWrite)
			regFile[writeReg] <= writeData;
	end

endmodule
