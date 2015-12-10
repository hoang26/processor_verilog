`timescale 1ns/100ps
module processor_tb;

/*
wire ctrl_mem_read, ctrl_mem_write;
wire clk, pc_reset, pc_enable;
wire [31:0] inst_addr;
wire [31:0] instr;
wire [31:0] data_addr;
wire [31:0] data_in;
wire [31:0] data_out;
*/


processor DUT(
	clk,
	pc_reset,
	pc_enable,
	instr,
	data_out,
	data_in,
	inst_addr,
	data_addr,
	ctrl_mem_read,
	ctrl_mem_write
	);


Memory mem(
	inst_addr,
	instr,
	data_addr,
	data_in,
	ctrl_mem_read,
	ctrl_mem_write,
	data_ou
	);

// Initial Conditions
initial begin
    clk=0;
	pc_reset=0;
	pc_enable=1;
end

// Clock
always #5 clk=~clk;

// Input Waveform

endmodule
