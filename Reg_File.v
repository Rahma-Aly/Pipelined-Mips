module Reg_File
#(
    parameter Width = 32,
    parameter depth = 32,
    parameter Address_Width = 5 )
( 
input      [Address_Width-1:0]   A1,A2,A3, //internal registers addresses 
input                            WE3, //write enable
input                            CLK,RST_n, //Control Signals
input      [Width-1:0]           WD3, //write data input port 
output reg [Width-1:0]           RD1,RD2 //Read data output Ports
);

/*------------------------Internal signals----------------------*/
reg [Width-1:0] Register_File [0:depth-1]; //register file
integer Counter;

always @(*)
begin
        RD1=Register_File[A1]; //reaing data from A1 and A2 addresses
        RD2=Register_File[A2];
end

always @(negedge CLK or negedge RST_n)
begin
    if (~RST_n)
        begin
            for(Counter=0;Counter<32;Counter=Counter+1)
                begin
                    Register_File[Counter]<={(Width) {1'b0}}; //resetting all the registers to 0 on the negative edge of the reset signal
                end
        end
    else if (WE3)
                begin
                    Register_File[A3]<=WD3; //writing the data from the input port to A3 address
                end
end

endmodule 