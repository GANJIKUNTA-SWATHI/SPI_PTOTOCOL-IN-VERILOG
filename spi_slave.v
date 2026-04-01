`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2026 11:50:25
// Design Name: 
// Module Name: spi_slave
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


module spi_slave(input sclk,
                 input rst,
                 input ss,
                 input mosi,//master data
                 output reg miso,
                 output reg [7:0] slave_recived//master data
                  );
reg [7:0] shift_in;//to store data from master
reg [7:0] shift_out = 8'b11011001;//data to send to master
reg[2:0] bit_cnt;
always @(negedge ss or posedge rst)begin
if(rst)begin
bit_cnt<=3'd7;
miso<=0;
end
else begin
bit_cnt<=3'd7;
miso<=shift_out[7];
end
end
always @(posedge sclk or posedge rst) begin
if(rst) begin
shift_in<=0;
slave_recived<=0;
bit_cnt<=7;
end
else if(!ss) begin
shift_in[bit_cnt]<=mosi;
if(bit_cnt==0) begin
slave_recived<={shift_in[7:1],mosi};
end
else if(bit_cnt>0)
bit_cnt<=bit_cnt-1;
end
end
always @(negedge sclk or posedge rst)begin
if (rst)begin
miso<=0;
end
else if(!ss) begin
miso<=shift_out[bit_cnt];//sending data to master
 end
 else
 miso<=0;
end 
endmodule