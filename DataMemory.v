module DataMemory #(parameter width = 32)(
	input             clk,
	input             rst_n,
	input      [(width-1):0] Address,
	input      [(width-1):0] WriteData, //Data to be written
	input             W_EN, //write enable
	output     [(width-1):0] ReadData,
	output [15:0] testVal
);

reg [(width-1):0]RAM[0:99];
integer i;


always @(posedge clk, rst_n) begin
    if (~rst_n) begin
        for (i = 0; i<100;i=i+1)
            begin
                RAM[i] <= {(width){1'b0}};
            end
        end
    else if (W_EN) begin
        RAM[Address] = WriteData;
        end    
end
assign   ReadData = RAM[Address];
assign   testVal = RAM[32'b0];

endmodule : DataMemory
