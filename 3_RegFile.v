module RegFile(clk, readaddr1, readaddr2, read_output1, read_output2, writeaddr, write_data, write_enable);


input wire [4:0] readaddr1;
input wire [4:0] readaddr2;
input wire [4:0] writeaddr;
input wire [31:0] write_data;
input wire write_enable;
input wire clk;

output reg [31:0] read_output1;
output reg [31:0] read_output2;

// No need to use Mux's to select register to read/write (e.g. use regFile[addr] to access individual registers

// Initalize internal regFile to 0 in all registers

reg [31:0] regFile [0:31];
integer increment;

initial begin
    for (increment = 0; increment<32; increment=increment+1) begin
        regFile[increment] <= 0;
    end
end


always@(posedge clk)

// Set all to nonblocking
begin
    if (write_enable)
	regFile[writeaddr] <= write_data;

// Addresses being read every clock cycle
    read_output1 <= regFile[readaddr1];
    read_output2 <= regFile[readaddr2];

end
endmodule
