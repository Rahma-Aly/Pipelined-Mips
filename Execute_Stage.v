module Execute_stage (
    input   wire    [31:0]      RD1E,RD2E,
    input   wire    [4:0]       RtE,RdE,
    input   wire    [31:0]      aluOutE,ResultE,
    input   wire    [31:0]      SignalmmE,
    input   wire    [1:0]       ForwardAE,ForwardBE,
    input   wire                RegDstE,ALUSrcE,
    input   wire    [2:0]       ALUControlE,
    output  wire    [31:0]      ALUOUTE,WriteDataE,
    output  wire    [4:0]       WriteRegE
);
/*------------------------Internal signals----------------------*/
wire    [31:0]      SrcAE,SrcBE;

/*------------------------Module Instantiation----------------------*/
MUX #(.width(5)) M1 ( //WriteRegE MUX
    .A(RdE),
    .B(RtE),
    .C(WriteRegE),
    .SEL(RegDstE)
);

MUX4x1 M2 ( //SRCAE ALU MUX
    .A(RD1E),
    .B(ResultE),
    .C(aluOutE),
    .D(32'd0),
    .SEL(ForwardAE),
    .OUT(SrcAE)
);

MUX4x1 M3 ( //MUX before SrcBE ALU Mux
    .A(RD2E),
    .B(ResultE),
    .C(aluOutE),
    .D(32'd0),
    .SEL(ForwardBE),
    .OUT(WriteDataE)
);

MUX #(.width(32)) M4 ( //SrCBE MUX
    .A(SignalmmE),
    .B(WriteDataE),
    .C(SrcBE),
    .SEL(ALUSrcE)
);

ALU A1 (
    .SrcAE(SrcAE),
    .SrcBE(SrcBE),
    .ALUControlE(ALUControlE),
    .ALUOutE(ALUOUTE)
);
endmodule