module Shifter #(parameter width=32 )
(
input       [width-1:0]  Shift_in,
output reg  [31:0]       Shift_out
);

always @(*)
    begin
        Shift_out = Shift_in<<2;
    end

endmodule