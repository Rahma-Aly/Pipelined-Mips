module Adder(
input      [31:0] A,
input      [31:0] B,
output reg [31:0] Output

);
always@(*)
begin
    Output = A + B;
end
	
endmodule : Adder
