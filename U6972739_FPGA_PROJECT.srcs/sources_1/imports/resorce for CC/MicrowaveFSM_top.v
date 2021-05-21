`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2021 14:28:24
// Design Name: 
// Module Name: MicrowaveFSM_top
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


module MicrowaveFSM_top(
    input wire clk,
    input wire reset,
    input wire enter,
    input wire one,
    input wire two,
    input wire four,
    input wire climate,
    output wire [6:0] ssdCathode,
    output wire [3:0] ssdAnode
    );
    
    wire spot_in;
    wire spot_out;
    
    debouncer debouncer (.clk(clk), .switchIn(enter), .debounceout(spot_in));

    spot spot (.clk(clk),.spot_in(spot_in), .spot_out(spot_out));
    
    FSM FSM (.climate(climate), .clk(clk),.reset(reset), .enter(spot_out),.one(one),.two(two),.four(four),.ssdCathode(ssdCathode),.ssdAnode(ssdAnode));
    
endmodule
