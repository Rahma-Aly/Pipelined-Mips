module Pipelined_MIPS(
	input         clk,
	input         rst_n,
	output [15:0] testVal
);
/*------------------------Internal signals----------------------*/
wire [31:0] Instr_out;

wire [4:0]  RsD_int,
            RtD_int,
            RsE_int,
            RtE_int;
            
wire [4:0]  WriteRegE_int, 
            WriteRegM_int,
            WriteRegW_int;
            
wire [2:0]  ALUControlD_int;

wire [1:0]  ForwardAE_int, 
            ForwardBE_int;

wire        StallF_int, 
            StallD_int,
            FlushE_int;
            
wire        MemToRegD_int, 
            MemToRegE_int,
            MemToRegM_int,
            MemWriteD_int,
            RegWriteW_int,
            RegWriteM_int,
            RegWriteE_int,
            ALUSrcD_int , 
            RegDstD_int,
            JumpD_int, 
            BranchD_int,
            RegWriteD_int;
            
wire        ForwardAD_int, 
            ForwardBD_int;

/*------------------------Module Instantiation----------------------*/
ControlUnit ControlUnit_instance( 
    .Opcode(Instr_out[31:26]),
    .Funct(Instr_out[5:0]),
    .RegWriteD(RegWriteD_int),
    .MemToRegD(MemToRegD_int),
    .MemWriteD(MemWriteD_int),
    .ALUControlD(ALUControlD_int),
    .ALUSrcD(ALUSrcD_int),
    .RegDstD(RegDstD_int),
    .JumpD(JumpD_int),
    .BranchD(BranchD_int)
);

DataPath #(
    .width(32)
) DataPath_instance(
    .Jump(JumpD_int),
    .CLK(clk),
    .RST_n(rst_n),
    .StallF(StallF_int),
    .StallD(StallD_int),
    .BranchD(BranchD_int),
    .ForwardAD(ForwardAD_int),
    .ForwardBD(ForwardBD_int),
    .RegWriteD(RegWriteD_int),
    .MemToRegD(MemToRegD_int),
    .MemWriteD(MemWriteD_int),
    .ALUControlD(ALUControlD_int),
    .ALUSrcD(ALUSrcD_int),
    .RegDstD(RegDstD_int),
    .FlushE(FlushE_int),
    .ForwardAE(ForwardAE_int),
    .ForwardBE(ForwardBE_int),
    .RsD(RsD_int),
    .RtD(RtD_int),
    .RsE(RsE_int),
    .RtE(RtE_int),
    .WriteRegM(WriteRegM_int),
    .MemToRegE(MemToRegE_int),
    .RegWriteW(RegWriteW_int),
    .RegWriteM(RegWriteM_int),
    .MemToRegM(MemToRegM_int),
    .WriteRegE(WriteRegE_int),
    .WriteRegW(WriteRegW_int),
    .testVal(testVal),
    .RegWriteE(RegWriteE_int),
    .Instr(Instr_out)
);	


Hazard_Unit Hazard_Unit_instance(
    .RsD(RsD_int),
    .RtD(RtD_int),
    .BranchD(BranchD_int),
    .JumpD(JumpD_int),
    .StallD(StallD_int),
    .ForwardAD(ForwardAD_int),
    .ForwardBD(ForwardBD_int),
    .RsE(RsE_int),
    .RtE(RtE_int),
    .WriteRegE(WriteRegE_int),
    .RegWriteE(RegWriteE_int),
    .MemtoRegE(MemToRegE_int),
    .FlushE(FlushE_int),
    .ForwardAE(ForwardAE_int),
    .ForwardBE(ForwardBE_int),
    .RegWriteM(RegWriteM_int),
    .MemtoRegM(MemToRegM_int),
    .WriteRegM(WriteRegM_int),
    .WriteRegW(WriteRegW_int),
    .RegWriteW(RegWriteW_int),
    .StallF(StallF_int)
);
endmodule : Pipelined_MIPS
