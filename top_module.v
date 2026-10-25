`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2025 15:37:58
// Design Name: 
// Module Name: top_module
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



module top_module (
    
    input wire clk_100mhz,
    input wire reset,
    input wire ped_button,
   
    output wire ns_red_led, output wire ns_yellow_led, output wire ns_green_led,
    output wire ew_red_led, output wire ew_yellow_led, output wire ew_green_led,
    output wire ped_walk_led, output wire ped_dont_walk_led
);
    
    wire clk_1s; 
    wire clk_2hz; 
    wire [3:0] fsm_state;

    
    clk_divider #(
        .COUNT_LIMIT(50000000)
    ) i_clk_1s (
        .clk(clk_100mhz),
        .reset(reset),
        .clk_out(clk_1s)
    );

    
    clk_divider #(
        .COUNT_LIMIT(25000000)
    ) i_clk_2hz (
        .clk(clk_100mhz),
        .reset(reset),
        .clk_out(clk_2hz)
    );

   
    traffic_fsm i_fsm (
        .clk_1s(clk_1s),
        .reset(reset),
        .ped_button(ped_button),
        .current_state(fsm_state)
    );

    
    output_logic i_output_ctrl (
        .current_state(fsm_state),
        .clk_2hz(clk_2hz),
        .ns_red_led(ns_red_led), .ns_yellow_led(ns_yellow_led), .ns_green_led(ns_green_led),
        .ew_red_led(ew_red_led), .ew_yellow_led(ew_yellow_led), .ew_green_led(ew_green_led),
        .ped_walk_led(ped_walk_led), .ped_dont_walk_led(ped_dont_walk_led)
    );
endmodule