`timescale 1ns / 1ps

module Ldebouncer (
input wire switchIn,
input wire clk,
input wire reset,
output wire debounceout);

//you write the code!
wire beat; 
reg[2:0] pipeline;

heartbeat #(
.TOPCOUNT(1_000_000)
) debouncebeat (
.clk(clk),
.reset(reset),
.beat(beat)
);

always @(posedge clk) begin
	if (beat) begin
		pipeline[0] <= switchIn;
		pipeline[1] <= pipeline[0];
		pipeline[2] <= pipeline[1];
	end
end

assign debounceout = &pipeline; //note cool syntax!

endmodule
