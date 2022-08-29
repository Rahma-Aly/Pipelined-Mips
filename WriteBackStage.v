module WriteBackStage(
	input             MemToRegW,
	input      [31:0] ReadDataW,
	input      [31:0] ALUOutW,
	output     [31:0] ResultW
);

MUX MUX_instance(
	    .A(ReadDataW),
	    .B(ALUOutW),
	    .SEL(MemToRegW),
	    .C(ResultW)
);
	
endmodule : WriteBackStage