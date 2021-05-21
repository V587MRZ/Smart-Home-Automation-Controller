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


module FSM(
    input wire clk,
    input wire reset,
    input wire enter,
    input wire one,
    input wire two,
    input wire four,
    input wire climate,
    output wire [6:0] ssdCathode,
    output reg [3:0] ssdAnode
    );
   
    
    
    wire beat;
    reg [1:0] state, nextstate;
    reg [0:0] activeDisplay;
    reg [3:0] ssdValue;
    reg [2:0] sum;
    reg [4:0] room_temp =3 , envir_temp = 1,set_temp;
    reg [15:0] counter1, counter2;

    parameter IDLE=2'd0, SET_TEMP=2'd1,WORKING = 2'd2;    

    //Current state register/transition block
    always @(posedge clk) begin
        if(reset) state <= IDLE;
        else if (climate) state <= nextstate;
    end   
    
    
    //Next state logic
    always @(*) begin
        case(state)
            IDLE: begin
                if(enter) nextstate <= SET_TEMP;
                else nextstate <= IDLE;
            end
            SET_TEMP: begin
                if(enter) nextstate <= WORKING;
                else nextstate <= SET_TEMP;
            end
            WORKING: begin
                if(enter) nextstate <= IDLE;
                else nextstate <= WORKING;
            end
            default: nextstate = IDLE;
        endcase
    end
        
    
    
    always @(posedge clk)begin
        if (one&two&four) sum = 7;
        else if (two&four) sum =6;
        else if (one&four) sum =5;        
        else if (one&two) sum =3;
        else if (four) sum =4;
        else if (two) sum = 2;
        else if (one) sum = 1;
        else sum=0;
    end
    //assign activeDisplay=0;
    
    heartbeat #(.TOPCOUNT(100_000)) heratbeat_generator (.clk(clk),.reset(reset),.beat(beat));
    heartbeat #(.TOPCOUNT(100_000_000)) heratbeat_generator_2 (.clk(clk),.reset(reset),.beat(beat_1s));
    heartbeat #(.TOPCOUNT(200_000_000)) heratbeat_generator_3 (.clk(clk),.reset(reset),.beat(beat_2s));


    //sequential block for idle
    always @(posedge clk) begin
        if (state == IDLE) begin
            if ((room_temp < envir_temp) & beat_2s) begin 
                room_temp <= room_temp + 1;
                end
            else if ((room_temp > envir_temp) & beat_2s) begin
                room_temp <= room_temp - 1;
                end
        end
        else if (state == SET_TEMP) begin
            set_temp <= sum;
        end
        else if (state == WORKING) begin
            if ((room_temp < set_temp) & beat_1s) begin
                room_temp <= room_temp + 1;
                end
            else if ((room_temp > set_temp) & beat_1s) begin 
                room_temp <= room_temp - 1;
                end
        end
    end
       
    
        
    always @(posedge clk)begin
        if(beat)
        
            activeDisplay <= activeDisplay + 1;
    end
    
    sevenSegmentDecoder De1 (
        .bcd(ssdValue),
        .ssd(ssdCathode)
    );
    
    
    //Output logic
    always @(*) begin
        case(state)
            IDLE: begin
                case(activeDisplay)
                2'd0: begin
                    ssdValue=4'd2;
                    ssdAnode=4'b1101;        
                end
                2'd1: begin
                    ssdValue=room_temp;
                    ssdAnode=4'b1110;
                end
                default: begin
                    ssdValue=4'd10;
                    ssdAnode=4'b1111;
                end
                endcase
            end
            SET_TEMP: begin
                case(activeDisplay)
                2'd0: begin
                    ssdValue=4'd2;
                    ssdAnode=4'b1101;        
                end
                2'd1: begin
                    ssdValue=sum;
                    ssdAnode=4'b1110;
                end
                default: begin
                    ssdValue=4'd10;
                    ssdAnode=4'b1111;
                end            
                endcase
            end
            WORKING: begin
                case(activeDisplay)
                2'd0: begin
                    ssdValue=4'd2;
                    ssdAnode=4'b1101;        
                end
                2'd1: begin
                    ssdValue=room_temp;
                    ssdAnode=4'b1110;
                end
                default: begin
                    ssdValue=4'd10;
                    ssdAnode=4'b1111;
                end            
                endcase
            end            
        endcase
    end

endmodule
