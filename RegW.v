module RegW(
input               CLK,rst_n,
input   [31:0]      ALUOutM,
input   [31:0]      RDM,
input   [4:0]       WriteRegM,
input               RegWriteM,
input               MemToRegM,
output reg          RegWriteW,
output reg          MemToRegW,
output reg [31:0]   ReadDataW,
output reg [31:0]   ALUOutW,
output reg [4:0]    WriteRegW
);

always@(posedge CLK or negedge rst_n)
begin
    if (!rst_n)
    begin
    WriteRegW <= 5'b0;
    RegWriteW <= 1'b0;
    MemToRegW <= 1'b0;
    ALUOutW   <= 32'b0;
    ReadDataW <= 32'b0;
    end
   else
    begin
    WriteRegW <= WriteRegM;
    RegWriteW <= RegWriteM;
    MemToRegW <= MemToRegM;
    ALUOutW   <= ALUOutM;
    ReadDataW <= RDM;
    end
end

endmodule