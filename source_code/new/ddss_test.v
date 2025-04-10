`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/06 15:43:34
// Design Name: 
// Module Name: ddss_test
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


module ddss_test#(
    parameter   phase =   2         //X*pi/2
)
(
    input wire sys_clk,
    input wire rst_n,
    input wire [3:0] wave_select,
    input       [31:0]  freq,
    output wire [7:0] sin_data_out,
    output wire [7:0] cos_data_out,
    input  wire signed [24:0] freq_mod_i
    );
parameter  sin_wave    =   4'b0001,
            squ_wave    =   4'b0010,
            tri_wave    =   4'b0100,
            saw_wave    =   4'b1000;
reg [31:0] fre_add;
reg [3:0] reg_wave_select;
reg [11:0] rom_addr_reg;
reg [13:0] rom_addr;

wire    signed    [31:0]  freq_ctrl;
wire    [15:0]  phase_ctrl;
assign  freq_ctrl=(freq+{{14{freq_mod_i[24]}},freq_mod_i[23:6]})*'d86;//+{freq_mod_i[24:0],5'b00000};
assign  phase_ctrl=phase*'d1024;


always@(posedge sys_clk)
    reg_wave_select<=wave_select;

always@(posedge sys_clk or negedge rst_n)
    if(rst_n==0)
        fre_add<=0;
    else if(wave_select!=reg_wave_select)
        fre_add<=0;
    else fre_add<=fre_add+freq_ctrl;

always@(posedge sys_clk or negedge rst_n)
    if(rst_n==0)
        rom_addr_reg<=0;
    else 
    case(wave_select)
        sin_wave:   
                    begin 
                        rom_addr_reg<=fre_add[31:20]+phase_ctrl;
                        rom_addr<=rom_addr_reg;//为何寄存一次？
                    end
        squ_wave:
                    begin
                        rom_addr_reg<=fre_add[31:20]+phase_ctrl;
                        rom_addr<=rom_addr_reg+15'd4096;
                    end
        tri_wave:
                    begin
                        rom_addr_reg<=fre_add[31:20]+phase_ctrl;
                        rom_addr<=rom_addr_reg+15'd8192;
                    end
       saw_wave:
                    begin
                        rom_addr_reg<=fre_add[31:20]+phase_ctrl;
                        rom_addr<=rom_addr_reg+15'd12288;
                    end
       default: 
                    begin
                        rom_addr_reg<=fre_add[31:20]+phase_ctrl;
                        rom_addr<=rom_addr_reg;
                    end
    endcase

wire [13:0]     rom_addr_cos;
wire [13:0]     rom_addr_regg;
assign          rom_addr_regg=rom_addr+'d1024;
assign          rom_addr_cos=(rom_addr_regg>4095)?(rom_addr_regg-4096):rom_addr_regg;




blk_mem_gen_0 blk_mem_gen_1 (
  .clka(sys_clk),    // input wire clka
  .addra(rom_addr),  // input wire [13 : 0] addra
  .douta(sin_data_out)  // output wire [7 : 0] douta
);
blk_mem_gen_0 blk_mem_gen_2 (
  .clka(sys_clk),    // input wire clka
  .addra(rom_addr_cos),  // input wire [13 : 0] addra
  .douta(cos_data_out)  // output wire [7 : 0] douta
);
endmodule
