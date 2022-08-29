module Decode_Stage (
    input               RegWriteD, //RegWrite in the write back stage
    input               CLKD,RST_nD,
    input               BranchD,
    input       [31:0]  InstrD,
    input       [31:0]  ALUOutD, //ALUOutM in the memory stage
    input       [31:0]  PCPlus4D,
    input       [4:0]   WriteRegD, //WriteRegW in the write back stage
    input       [31:0]  ResultD, //ResultW in the write back stage
    input               ForwardAD,ForwardBD,

    output      [31:0]  RD1D,RD2D,
    output      [31:0]  PCBranchD,PCJumpD,
    output      [31:0]  SignImmD,
    output      [4:0]   RsD,RtD,RdD,
    output              PCSrcD
);
/*------------------------Internal signals----------------------*/
wire [31:0] MUX1_OUT,MUX2_OUT;
wire [31:0] Shifter_output;
wire        EqualD;
wire [31:0] PCJumpD_int;

/*------------------------Assign statements-----------------------*/
assign PCSrcD  = BranchD & EqualD;
assign RsD     = InstrD[25:21];
assign RtD     = InstrD[20:16];
assign RdD     = InstrD[15:11];
assign PCJumpD = {PCPlus4D[31:28],InstrD[25:0],2'b00};

/*------------------------Module Instantiation----------------------*/
Reg_File R1 (
    .A1(InstrD[25:21]),
    .A2(InstrD[20:16]),
    .A3(WriteRegD),
    .WE3(RegWriteD),
    .CLK(CLKD),
    .RST_n(RST_nD),
    .WD3(ResultD),
    .RD1(RD1D),
    .RD2(RD2D)
);

MUX M1 (
    .A(ALUOutD),
    .B(RD1D),
    .C(MUX1_OUT),
    .SEL(ForwardAD)
);

MUX M2 (
    .A(ALUOutD),
    .B(RD2D),
    .C(MUX2_OUT),
    .SEL(ForwardBD)
);

Equality E1 (
    .In1(MUX1_OUT),
    .In2(MUX2_OUT),
    .Out(EqualD)
);

Sign_extend S1 (
    .Instr(InstrD[15:0]),
    .SignImm(SignImmD)
);

Shifter S11 (
    .Shift_in(SignImmD),
    .Shift_out(Shifter_output)
);

Adder A1 (
    .A(PCPlus4D),
    .B(Shifter_output),
    .Output(PCBranchD)
);

Shifter #(.width(26)) S2
(
    .Shift_in(InstrD[25:0]),
    .Shift_out(PCJumpD_int)
);


endmodule