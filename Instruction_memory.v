module Instruction_memory
#(parameter width = 32, parameter depth = 32)
(
input  wire  [width-1:0]    PC,
output wire  [width-1:0]    Instr
);
reg [width-1:0] mem [0:depth-1];

initial 
begin
    $readmemh("Program 3_Machine Code.txt",mem) ;
end


assign  Instr = mem[PC >> 2];

endmodule