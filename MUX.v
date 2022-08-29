module MUX #( parameter  width = 32)(
input   wire    [width - 1:0]  A, //1
input   wire    [width - 1:0]  B, //0
input   wire                   SEL,
output  reg     [width - 1:0]  C
);

always@(*)
begin
    if(SEL)
        C = A;
    else
        C = B;    
end
endmodule