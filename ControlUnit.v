module ControlUnit(
	input      [5:0] Opcode,
	input      [5:0] Funct,
	output reg       RegWriteD,
	output reg       MemToRegD,
	output reg       MemWriteD,
	output reg [2:0] ALUControlD,
	output reg       ALUSrcD,
	output reg       RegDstD,
	output reg       JumpD,
	output reg       BranchD
);
localparam LoadWord  = 6'b100011,
           StoreWord = 6'b101011,
           RType     = 6'b000000,
           Addi      = 6'b001000,
           Beq       = 6'b000100,
           J         = 6'b000010;
/*------------------------Internal signals----------------------*/
 reg [1:0]  ALUOpD;
      
always @(*)
	begin
	    case (Opcode)
	    LoadWord: begin
	     RegWriteD = 1'b1;
         MemToRegD = 1'b1;
         MemWriteD = 1'b0;
         ALUSrcD   = 1'b1;
         RegDstD   = 1'b0;
         JumpD     = 1'b0;
         BranchD   = 1'b0;
         ALUOpD    = 2'b0; 
         end
        StoreWord: begin
         RegWriteD = 1'b0;
         MemToRegD = 1'b1;
         MemWriteD = 1'b1;
         ALUSrcD   = 1'b1;
         RegDstD   = 1'b0;
         JumpD     = 1'b0;
         BranchD   = 1'b0;
         ALUOpD    = 2'b0;
        end
         RType: begin
         RegWriteD = 1'b1;
         MemToRegD = 1'b0;
         MemWriteD = 1'b0;
         ALUSrcD   = 1'b0;
         RegDstD   = 1'b1;
         BranchD   = 1'b0;
         JumpD     = 1'b0;
         ALUOpD    = 2'b10;
         end
         Addi: begin
         RegWriteD = 1'b1;
         MemToRegD = 1'b0;
         MemWriteD = 1'b0;
         ALUSrcD   = 1'b1;
         RegDstD   = 1'b0;
         JumpD     = 1'b0;
         BranchD   = 1'b0;
         ALUOpD    = 2'b0;
         end
         Beq: begin
         RegWriteD = 1'b0;
         MemToRegD = 1'b0;
         MemWriteD = 1'b0;
         ALUSrcD   = 1'b0;
         RegDstD   = 1'b0;
         JumpD     = 1'b0;
         BranchD   = 1'b1;
         ALUOpD    = 2'b01;
        end
        J: begin
         RegWriteD = 1'b0;
         MemToRegD = 1'b0;
         MemWriteD = 1'b0;
         ALUSrcD   = 1'b0;
         RegDstD   = 1'b0;
         JumpD     = 1'b1;
         BranchD   = 1'b0;
         ALUOpD    = 2'b0;
         end
        default: begin
         RegWriteD = 1'b0;
         MemToRegD = 1'b0;
         MemWriteD = 1'b0;
         ALUSrcD   = 1'b0;
         RegDstD   = 1'b0;
         JumpD     = 1'b0;
         BranchD   = 1'b0;
         ALUOpD    = 2'b0;
        end
	    endcase       
	end
always @(*)
	begin : ALU_Control
	case (ALUOpD)
	    2'b00: ALUControlD = 3'b010;
	    2'b01: ALUControlD = 3'b100;
	    2'b10: begin
	        if (Funct == 6'b10_0000)      ALUControlD = 3'b010; //ADD
	        else if (Funct == 6'b10_0010) ALUControlD = 3'b100; //SUB
	        else if (Funct == 6'b10_1010) ALUControlD = 3'b110; //SLT
	        else if (Funct == 6'b01_1100) ALUControlD = 3'b101;  //MUL
	        end
	    default: ALUControlD = 3'b010;    
	endcase
	end
	
endmodule : ControlUnit
