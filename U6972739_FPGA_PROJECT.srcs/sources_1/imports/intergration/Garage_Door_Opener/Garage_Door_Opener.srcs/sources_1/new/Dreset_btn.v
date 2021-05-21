`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Dreset_btn(
input wire btn_in,
input wire sysclk,
output reg reset_out);

reg [1:0] ffsync;

 always @(posedge sysclk) begin
 ffsync[0]<=btn_in; //synchroniser. Why not use a debouncer for the reset?
 ffsync[1]<=ffsync[0];
 reset_out<=ffsync[1];
 end

 endmodule
