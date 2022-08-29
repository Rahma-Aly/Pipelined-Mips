module RegF(
input               CLK,EN,CLR, rst_n, //control signals
input       [31:0]  RDF,
input       [31:0]  PCPlus4F,
output reg  [31:0]  InstrD,
output reg  [31:0]  PCPlus4D
);

always@(posedge CLK or negedge rst_n)
begin
    if (~rst_n)
        begin
            InstrD =32'd0;
            PCPlus4D<=32'd0;
        end
    else if(CLR && ~EN)
        begin
            InstrD =32'd0;
            PCPlus4D<=PCPlus4F;
        end
    else if (~EN)
        begin
            InstrD<=RDF;
            PCPlus4D<=PCPlus4F;
        end
end

endmodule