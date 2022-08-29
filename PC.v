module PC(
	input             clk,
	input             rst_n,
	input             EN_n,
	input      [31:0] PC,
	output reg [31:0] PCF
);

always @(posedge clk or negedge rst_n)
	begin
	    if (~rst_n) begin
	        PCF <= 32'b0;
	        end
	    else if (~EN_n) begin
	        PCF <= PC;    
	        end
	end
	
endmodule : PC
