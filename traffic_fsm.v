`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2025 15:34:48
// Design Name: 
// Module Name: traffic_fsm
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



module traffic_fsm (
    input wire clk_1s,
    input wire reset,
    input wire ped_button, 
    output wire [3:0] current_state 
);
    
    localparam [3:0] NS_GREEN = 4'd0, NS_YELLOW = 4'd1,
                      EW_GREEN = 4'd2, EW_YELLOW = 4'd3,
                      PED_REQ = 4'd4, NS_RED_2S = 4'd5,
                      WALK = 4'd6, FLASH_RED = 4'd7;

    reg [3:0] state_reg, next_state;
    reg [2:0] timer_count;
    reg ped_latched; 

    assign current_state = state_reg;

    
    always @(posedge clk_1s or posedge reset) begin
        if (reset) begin
            state_reg <= NS_GREEN;
            timer_count <= 0;
            ped_latched <= 0;
        end else begin
            state_reg <= next_state;

           
            if (state_reg == next_state) begin
                timer_count <= timer_count + 1;
            end else begin
                timer_count <= 0; 
            end

           
            if (ped_button) begin
                ped_latched <= 1; 
            end else if (state_reg == FLASH_RED) begin
                ped_latched <= 0; 
            end
        end
    end

    
    always @(*) begin
        next_state = state_reg; 
        case (state_reg)
            NS_GREEN: begin
                if (timer_count == 5 - 1) begin 
                    next_state = ped_latched ? PED_REQ : NS_YELLOW;
                end
            end
            NS_YELLOW: begin
                if (timer_count == 2 - 1) next_state = EW_GREEN; 
            end
            EW_GREEN: begin
                if (timer_count == 5 - 1) begin 
                    next_state = ped_latched ? PED_REQ : EW_YELLOW;
                end
            end
            EW_YELLOW: begin
                if (timer_count == 2 - 1) next_state = NS_GREEN; 
            end
            PED_REQ: begin
                next_state = NS_RED_2S;
            end
            NS_RED_2S: begin
                if (timer_count == 2 - 1) next_state = WALK; 
            end
            WALK: begin
                if (timer_count == 4 - 1) next_state = FLASH_RED; 
            end
            FLASH_RED: begin
                if (timer_count == 3 - 1) next_state = NS_GREEN; 
            end
            default: next_state = NS_GREEN;
        endcase
    end
endmodule