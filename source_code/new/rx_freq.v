`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/27 22:20:02
// Design Name: 
// Module Name: rx_freq
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


module rx_freq(
    input   wire            sys_clk     ,   //ϵͳʱ��50MHz
    input   wire            sys_rst_n   ,   //ȫ�ָ�λ
    input   wire            po_flag,
    input   wire    [7:0]   po_data,
    output  reg     [31:0]  freq,           //��������Ƶ��   ʵ��Ƶ��=����Ƶ��*0.1
    output  reg     [31:0]  code_rate,      //��Ƶ��������   ʵ������=��������*0.1
    output  reg     [7:0]  wave_form,      //�������벨������
    output  reg             over_flag
    );
    
    reg [7:0]   po_data_reg [7:0];
    reg [2:0]   N;
    
    always@(posedge sys_clk or negedge sys_rst_n)
        if(sys_rst_n == 1'b0)
            begin
                N<='d0;
                po_data_reg[0]<=0;
                po_data_reg[1]<=0;
                po_data_reg[2]<=0;
                po_data_reg[3]<=0;
                po_data_reg[4]<=0;
                po_data_reg[5]<=0;
                po_data_reg[6]<=0;
                po_data_reg[7]<=0;
            end
        else if(po_flag)
            begin
                N<=N+1;
                po_data_reg[N]<=po_data;
            end
        else
            begin
                N<=N;
                po_data_reg[N]<=po_data_reg[N];
            end
    
    always@(posedge sys_clk or negedge sys_rst_n)
        if(sys_rst_n == 1'b0)
            over_flag<='d0;
        else if(N==7)
            over_flag<=1;
        else
            over_flag<=0;
    

    
    always@(posedge sys_clk or negedge sys_rst_n)
        if(sys_rst_n == 1'b0)
            begin
                freq<=0;
                code_rate<=0;
            end
        else if(over_flag)
            begin
                freq<=po_data_reg[3][3:0]*'d1+po_data_reg[3][7:4]*'d10+po_data_reg[2][3:0]*'d100+po_data_reg[2][7:4]*'d1000+po_data_reg[1][3:0]*'d10000+po_data_reg[1][7:4]*'d100000+po_data_reg[0][3:0]*'d1000000+po_data_reg[0][7:4]*'d10000000;
                code_rate=po_data_reg[7][3:0]*'d1+po_data_reg[7][7:4]*'d10+po_data_reg[6][3:0]*'d100+po_data_reg[6][7:4]*'d1000+po_data_reg[5][3:0]*'d10000+po_data_reg[5][7:4]*'d100000+po_data_reg[4][3:0]*'d1000000+po_data_reg[4][7:4]*'d10000000;;
            end
        else
            begin
                freq<=freq;
                code_rate<=code_rate;
            end
    
    
    
endmodule
