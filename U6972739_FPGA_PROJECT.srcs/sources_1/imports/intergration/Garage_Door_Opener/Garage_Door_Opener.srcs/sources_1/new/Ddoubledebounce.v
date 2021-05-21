`timescale 1ns / 1ps
module Ddoubledebounce(
input wire RC,
input wire CS,

//switchIn
input wire clk,
input wire reset,
output wire spot_outRC,
output wire spot_outCS
);
wire debounceoutRC;
wire debounceoutCS;
wire beat;
Dheartbeat #(
.TOPCOUNT(6600_000)//66ms
) debouncebeat (
.sysclk(clk),
.reset(reset),
//.enable(1'b1),//!!!!!!!!!!!!!
.beat(beat)
);

reg[2:0] pipelineRC;
reg[2:0] pipelineCS;


always @(posedge clk) begin
if (beat) begin
pipelineRC[0] <= RC;
pipelineRC[1] <= pipelineRC[0];
pipelineRC[2] <= pipelineRC[1];
pipelineCS[0] <= CS;
pipelineCS[1] <= pipelineCS[0];
pipelineCS[2] <= pipelineCS[1];
end end
assign debounceoutRC = &pipelineRC;
assign debounceoutCS = &pipelineCS;

reg N,E;
always @ (posedge clk)begin
N <= &pipelineRC;
E <= &pipelineCS;
end

assign spot_outRC = ~N & debounceoutRC;
assign spot_outCS = ~E & debounceoutCS;


endmodule
