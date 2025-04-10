`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 08:50:32
// Design Name: 
// Module Name: LoopFilter
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


module LoopFilter(
	rst,clk,pd,
	frequency_df); 
	
	input		rst;   //��λ�źţ��ߵ�ƽ��Ч
	input		clk;   //FPGAϵͳʱ�ӣ�32MHz
	input	 signed [24:0]	pd;            //�������ݣ�32MHz
	output signed [24:0]	frequency_df;  //��·�˲����������
	
	
   reg [2:0] count;
	reg signed [24:0] sum,loopout;
	always @(posedge clk or posedge rst)
		if (rst)
		   begin
				count <=0;
				sum <= 0;
				loopout <= 0;
			end
		else
			begin
				//Ƶ���ָ�������Ϊ8��CLK����
				count <= count + 1;
			   //��·�˲����е��ۼ����Ĵ���
				if (count==3'b101)
				   //c2=2^(-10)
			      sum<=sum+{{10{pd[24]}},pd[24:10]};
					//sum<=sum+{{9{pd[24]}},pd[24:9]};
 			   if (count==3'b110)
				   //c1=2^(-4)-2^(-7)
				   loopout<=sum+{{4{pd[24]}},pd[24:4]}-{{7{pd[24]}},pd[24:7]};
					//loopout<=sum+{{2{pd[24]}},pd[24:2]}-{{5{pd[24]}},pd[24:5]};
			  end
			  
     assign frequency_df = loopout;

endmodule

