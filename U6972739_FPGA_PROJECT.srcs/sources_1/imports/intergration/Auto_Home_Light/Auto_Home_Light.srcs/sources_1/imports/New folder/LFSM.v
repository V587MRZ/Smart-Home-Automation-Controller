`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2021 14:30:16
// Design Name: 
// Module Name: FSM
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


module LFSM(
    input wire clk,
    input wire reset,
    input wire enter,
    input wire dark,
    input wire entering,
    input wire motion,
    input wire master_off,
    input wire master_on,
    output reg LED_bath,
    output reg LED_out,
    input wire light
    );
    
    
    parameter NIGHT_LIGHT=2'd0, SECURE=2'd1;
    wire beat;
    reg [0:0] night_light_led, secure_led, bathled; 
    reg [4:0] counter, counter1;
    reg [1:0] state, nextstate;
    
        //instantiate heartbeat
    Lheartbeat #(.TOPCOUNT(100_000_000)) heratbeat_generator (.clk(clk),.reset(reset),.beat(beat));
    
        //Current state register/transition block
    always @(posedge clk) begin
        if(reset) state <= NIGHT_LIGHT;
        else if (light) state <= nextstate;
    end
    
    //Next state logic
    always @(*) begin
        case(state)
            NIGHT_LIGHT: begin
                if(enter) nextstate <= SECURE;
                else nextstate <= NIGHT_LIGHT;
            end
            SECURE: begin
                if(enter) nextstate <= NIGHT_LIGHT;
                else nextstate <= SECURE;
            end
            default: nextstate = NIGHT_LIGHT;
        endcase
    end
        
    
    //sequential block for nightlight mode led
    always @(posedge clk) begin
        if(state == NIGHT_LIGHT) begin
            if (master_off) night_light_led <= 1'b0;
            else if (master_on) night_light_led <= 1'b1;
            else if (counter1 > 10) night_light_led <= 1'b0;
            else if (dark) night_light_led <= 1'b1;
            else begin
            night_light_led <= 1'b0;            
            end
        end
    end
    
    //sequential block for secure mode led
    always @(posedge clk) begin
        if(state == SECURE) begin
            if (master_off) secure_led <= 1'b0;
            else if (master_on) secure_led <= 1'b1;
            else if (counter > 5) secure_led <= 1'b0;
            else if (dark & motion) secure_led <= 1'b1;                 
            else secure_led <=1'b0;           
        end        
    end
    
    //sequential block for bathroom led for both modes
    always @(posedge clk) begin
            if (master_off) bathled <= 1'b0;
            else if (master_on) bathled <= 1'b1;
            else if (entering) bathled <= 1'b1;
            else bathled <= 1'b0;           
        
    end    
    
    // counter for 5 seconds light in secure mode
    always @(posedge clk) begin
        if (state == NIGHT_LIGHT) counter <= 1'b0;
        else if(beat & secure_led == 1'b1) counter <= counter + 1'b1;
    end
    
    // counter for 10 seconds light in night light mode
    always @(posedge clk) begin   
        if (state == SECURE) counter1 <= 1'b0;
        else if(beat & night_light_led == 1'b1) counter1 <= counter1 + 1'b1;
    end
    
    
    //Output logic
    always @(*) begin
        case(state)
            NIGHT_LIGHT: begin
                LED_bath <= bathled;
                LED_out <= night_light_led;
            end
            SECURE: begin
                LED_bath <= bathled;
                LED_out <= secure_led;
            end
        endcase
    end

endmodule
