`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2026 10:10:18
// Design Name: 
// Module Name: spi_master
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spi_master(input clk,
                  input rst,
                  input start,
                  input [7:0]data,
                  input miso,
                  output reg mosi,
                  output reg sclk,
                  output reg ss,
                  output reg[7:0] data_out,
                  output reg done);
reg[2:0] bit_cnt;
reg [7:0] shift_reg;
reg[7:0] recv_reg;

parameter IDEL=0,
          LOAD=1,
          TRANSFER=2,
          DONE=3;    
 reg [1:0] state;      
 always@(posedge clk or posedge rst)begin
 if(rst)begin
 sclk<=0;
 mosi<=0;
 ss<=1;
 done<=0;
state<=IDEL;
bit_cnt<=0;
shift_reg<=0;
recv_reg<=0;
data_out<=0;
end   
else begin
case(state)
IDEL:begin
ss<=1;
done<=0;
if(start)begin
state<=LOAD;
end 
else
 state<=IDEL;
 end
 LOAD:begin
 ss<=0;
 sclk=0;
 shift_reg<=data;
 bit_cnt<=3'd7;
 state<=TRANSFER;
 end    
 TRANSFER:begin
 sclk<=~sclk;
 if(sclk==0)begin
 mosi<=shift_reg[bit_cnt];
 end
 else begin
 recv_reg[bit_cnt]<=miso;
 if(bit_cnt==0)begin
 state<=DONE;                 
 end
 else begin
 bit_cnt <=bit_cnt-1;
 state<=TRANSFER;
 end
 end
 end
DONE:begin
ss<=1;
done<=1;
data_out<=recv_reg;
state<=IDEL;
end
endcase
end
end         
endmodule
