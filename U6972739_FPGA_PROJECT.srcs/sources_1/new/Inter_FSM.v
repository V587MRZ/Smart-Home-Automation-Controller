`timescale 1ns / 1ps

module Inter_FSM(
output reg [2:0] index,
input wire switch, 
output reg door,
output reg light, 
output reg climate,
input wire reset,
input wire sysclk
    );
reg [2:0] state, nextstate;
parameter IDLE = 3'b000, DOOR = 3'b001, LIGHT = 3'b011, CLIMATE = 3'b010, PARA= 3'b111;
always @(posedge sysclk) begin
if (reset)
state <= IDLE;
else 
state <= nextstate; end

always @(*) begin
case (state)
IDLE: begin
if (switch) nextstate = DOOR;
else nextstate = IDLE; end
 
DOOR: begin
if (switch) nextstate = LIGHT;
else nextstate = DOOR; end

LIGHT: begin
if (switch) nextstate = CLIMATE;
else nextstate = LIGHT; end

CLIMATE: begin
if (switch) nextstate = PARA;
else nextstate = CLIMATE; end

PARA: begin
if (switch) nextstate = IDLE;
else nextstate = PARA; end
endcase end

always @(*) begin
case (state)
IDLE: begin
door = 0;
light = 0;
climate = 0;
index = 3'b0;
end 
DOOR: begin
door = 1'b1;
light = 0;
climate = 0;
index = 3'b001;
end 

LIGHT: begin
door = 0;
light = 1'b1;
climate = 0;
index = 3'b010;
end 

CLIMATE: begin
door = 0;
light = 0;
climate = 1'b1;
index = 3'b100;
end 

PARA: begin
door = 1'b1;
light = 1'b1;
climate = 1'b1;
index = 3'b111;
end 
endcase end

endmodule
