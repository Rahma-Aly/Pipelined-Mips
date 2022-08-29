module Equality (
    input       [31:0]  In1,In2,
    output  reg         Out
);
always @(*)
begin
    Out = (In1==In2)?1:0;
end

endmodule