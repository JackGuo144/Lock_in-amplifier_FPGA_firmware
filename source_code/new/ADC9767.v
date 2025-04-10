`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/19 21:17:35
// Design Name: 
// Module Name: ADC9767
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


module ADC9767(
    clk,rst,data_in_A,data_in_B,IQSEL,IQWRT,IQCLK,IQRESET,DAC_OUTPUT
    );
    //端口定义
    input               clk;
    input               rst;
    input       [7:0]   data_in_A;
    input       [13:0]   data_in_B;
    output              IQSEL,IQWRT,IQCLK,IQRESET;
    output  reg [13:0]  DAC_OUTPUT;
    //时钟
    wire                clk_62_5MHz_135degree;
    wire                clk_125MHz_270degree;
    wire                clk_125MHz_30degree;
    assign              IQSEL   =   clk_62_5MHz_135degree;
    assign              IQWRT   =   clk_125MHz_30degree;;
    assign              IQCLK   =   clk;
    assign              IQRESET =   ~rst;
    
    always@(posedge clk_125MHz_270degree or negedge rst)
        if(!rst)
            DAC_OUTPUT<=14'd0;
        else if(!IQSEL)
            DAC_OUTPUT<={data_in_A,6'b000000};
        else if(IQSEL)
            DAC_OUTPUT<=data_in_B;
        else
            DAC_OUTPUT<=DAC_OUTPUT;


clk_wiz_1 u1
   (
    // Clock out ports
    .clk_out1(clk_62_5MHz_135degree),     // output clk_out1
    .clk_out2(clk_125MHz_270degree),     // output clk_out2
    .clk_out3(clk_125MHz_30degree),
   // Clock in ports
    .clk_in1(clk)); 


endmodule
