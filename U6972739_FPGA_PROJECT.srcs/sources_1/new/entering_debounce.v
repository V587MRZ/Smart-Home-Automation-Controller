`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2021 04:05:44 PM
// Design Name: 
// Module Name: entering_debounce
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


module entering_debounce(
input wire reset, 
input wire sysclk, 
input wire switch, 
output wire spot_outswitch
    );

wire beat;
reg [2:0] deb;
reg A;
Dheartbeat #(.TOPCOUNT(6600_000)) hb( .sysclk(sysclk), .reset(reset), .beat(beat));
always @(posedge sysclk) begin
if (beat) begin
deb[0] <= switch;
deb[1] <= deb[0];
deb[2] <= deb[1]; end
A <= &deb; end

assign spot_outswitch = ~A & (&deb);
endmodule