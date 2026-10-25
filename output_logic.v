`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2025 15:36:28
// Design Name: 
// Module Name: output_logic
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



module output_logic (
    input wire [3:0] current_state, 
    input wire clk_2hz,             
    
    output reg ns_red_led, ns_yellow_led, ns_green_led,
    output reg ew_red_led, ew_yellow_led, ew_green_led,
   
    output reg ped_walk_led, ped_dont_walk_led
);
   
    localparam [3:0] NS_GREEN = 4'd0, NS_YELLOW = 4'd1,
                      EW_GREEN = 4'd2, EW_YELLOW = 4'd3,
                      PED_REQ = 4'd4, NS_RED_2S = 4'd5,
                      WALK = 4'd6, FLASH_RED = 4'd7;

    always @(current_state or clk_2hz) begin
        
        {ns_red_led, ns_yellow_led, ns_green_led, ew_red_led, ew_yellow_led, ew_green_led} = 6'b0;
        {ped_walk_led, ped_dont_walk_led} = 2'b0;

        case (current_state)
            NS_GREEN: begin
                ns_green_led = 1; ew_red_led = 1; ped_dont_walk_led = 1;
            end
            NS_YELLOW: begin
                ns_yellow_led = 1; ew_red_led = 1; ped_dont_walk_led = 1;
            end
            EW_GREEN: begin
                ns_red_led = 1; ew_green_led = 1; ped_dont_walk_led = 1;
            end
            EW_YELLOW: begin
                ns_red_led = 1; ew_yellow_led = 1; ped_dont_walk_led = 1;
            end
            PED_REQ, NS_RED_2S: begin
                
                ns_red_led = 1; ew_red_led = 1; ped_dont_walk_led = 1;
            end
            WALK: begin
                ns_red_led = 1; ew_red_led = 1; ped_walk_led = 1;
            end
            FLASH_RED: begin
                ns_red_led = 1; ew_red_led = 1; 
              
                ped_dont_walk_led = clk_2hz;
            end
            default: begin
                ns_red_led = 1; ew_red_led = 1; ped_dont_walk_led = 1;
            end
        endcase
    end
endmodule