// Register file modeled off HW6 solutions #3
module reg_file(
    input clk,
    input regWrite,
    //input wire regInit,
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    output reg [31:0] readData1, 
    output reg [31:0] readData2
    );

reg [31:0] regFile [31:0];

	integer i;
	initial begin
		for (i=0; i<32; i=i+1) begin
			regFile[i] <=0;
		end
	end

always@(readReg1 or readReg2 or regFile)
begin
    readData1 <= regFile[readReg1];
    readData2 <= regFile[readReg2];
end


// Register only updates when regWrite control signal enabled
// When regInit true, initialize all registers to 0 (avoids using for-loop)
always@(posedge clk) 
begin
    if(regWrite)
        regFile[writeReg] <= writeData;
	/*if (regInit) begin
	    regFile[31] <= 32'h00000000;
		regFile[30] <= 32'h00000000;
		regFile[29] <= 32'h00000000;
		regFile[28] <= 32'h00000000;
		regFile[27] <= 32'h00000000;
		regFile[26] <= 32'h00000000;
		regFile[25] <= 32'h00000000;
		regFile[24] <= 32'h00000000;
		regFile[23] <= 32'h00000000;
		regFile[22] <= 32'h00000000;
		regFile[21] <= 32'h00000000;
		regFile[20] <= 32'h00000000;
		regFile[19] <= 32'h00000000;
		regFile[18] <= 32'h00000000;
		regFile[17] <= 32'h00000000;
		regFile[16] <= 32'h00000000;
		regFile[15] <= 32'h00000000;
		regFile[14] <= 32'h00000000;
		regFile[13] <= 32'h00000000;
		regFile[12] <= 32'h00000000;
		regFile[11] <= 32'h00000000;
		regFile[10] <= 32'h00000000;
		regFile[9] <= 32'h00000000;
		regFile[8] <= 32'h00000000;
		regFile[7] <= 32'h00000000;
		regFile[6] <= 32'h00000000;
		regFile[5] <= 32'h00000000;
		regFile[4] <= 32'h00000000;
		regFile[3] <= 32'h00000000;
		regFile[2] <= 32'h00000000;
		regFile[1] <= 32'h00000000;
		regFile[0] <= 32'h00000000;
	end */
end

endmodule
