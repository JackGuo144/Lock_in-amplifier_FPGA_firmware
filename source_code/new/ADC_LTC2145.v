`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/20 16:55:08
// Design Name: 
// Module Name: ADC_LTC2145
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


module ADC_LTC2145(
    clk,rst,DATA_ADA,DATA_ADB,OUTPUT_A,OUTPUT_B
    );
    //½Ó¿Ú
    input                   clk;
    input                   rst;
    input   [13:0]          DATA_ADA;
    input   [13:0]          DATA_ADB;
    output   reg    [13:0]  OUTPUT_A;
    output   reg    [13:0]  OUTPUT_B;
    
    
    always@(posedge clk or negedge rst)
        if(!rst)
            begin
                OUTPUT_A<='d0;
                OUTPUT_B<='d0;
            end
        else
            begin
                OUTPUT_A<=DATA_ADA;
                OUTPUT_B<=DATA_ADB;
            end



















endmodule
