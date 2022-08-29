module MUX4x1 (
input   wire    [31:0]  A,
input   wire    [31:0]  B,
input   wire    [31:0]  C,
input   wire    [31:0]  D,
input   wire    [1:0]   SEL,
output  reg     [31:0]  OUT

);

always@(*)
begin
    case(SEL)
        2'b00: OUT = A;
        2'b01: OUT = B;
        2'b10: OUT = C;
        default: OUT = 32'd0;
    endcase
end



endmodule