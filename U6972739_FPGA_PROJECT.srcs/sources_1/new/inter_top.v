`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// when I use elaborate design, the vivado gives correspoding circuits
// can this circuit be used as the Application Specific Integrated Circuit?


//logic standard compatibility
// interfacing , how to connect to different sensors, industriey high level question
// timing compatibility, 
// debouncer sunchnyier discuss
//how this additional complexity presents itself and how it may be mitigated/addressed through
//appropriate design choices
//
//////////////////////////////////////////////////////////////////////////////////


module inter_top(
input wire remote_control,
input wire collision_sensor,
output wire [9:0] LEDs,
output wire Motor,
input wire sysclk,
input wire reset,
    input wire enter,
    input wire one,
    input wire two,
    input wire four,
    output wire [6:0] ssdCathode,
    output wire [3:0] ssdAnode,
input wire switch,
output wire [2:0] index,
input wire entering,
input wire dark,
input wire motion,
input wire master_off,
input wire master_on,
output wire LED_bath,
output wire LED_out
    );


wire spot_outswitch;
entering_debounce (.reset(reset), .sysclk(sysclk), .switch(switch), .spot_outswitch(spot_outswitch));

wire door, light, climate;
Dgarage_door_top gd (.remote_control(remote_control), .collision_sensor(collision_sensor), .LEDs(LEDs), .Motor(Motor), .sysclk(sysclk), .reset(reset), .door(door));
MicrowaveFSM_top cc (.reset(reset), .clk(sysclk), .enter(enter), .one(one), .two(two), .four(four), .ssdCathode(ssdCathode), .ssdAnode(ssdAnode), .climate(climate));
Inter_FSM inter_fsm (.index(index), .switch(spot_outswitch), .door(door), .light(light), .climate(climate), .reset(reset), .sysclk(sysclk));
LMicrowaveFSM_top hl (.enter(enter), .light(light), .clk(sysclk), .reset(reset), .entering(entering), .dark(dark), .motion(motion), .master_off(master_off), .master_on(master_on), .LED_bath(LED_bath), .LED_out(LED_out));
endmodule
