`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2025 15:32:46
// Design Name: 
// Module Name: clk_divider
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
/////////////////////////////////////////////////////////////////////////////
module clk_divider #(
    
    parameter COUNT_LIMIT = 50000000 
) (
    input wire clk,         
    input wire reset,
    output reg clk_out     
);
    
    reg [25:0] counter = 0; 

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end 
        
        else if (counter == COUNT_LIMIT - 1) begin
            counter <= 0;
            clk_out <= ~clk_out; 
        end else begin
            counter <= counter + 1;
        end
    end
endmodule