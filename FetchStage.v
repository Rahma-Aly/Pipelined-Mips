module FetchStage(
	input             clk,rst_n,
	input             StallF,
	input             Jump,
	input             PCSrcD,
	input      [31:0] PCBranchD,
	input      [31:0] PCJumpD,
	output     [31:0] InstrF,
	output     [31:0] PCPlus4F
);
/*------------------------Local Parameters-----------------------*/
localparam width = 32,
           depth = 100;

/*------------------------Internal signals----------------------*/
wire  [31:0] PCF,PC1,MUX2_Out;

/*------------------------Module Instantiation----------------------*/
Instruction_memory #(
	    .width(width),
	    .depth(depth)
	) Instruction_memory_instance(
	    .PC(PCF),
	    .Instr(InstrF)
);
	
PC PC_instance(
	    .clk(clk),
	    .rst_n(rst_n),
	    .EN_n(StallF),
	    .PC(PC1),
	    .PCF(PCF)
	);
	
MUX MUX1(
	    .A(PCJumpD),
	    .B(MUX2_Out),
	    .SEL(Jump),
	    .C(PC1)
);
	
MUX MUX2(
	    .A(PCBranchD),
	    .B(PCPlus4F),
	    .SEL(PCSrcD),
	    .C(MUX2_Out)
);
	
Adder ADD4(
	    .A(PCF),
	    .B(32'd4),
	    .Output(PCPlus4F)
);
	
endmodule : FetchStage
