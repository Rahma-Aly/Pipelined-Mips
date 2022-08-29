module ALU(
input       [31:0]  SrcAE,SrcBE,
input       [2:0]   ALUControlE,
output  reg [31:0]  ALUOutE
);

always@(*)
begin
    case (ALUControlE)
        3'b000: //AND
            ALUOutE = SrcAE & SrcBE;
        3'b001: //OR
            ALUOutE = SrcAE | SrcBE;
        3'b010: //plus
            ALUOutE = SrcAE + SrcBE;
        3'b100: //minus
            ALUOutE = SrcAE - SrcBE;
        3'b101: //multiplication
            ALUOutE = SrcAE * SrcBE;
        3'b110: //SLT
            begin
                if(SrcAE<SrcBE)
                    ALUOutE = 32'b1;
                else 
                    ALUOutE = 32'b0;
            end
        default: ALUOutE = 32'b0;
    endcase
end

endmodule