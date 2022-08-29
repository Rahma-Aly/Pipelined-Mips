module Hazard_Unit (
    //D
    input       [4:0]   RsD,RtD,
    input               BranchD,JumpD,
    output reg          StallD,ForwardAD,ForwardBD,
    //E
    input       [4:0]   RsE,RtE,
    input       [4:0]   WriteRegE,
    input               RegWriteE,
    input               MemtoRegE,
    output reg          FlushE,
    output reg  [1:0]   ForwardAE,ForwardBE,
    //M
    input               RegWriteM,MemtoRegM,
    input       [4:0]   WriteRegM,
    //W
    input       [4:0]   WriteRegW,
    input               RegWriteW,
    //F
    output reg          StallF    
);

/*------------------------Internal signals----------------------*/
reg lwStall,BranchStall;

always @(*)
    begin : Forwarding_A
        if((RsE!=0) && (RsE==WriteRegM) && RegWriteM)
            begin   
                ForwardAE=2'b10;
            end
        else if ((RsE!=0) && (RsE==WriteRegW) && RegWriteW)
            begin
                ForwardAE=2'b01;
            end
        else 
            begin
                ForwardAE=2'b00;
            end
    end
always @(*)
    begin : Forwarding_B_DH
        if((RtE!=0) && (RtE==WriteRegM) && RegWriteM)
            begin   
                ForwardBE=2'b10;
            end
        else if ((RtE!=0) && (RtE==WriteRegW) && RegWriteW)
            begin
                ForwardBE=2'b01;
            end
        else 
            begin
                ForwardBE=2'b00;
            end
    end

always @(*) 
    begin : Stalling_and_Flushing_DH
        lwStall=(((RsD==RtE) || (RtD==RtE)) && (MemtoRegE)) ? 1:0;
        BranchStall=(BranchD && RegWriteE && (WriteRegE==RsD || WriteRegE==RtD)) || (BranchD && MemtoRegM && (WriteRegM==RsD || WriteRegM==RtD));
        StallF = lwStall | BranchStall;
        StallD = lwStall | BranchStall;
        FlushE = lwStall | BranchStall | JumpD;
    end

always @(*)
    begin 
        ForwardAD=(RsD!=0) && (RsD==WriteRegM) && RegWriteM;
        ForwardBD=(RtD!=0) && (RtD==WriteRegM) && RegWriteM;
    end


endmodule