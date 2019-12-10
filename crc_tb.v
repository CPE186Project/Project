`timescale 1ns/100ps

module LCRC_TB;

reg [207:0] data_in;
reg crc_en;
reg rst;
reg clk;
wire [31:0] crc_out;

   
crc UUT(data_in, crc_en, crc_out, rst, clk);
   
initial
begin
    clk = 0;  //Intialize
    rst = 0;
    crc_en = 1;
data_in = 16'h0;
#20;

        rst = 1;  // Test reset condition
        #20;

rst = 0;
crc_en = 0;  // Test CRC disable condition
data_in = 208h'ABCD_FFFF_BBBB_FFFF_DDDD;
#20;

crc_en = 1;  // Test CRC_out
#20;  
end

always #10 clk = ~clk;
   
endmodule
