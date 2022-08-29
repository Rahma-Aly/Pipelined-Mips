module DataPath #(parameter width = 32)
(
    input              Jump,
    input              CLK,
    input              RST_n,
    input              StallF,
    input              StallD,
    input              BranchD,
    input              ForwardAD,
    input              ForwardBD,
    input              RegWriteD,
    input              MemToRegD,
    input              MemWriteD,
    input  [2:0]       ALUControlD,
    input              ALUSrcD,
    input              RegDstD,
    input              FlushE,
    input  [1:0]       ForwardAE,ForwardBE,
    output [4:0]       RsD,RtD,
    output [4:0]       RsE,RtE,
    output [4:0]       WriteRegM,WriteRegW,WriteRegE,
    output             RegWriteW,RegWriteM,MemToRegE, MemToRegM,RegWriteE,
    output [15:0]      testVal,
    output [width-1:0] Instr
);
/*-----------------------Internal Signals-----------------------*/
wire                    PCSrcD_int;
wire [width-1:0]        PCBranchD_int;
wire [width-1:0]        PCPlus4F_int;
wire [width-1:0]        PCPlus4D_int;
wire [width-1:0]        PCJumpD_int;
wire [width-1:0]        InstrF_int;
wire [width-1:0]        ALUOutD_int;
wire [width-1:0]        ResultD_int;
wire [width-1:0]        RD1D_int,RD2D_int;
wire [width-1:0]        SignImmD_int;
wire ClearD;
wire                    MemWriteE_int;
wire [2:0]              ALUControlE_int;
wire                    ALUSrcE_int;
wire                    RegDstE_int;
wire [width-1:0]        RD1E_int,RD2E_int;
wire [4:0]              RdD_int;
wire [4:0]              RdE_int;
wire [width-1:0]        SignImmE_int;
wire [width-1:0]        ALUOUTE_int; //ALU output
wire [width-1:0]        WriteDataE_int;
wire                    MemToRegW_int;
wire                    MemWriteM_int;
wire [width-1:0]        ReadDataW_int;
wire [width-1:0]        WritedataM_int;
wire [width-1:0]        ReadDataM_int;
wire [width-1:0]        ALUOutW_int;

/*-----------------------Assign statements-----------------------*/
assign ClearD = (Jump | PCSrcD_int);
/*-----------------------Module Instantiation----------------------*/
FetchStage U_F1 (
    .clk(CLK),
    .rst_n(RST_n),
    .StallF(StallF),
    .Jump(Jump),
    .PCSrcD(PCSrcD_int),
    .PCBranchD(PCBranchD_int),
    .PCJumpD(PCJumpD_int),
    .InstrF(InstrF_int),
    .PCPlus4F(PCPlus4F_int)
);

RegF U_REGF (
    .rst_n(RST_n),
    .CLK(CLK),
    .EN(StallD),
    .CLR(ClearD), 
    .RDF(InstrF_int),
    .PCPlus4F(PCPlus4F_int),
    .InstrD(Instr),
    .PCPlus4D(PCPlus4D_int)
);

Decode_Stage Decode_Stage_instance(
    .RegWriteD(RegWriteW),
    .CLKD(CLK),
    .RST_nD(RST_n),
    .BranchD(BranchD),
    .InstrD(Instr),
    .ALUOutD(ALUOutD_int),
    .PCPlus4D(PCPlus4D_int),
    .WriteRegD(WriteRegW),
    .ResultD(ResultD_int),
    .ForwardAD(ForwardAD),
    .ForwardBD(ForwardBD),
    .RD1D(RD1D_int),
    .RD2D(RD2D_int),
    .RsD(RsD),
    .RtD(RtD),
    .RdD(RdD_int),
    .PCBranchD(PCBranchD_int),
    .PCJumpD(PCJumpD_int),
    .SignImmD(SignImmD_int),
    .PCSrcD(PCSrcD_int)
);

RegE U_REGE (
.rst_n(RST_n),
.RegWriteD(RegWriteD),
.MemToRegD(MemToRegD),
.MemWriteD(MemWriteD),
.ALUControlD(ALUControlD),
.ALUSrcD(ALUSrcD),
.RegDstD(RegDstD),
.RD1D(RD1D_int),
.RD2D(RD2D_int),
.RsD(RsD),
.RtD(RtD),
.RdD(RdD_int),
.SignImmD(SignImmD_int),
.CLK(CLK),
.CLR(FlushE),
.RegWriteE(RegWriteE),
.MemToRegE(MemToRegE),
.MemWriteE(MemWriteE_int),
.ALUControlE(ALUControlE_int),
.ALUSrcE(ALUSrcE_int),
.RegDstE(RegDstE_int),
.RD1E(RD1E_int),
.RD2E(RD2E_int),
.RsE(RsE),
.RtE(RtE),
.RdE(RdE_int),
.SignImmE(SignImmE_int)
);


Execute_stage Excute_stage_instance(
        .RD1E(RD1E_int),
        .RD2E(RD2E_int),
        .RtE(RtE),
        .RdE(RdE_int),
        .aluOutE(ALUOutD_int),
        .ResultE(ResultD_int),
        .SignalmmE(SignImmE_int),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .RegDstE(RegDstE_int),
        .ALUSrcE(ALUSrcE_int),
        .ALUControlE(ALUControlE_int),
        .ALUOUTE(ALUOUTE_int),
        .WriteDataE(WriteDataE_int),
        .WriteRegE(WriteRegE)
);

RegM RegM_instance(
        .rst_n(RST_n),
        .RegWriteE(RegWriteE),
        .MemToRegE(MemToRegE),
        .MemWriteE(MemWriteE_int),
        .CLK(CLK),
        .ALUOutE(ALUOUTE_int),
        .WritedataE(WriteDataE_int),
        .WriteRegE(WriteRegE),
        .RegWriteM(RegWriteM),
        .MemToRegM(MemToRegM),
        .MemWriteM(MemWriteM_int),
        .ALUOutM(ALUOutD_int),
        .WritedataM(WritedataM_int),
        .WriteRegM(WriteRegM)
    );

MemoryStage MemoryStage_instance(
    .clk(CLK),
    .rst_n(RST_n),
    .ALUOutM(ALUOutD_int),
    .WriteDataM(WritedataM_int),
    .MemWriteM(MemWriteM_int),
    .ReadDataM(ReadDataM_int),
    .testVal(testVal)
);

RegW RegW_instance(
    .rst_n(RST_n),
    .CLK(CLK),
    .ALUOutM(ALUOutD_int),
    .RDM(ReadDataM_int),
    .WriteRegM(WriteRegM),
    .RegWriteM(RegWriteM),
    .MemToRegM(MemToRegM),
    .RegWriteW(RegWriteW),
    .MemToRegW(MemToRegW_int),
    .ReadDataW(ReadDataW_int),
    .ALUOutW(ALUOutW_int),
    .WriteRegW(WriteRegW)
);

WriteBackStage WriteBackStage_instance(
    .MemToRegW(MemToRegW_int),
    .ReadDataW(ReadDataW_int),
    .ALUOutW(ALUOutW_int),
    .ResultW(ResultD_int)
);


endmodule