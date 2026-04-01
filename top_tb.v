`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2026 14:14:46
// Design Name: 
// Module Name: top_tb
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


module top_tb();
reg clk,rst,start;
reg[7:0]master_data_in;
wire[7:0]master_recived;
wire[7:0]slave_recived;
wire mosi,miso,sclk,ss,done;

spi_master maste(.clk(clk),.rst(rst),.start(start),.data(master_data_in),.miso(miso),.mosi(mosi),.sclk(sclk),.ss(ss),.data_out(master_recived),.done(done));
spi_slave slave(.sclk(sclk),.rst(rst),.ss(ss),.mosi(mosi),.miso(miso),.slave_recived(slave_recived));
always#5 clk=~clk;
initial begin
clk=0;rst=1;start=0;
master_data_in =8'b00000000;
$monitor("MASTER RECIVED DATA:%b||SLAVE RECIVED:%b",master_recived,slave_recived);
#20 rst=0;
master_data_in=8'b11111111;
start=1;
#10;start=0;
wait(done);
#10;
master_data_in=8'b01101101;
start=1;
#10;start=0;
wait(done);
#50 $finish;
end
endmodule
