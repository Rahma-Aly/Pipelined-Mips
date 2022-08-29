module RegM (
input                   rst_n,
input                   RegWriteE,
input                   MemToRegE,
input                   MemWriteE,
input                   CLK,
input         [31:0]    ALUOutE,
input         [31:0]    WritedataE,
input         [4:0]     WriteRegE,
output reg              RegWriteM,
output reg              MemToRegM,
output reg              MemWriteM,
output reg    [31:0]    ALUOutM,
output reg    [31:0]    WritedataM,
output reg    [4:0]     WriteRegM
);

always@(posedge CLK or negedge rst_n)
begin
    if (~rst_n)
    begin
    RegWriteM <= 1'b0;
    MemToRegM <= 1'b0;
    MemWriteM <= 1'b0;
    ALUOutM   <= 32'b0;
    WritedataM<= 32'b0;
    WriteRegM <= 5'b0;  
    end
    else
    begin
    RegWriteM <= RegWriteE;
    MemToRegM <= MemToRegE;
    MemWriteM <= MemWriteE;
    ALUOutM   <= ALUOutE;
    WritedataM<= WritedataE;
    WriteRegM <= WriteRegE;
    end
end

endmodule