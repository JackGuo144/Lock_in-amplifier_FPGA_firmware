`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 09:11:24
// Design Name: 
// Module Name: iir_lpf
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


module iir_lpf(
	rst,clk,Xin,
	Yout);
	
	input		rst;   //��λ�źţ��ߵ�ƽ��Ч
	input		clk;   //FPGAϵͳʱ�ӣ�Ƶ��Ϊ32MHz
	input	 signed [14:0]	Xin;  //��������Ƶ��Ϊ2kHZ
	output signed [24:0]	Yout; //�˲�����������


	//���ϵ��ʵ�ִ���
	//�������������δ�����λ�Ĵ�����
	reg signed[14:0] Xin_1,Xin_2,Xin_3;
	always @(posedge clk or posedge rst)
		if (rst)
			//��ʼ���Ĵ���ֵΪ0
			begin 
				Xin_1 <= 0;
				Xin_2 <= 0;
				Xin_3 <= 0;
			end
		else
			begin
				Xin_1 <= Xin;
				Xin_2 <= Xin_1;
				Xin_3 <= Xin_2;
			end
			
	//������λ���㼰�ӷ�����ʵ�ֳ˷�����
	wire signed[26:0] XMult_0,XMult_1,XMult_2,XMult_3;	
	assign XMult_0={{9{Xin[14]}},Xin,3'd0};                  //*8
   assign XMult_1={{9{Xin_1[14]}},Xin_1,3'd0} + {{10{Xin_1[14]}},Xin_1,2'd0} + {{12{Xin_1[14]}},Xin_1}; //*13
   assign XMult_2={{9{Xin_2[14]}},Xin_2,3'd0} + {{10{Xin_2[14]}},Xin_2,2'd0} + {{12{Xin_2[14]}},Xin_2}; //*13
	assign XMult_3={{9{Xin_3[14]}},Xin_3,3'd0};             //*8

	//���˲���ϵ�����������ݵĳ˷���������ۼӣ�������˲��������
	//�˴�����һ���Ĵ����������ϵͳ�����ٶ�
	//wire signed[26:0] Xout;
	//assign Xout = XMult_0 + XMult_1 + XMult_2 + XMult_3;
	reg signed[26:0] Xout;
	always @(posedge clk)
	if(rst)
	   Xout <='d0;
	   else
		Xout <= XMult_0 + XMult_1 + XMult_2 + XMult_3;
		
	
	//����ϵ����ʵ�ִ���
	//�������������δ�����λ�Ĵ�����
	reg signed[14:0]  Yin_1,Yin_2,Yin_3;
	wire signed[14:0] Yin;	
	always @(posedge clk or posedge rst)
		if (rst)
			//��ʼ���Ĵ���ֵΪ0
			begin 
			         
				Yin_1 <= 0;
				Yin_2 <= 0;
				Yin_3 <= 0;
			end
		else
			begin
				Yin_1 <= Yin;
				Yin_2 <= Yin_1;
				Yin_3 <= Yin_2;
			end	
			
	//������λ���㼰�ӷ�����ʵ�ֳ˷�����
	wire signed[26:0] YMult_1,YMult_2,YMult_3;	
   assign YMult_1={{9{Yin_1[14]}},Yin_1,3'd0} - {{4{Yin_1[14]}},Yin_1,8'd0} - {{1{Yin_1[14]}},Yin_1,11'd0}; //*-2296
   assign YMult_2={{2{Yin_2[14]}},Yin_2,10'd0} + {{3{Yin_2[14]}},Yin_2,9'd0} + {{4{Yin_2[14]}},Yin_2,8'd0}- {{10{Yin_2[14]}},Yin_2,2'd0}; //*1788
	assign YMult_3={{10{Yin_3[14]}},Yin_3,2'd0} + {{7{Yin_3[14]}},Yin_3,5'd0} - {{3{Yin_3[14]}},Yin_3,9'd0}; //*-476
	
	//�����ϵ�����Xout�뼫��ϵ���˲���Ľ����������IIR�˲������
	wire signed[26:0] Ysum;
	assign Ysum = Xout - YMult_1 - YMult_2 - YMult_3;
	
	//��Ysum����10�����൱�ڳ���1024������ȡ��15λ�������
	assign Yin = Ysum[24:10];
	
	
	//�˴���1024����Yin��Ϊ�˲�����ɼĴ�������������ϵͳ�����ٶ�
	reg signed[24:0] dout;
	always @(posedge clk)
		dout <= Ysum[24:0];
	assign Yout = dout;	
	
endmodule
