`timescale 1ns / 1ps

module Dheartbeat(
sysclk,reset,beat
    );
input wire sysclk,reset;
output wire beat;
reg [31:0] counter;
parameter TOPCOUNT = 100_000_000; // 1s
always @ (posedge sysclk) begin
if (reset || counter == TOPCOUNT-1) 
counter <= 32'b0;
else 
counter <= counter + 1;
end
assign beat = (counter == TOPCOUNT-1);

endmodule
