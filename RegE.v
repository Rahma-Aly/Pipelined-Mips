module RegE (
input               rst_n,
input               RegWriteD,
input               MemToRegD,
input               MemWriteD,
input      [2:0]    ALUControlD,
input               ALUSrcD,
input               RegDstD,
input      [31:0]   RD1D,RD2D,
input      [4:0]    RsD,RtD,RdD,
input      [31:0]   SignImmD,
input               CLK,CLR,
output reg          RegWriteE,
output reg          MemToRegE,
output reg          MemWriteE,
output reg [2:0]    ALUControlE,
output reg          ALUSrcE,
output reg          RegDstE,
output reg [31:0]   RD1E,RD2E,
output reg [4:0]    RsE,RtE,RdE,
output reg [31:0]   SignImmE
);

always@(posedge CLK or negedge rst_n)
begin
    if (CLR | ~rst_n)
        begin
            RegWriteE<=0;
            MemToRegE<=0;
            MemWriteE<=0;
            ALUControlE<=0;
            ALUSrcE<=0;
            RegDstE<=0;
            RD1E<=0;
            RD2E<=0;
            RsE<=0;
            RtE<=0;
            RdE<=0;
            SignImmE<=0;
        end
    else 
        begin
            RegWriteE<=RegWriteD;
            MemToRegE<=MemToRegD;
            MemWriteE<=MemWriteD;
            ALUControlE<=ALUControlD;
            ALUSrcE<=ALUSrcD;
            RegDstE<=RegDstD;
            RD1E<=RD1D;
            RD2E<=RD2D;
            RsE<=RsD;
            RtE<=RtD;
            RdE<=RdD;
            SignImmE<=SignImmD;

        end
end

endmodule