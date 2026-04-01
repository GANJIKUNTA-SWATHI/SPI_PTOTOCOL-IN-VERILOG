`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2026 11:59:33
// Design Name: 
// Module Name: spi_top
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


module spi_top (
    input clk,
    input rst,
    input start,
    input [7:0] master_data_in,
    output [7:0] master_data_out,
    output [7:0] slave_received,
    output done
);
    wire mosi;
    wire miso;
    wire sclk;
    wire ss;

    spi_master master (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data(master_data_in),
        .miso(miso),
        .mosi(mosi),
        .sclk(sclk),
        .ss(ss),
        .data_out(master_data_out),
        .done(done)
    );

    spi_slave slave (
        .sclk(sclk),
        .rst(rst),
        .ss(ss),
        .mosi(mosi),
        .miso(miso),
        .slave_recived(slave_received)
    );

endmodule

