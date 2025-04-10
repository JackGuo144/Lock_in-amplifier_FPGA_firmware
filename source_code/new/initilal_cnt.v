`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/04 19:48:10
// Design Name: 
// Module Name: initilal_cnt
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


module initilal_cnt(
    input clk,
    input rst,
    input [31:0]    cnt_max,
    output  reg reset_n,
    output  reg initial_flag
    );
    
    reg [31:0]  N;
    
    always@(posedge clk or negedge rst)
        if(!rst)
            begin
                N<=0;
                initial_flag<=0;
            end
        else if(N>=cnt_max)
            begin
                N<=N;
                initial_flag<=1;
            end
        else
            begin
                N<=N+1;
                initial_flag<=0;
            end
            
    always@(posedge clk or negedge rst)
        if(!rst)
            reset_n<=1'b1;
        else if(N>=100)
            reset_n<=1'b0;
       
    
    
    
    
endmodule
