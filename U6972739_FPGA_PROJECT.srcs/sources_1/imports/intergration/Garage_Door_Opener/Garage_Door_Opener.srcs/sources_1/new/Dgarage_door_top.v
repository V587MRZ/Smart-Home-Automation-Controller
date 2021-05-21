`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


module Dgarage_door_top(
input wire remote_control,
input wire collision_sensor,
output wire [9:0] LEDs,
output wire Motor,
input wire sysclk,
input wire reset,
input wire door
    );
wire RC_deb;
wire CS_deb;
wire reset_out;
Dreset_btn rst(.sysclk(sysclk), .btn_in(reset), .reset_out(reset_out));
Ddoubledebounce deb(.RC(remote_control), .CS(collision_sensor), .clk(sysclk), .reset(reset_out), .spot_outRC(RC_deb), .spot_outCS(CS_deb));
DFSM fsm(.door(door), .RC_deb(RC_deb), .CS_deb(CS_deb), .sysclk(sysclk), .reset(reset_out), .Motor(Motor), .LEDs(LEDs) );
endmodule
