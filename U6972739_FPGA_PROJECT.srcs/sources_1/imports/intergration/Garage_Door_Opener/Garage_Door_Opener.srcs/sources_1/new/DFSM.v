`timescale 1ns / 1ps

module DFSM(
input wire RC_deb,
input wire CS_deb,
output reg Motor,
output reg [9:0] LEDs,
input wire sysclk,
input wire reset,
input wire door
    );
reg [2:0] state, nextstate;
wire beat;
parameter IDLE = 3'b000,OPENING = 3'b001, OPEN_SUS = 3'b010, OPEN = 3'b011, CLOSING = 3'b111, CLOSE_SUS = 3'b110;
reg [9:0] ledcount;
always @ (posedge sysclk) begin
if (reset)
state <= IDLE;
else if (door)
state <= nextstate; end

always @(*) begin
case(state)
IDLE: begin
if(RC_deb) nextstate = OPENING; 
else nextstate=IDLE;
end
OPENING: begin
if(RC_deb) nextstate= OPEN_SUS; 
else if (&(~ledcount)) nextstate = OPEN;
else if (CS_deb) nextstate = CLOSING;
else nextstate=OPENING;
end

OPEN_SUS: begin
if (RC_deb) nextstate= OPENING; 
else nextstate=OPEN_SUS;  end

OPEN: begin
if (RC_deb) nextstate= CLOSING; 
else nextstate=OPEN;
end

CLOSING: begin
if (RC_deb) nextstate = CLOSE_SUS; 
else if (&ledcount) nextstate = IDLE;
else if (CS_deb) nextstate = OPENING;
else nextstate=CLOSING; end

CLOSE_SUS: begin
if(RC_deb) nextstate= CLOSING; 
else nextstate=CLOSE_SUS; 

end 
default: nextstate = IDLE;
endcase end

Dheartbeat #(.TOPCOUNT(100_000_000)) HB(.sysclk(sysclk), .reset(reset), .beat(beat));



always @(*) begin
case(state)
IDLE: begin
LEDs = ledcount;
Motor = 1'b0; end
OPENING: begin
LEDs = ledcount;
Motor = 1'b1; end
OPEN_SUS: Motor = 1'b0;
OPEN: begin
Motor = 1'b0; end
CLOSING: begin
LEDs = ledcount;
Motor = 1'b1; end
CLOSE_SUS: Motor = 1'b0;
default: LEDs = 10'b0;  
endcase end

always @(posedge sysclk) begin
case(state)
IDLE: 
ledcount <= 10'b1111111111;
OPENING: 
if (beat) ledcount <= ledcount >> 1;
OPEN: ledcount <= 0;
CLOSING:
if (beat) ledcount <= {ledcount[8:0],1'b1};

default:;
endcase end
endmodule 


