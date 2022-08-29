module MemoryStage(
	input              clk,
	input              rst_n,
	input       [31:0] ALUOutM, 
	input  [31:0] WriteDataM,
	input          MemWriteM,
	output  [31:0] ReadDataM,
	output  [15:0] testVal
	
);

/*------------------------Local Parameters----------------------*/
localparam width = 32;

DataMemory #(.width(width)) DataMemory_instance
(
	    .clk(clk),
	    .rst_n(rst_n),
	    .Address(ALUOutM),
	    .WriteData(WriteDataM),
	    .W_EN(MemWriteM),
	    .ReadData(ReadDataM),
	    .testVal(testVal)
);
endmodule : MemoryStage
