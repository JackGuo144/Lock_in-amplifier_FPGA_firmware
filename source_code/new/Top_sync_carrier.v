`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module Top_sync_carrier(
	rst,clk,key,IQSEL,IQWRT,IQCLK,IQRESET,DAC_OUTPUT,DATA_ADA,DATA_ADB
	); 
	
//*********输入参数*********//
    input                   clk;                //FPGA系统时钟
	input		            rst;                //复位信号，高电平有效
	input     [2:0]         key;
	
    wire                 clk_50MHz;
//*********输出参数*********//
    output                  IQSEL,IQWRT,IQCLK,IQRESET;
    output  wire [13:0]     DAC_OUTPUT;
    input         [13:0]    DATA_ADA;
    input         [13:0]    DATA_ADB;
    
    wire    [13:0]    DATA_A;
    wire    [13:0]    DATA_B;
//*********锁相放大模块参数*********//
	wire                   reset_n;            //复位信号，低电平有效
	wire                   clk_32MHz;
    wire                   clk_10MHz;

//*********环路滤波器输出数据 过程中的频移大小*********//
	wire   signed [20:0]   df;                 //环路滤波器输出数据,即同步过程中的频移大小	

//*********dds2 本地同步后的输出同步载波信号*********//
	wire          [7:0]   sin_wave,cos_wave;                           //本地sin，cos波形数据，无符号
	wire   signed [7:0]   sin_wave_signed,cos_wave_signed;             //本地sin，cos波形数据，有符号
	assign  sin_wave_signed=(sin_wave=='d0)?sin_wave-'d127:sin_wave-'d128;         //无符号转化为有符号数    （0-255）转化为（-127，127）
	assign  cos_wave_signed=(cos_wave=='d0)?cos_wave-'d127:cos_wave-'d128;         //无符号转化为有符号数    （0-255）转化为（-127，127）
	
//***************************************************//
//*********初始化模块 锁相放大模块复位延迟*********//
//***************************************************//
initilal_cnt u0(
    .clk(clk_50MHz),
    .rst(rst),
    .cnt_max('d1000),       //延时时间=数值*20ns
    .reset_n(reset_n),      //锁相放大器复位信号
    .initial_flag()         //复位完成标志
    );
    
//****************测试用****************//
wire          [7:0]   sin_wave1,cos_wave1; 

ddss_test
#(  .phase(0))                          //相位
u_test
(
    .sys_clk(clk_50MHz),
    .rst_n(rst),                        //low works
    .wave_select(4'b0001),              //0001正弦波，0010方波，0100三角波，1000锯齿波
    .freq('d1100_000),           //freq1
    .sin_data_out(sin_wave1),        //sin输出 8bits unsigned
    .cos_data_out(cos_wave1),        //cos输出 8bits unsigned
    .freq_mod_i('d0)                    //频率误差     这是关键，在本地震荡的相位调节中，根据频率误差实时调节相位  此处不需要
    );

//**************************************************//
//****************带通滤波器 过滤噪声 500-1500****************//
//**************************************************//

wire            [13:0]      filter_in;
wire    signed  [34:0]      filter_out;
wire    signed  [7:0]      filter_out_reg;

//若板子有开关，可以用过按键开关切换量程，达到不同SNR信噪比输出良好效果
reg [2:0]   mode_SNR;
always@(posedge clk or negedge rst)
    if(!rst)
        mode_SNR<=3'b000;
    else if(key[0]=='d1)
        mode_SNR<=3'b001;
    else if(key[1]=='d1)
        mode_SNR<=3'b010;
    else if(key[2]=='d1)
        mode_SNR<=3'b100;
    else
        mode_SNR<=mode_SNR;

assign  filter_out_reg=(mode_SNR==3'b001)?filter_out[33:26]:(mode_SNR==3'b010)?filter_out[29:22]:(mode_SNR==3'b100)?filter_out[27:20]:filter_out[33:26];

assign  filter_in=(DATA_A>>1)+(DATA_B>>1);//{sin_wave1,1'b000};//{ad_data,4'b0000}+{sin_wave1,1'b000};//{ad_data,4'b0000}+{sin_wave1,1'b000};//{sin_wave1>>1}+{sin_wave_din,4'b0000};


filter_bandpass u1(
                .clk(clk_10MHz),
                .clk_enable(rst),     //high works
                .reset(reset_n),          //high works
                .filter_in({1'b0,filter_in,1'b0}),      //15:0  {filter_in,2'b00}
                .filter_out(filter_out)      //34:0
                );

//****************************************************//
//*******************锁相放大器模块*******************//
//****1.Phase Detector; 2.Loop Filter; 3.Voltage-Controlled Oscillator.****//
//****************1.Phase Detector*******************//
	reg signed [15:0]     mult_out;                   //寄存数据 输入信号与本地信号相乘结果  

    always@(posedge clk_10MHz or negedge rst)
        if(!rst)
            mult_out<=0;
        else
            mult_out<=filter_out_reg*cos_wave_signed;
            
    //assign  mult_out=filter_out_reg*cos_wave_signed;//din*cos_wave_signed;    //filter_out_reg*cos_wave_signed;       //输入信号与本地信号相乘   再滤波后即可得到低频值 即两者频率差电压信号
//实例化低通滤波器核
	wire signed [24:0] pd;                     //输入信号与本地信号频率差
iir_lpf u2 (
	   .rst (reset_n),             //复位 high works
		.clk (clk_32MHz),	   
		.Xin (mult_out[14:0]),     //寄存数据 输入信号与本地信号相乘结果   
	   .Yout (pd)                  //滤波后即得到低频值 即两者频率差电压信号
	   );
//************************************************//
//****************2.Loop Filter*******************//
//************************************************//
	wire signed [24:0] Loopout;            //环路滤波器产生频偏信号 数字控制振荡器根据此频偏修正信号频率
//*************实例化环路滤波器模块**************//	
LoopFilter u3(
	    .rst (reset_n),
		.clk (clk_32MHz),
		.pd  (pd),                        //滤波后即得到低频值 即两者频率差电压信号
		.frequency_df(Loopout));          //环路滤波器滤波后得到的频率差 用于数字控制振荡器调频
		
//************************************************//	
//*********3.Voltage-Controlled Oscillator********//
//************************************************//	
dds
#(  .freq(1_000_000),       //Hz
    .phase(0))          //*pi/2
u4
(
    .sys_clk(clk_50MHz),
    .rst_n(rst),        //0复位
    .wave_select(4'b0001),
    .sin_data_out(sin_wave),
    .cos_data_out(cos_wave),
    .freq_mod_i(Loopout)
    );


  clk_wiz_0 u5
   (
    // Clock out ports
    .clk_out1(clk_32MHz),       // 32MHz
    .clk_out2(clk_10MHz),       //10MHz
    .clk_out3(clk_50MHz),
    .clk_in1(clk))
    ;      // 


wire    signed  [33:0]  phase_out;
wire    signed  [8:0]   sin_wave_reg;
assign  sin_wave_reg=sin_wave;
wire    signed  [15:0]  multi_phase_mea;
assign  multi_phase_mea=filter_out_reg*sin_wave_reg;

filter_phase    
u9
               (
                .clk(clk_10MHz),
                .clk_enable(rst),
                .reset(reset_n),
                .filter_in(multi_phase_mea),      //15:0
                .filter_out(phase_out)      //33:0
                );

    wire    signed  [7:0]  phase_reg;
    assign  phase_reg   =   phase_out[27:20];
    wire    signed  [8:0]  phase_reg_reg;
    assign  phase_reg_reg   =   phase_reg+'d127;
    
//将数据送至输出端口查看	
	assign df = Loopout;
	//assign da_data=sin_wave;//phase_reg_reg[7:0];//sin_wave;      //        phase_out[33:26]


ADC_LTC2145 u_adc(
    .clk(clk),
    .rst(rst),
    .DATA_ADA(DATA_ADA),
    .DATA_ADB(DATA_ADB),
    .OUTPUT_A(DATA_A),
    .OUTPUT_B(DATA_B)
    );

ADC9767 u_dac(
    .clk(clk),
    .rst(rst),
    .data_in_A(sin_wave),
    .data_in_B(phase_out[33:20]),   //filter_in
    .IQSEL(IQSEL),
    .IQWRT(IQWRT),
    .IQCLK(IQCLK),
    .IQRESET(IQRESET),
    .DAC_OUTPUT(DAC_OUTPUT)
    );


////*********测试用***********//
//ila_0 u8 (
//	.clk(clk), // input wire clk


//	.probe0(filter_in), // input wire [13:0]  probe0  
//	.probe1(filter_out_reg), // input wire [7:0]  probe1 
//	.probe2(), // input wire [7:0]  probe2 
//	.probe3(pd), // input wire [24:0]  probe3 
//	.probe4(Loopout), // input wire [24:0]  probe4
//	.probe5(phase_out)
//);


endmodule
