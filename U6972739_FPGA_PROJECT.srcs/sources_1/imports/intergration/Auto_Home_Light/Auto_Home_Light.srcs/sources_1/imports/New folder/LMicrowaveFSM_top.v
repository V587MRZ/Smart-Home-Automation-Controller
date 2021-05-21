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


module LMicrowaveFSM_top(
    input wire clk,
    input wire reset,
    input wire enter,
    input wire dark,
    input wire entering,
    input wire motion,
    input wire master_off,
    input wire master_on,
    output wire LED_bath,
    output wire LED_out,
    input wire light
    );
    
    wire spot_in;
    wire spot_out;
    
    Ldebouncer debouncer (.clk(clk), .switchIn(enter), .debounceout(spot_in));

    Lspot spot (.clk(clk),.spot_in(spot_in), .spot_out(spot_out));
    
    LFSM LFSM (.light(light), .clk(clk),.reset(reset),.enter(spot_out),.dark(dark),.entering(entering),.motion(motion),.master_off(master_off),.master_on(master_on), .LED_bath(LED_bath),.LED_out(LED_out));
    
endmodule
