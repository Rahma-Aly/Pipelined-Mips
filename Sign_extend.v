module Sign_extend(
input        [15:0]   Instr,
output reg   [31:0]   SignImm
);

always@(*)
    begin
        SignImm={{16 {Instr[15]}},Instr};
    end

endmodule