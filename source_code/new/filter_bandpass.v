`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/06 20:52:54
// Design Name: 
// Module Name: filter_bandpass
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


module filter_bandpass (
                clk,
                clk_enable,     //high works
                reset,          //high works
                filter_in,      //15:0
                filter_out      //34:0
                );

  input   clk; 
  input   clk_enable; 
  input   reset; 
  input   signed [15:0] filter_in; //sfix16_En15
  output  signed [34:0] filter_out; //sfix35_En32

////////////////////////////////////////////////////////////////
//Module Architecture: filter1
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [15:0] coeff1 = 16'b1111111111111100; //sfix16_En17
  parameter signed [15:0] coeff2 = 16'b1111111111111000; //sfix16_En17
  parameter signed [15:0] coeff3 = 16'b1111111111001001; //sfix16_En17
  parameter signed [15:0] coeff4 = 16'b1111111101111101; //sfix16_En17
  parameter signed [15:0] coeff5 = 16'b1111111100111001; //sfix16_En17
  parameter signed [15:0] coeff6 = 16'b1111111101010010; //sfix16_En17
  parameter signed [15:0] coeff7 = 16'b0000000000011001; //sfix16_En17
  parameter signed [15:0] coeff8 = 16'b0000000110000010; //sfix16_En17
  parameter signed [15:0] coeff9 = 16'b0000001011111001; //sfix16_En17
  parameter signed [15:0] coeff10 = 16'b0000001110001100; //sfix16_En17
  parameter signed [15:0] coeff11 = 16'b0000001001111111; //sfix16_En17
  parameter signed [15:0] coeff12 = 16'b1111111111101001; //sfix16_En17
  parameter signed [15:0] coeff13 = 16'b1111110011100100; //sfix16_En17
  parameter signed [15:0] coeff14 = 16'b1111101100000100; //sfix16_En17
  parameter signed [15:0] coeff15 = 16'b1111101101010001; //sfix16_En17
  parameter signed [15:0] coeff16 = 16'b1111110101111111; //sfix16_En17
  parameter signed [15:0] coeff17 = 16'b0000000000001100; //sfix16_En17
  parameter signed [15:0] coeff18 = 16'b0000000101001010; //sfix16_En17
  parameter signed [15:0] coeff19 = 16'b0000000010101001; //sfix16_En17
  parameter signed [15:0] coeff20 = 16'b1111111100101001; //sfix16_En17
  parameter signed [15:0] coeff21 = 16'b1111111010010100; //sfix16_En17
  parameter signed [15:0] coeff22 = 16'b1111111111111010; //sfix16_En17
  parameter signed [15:0] coeff23 = 16'b0000001010111000; //sfix16_En17
  parameter signed [15:0] coeff24 = 16'b0000010011011110; //sfix16_En17
  parameter signed [15:0] coeff25 = 16'b0000010011000110; //sfix16_En17
  parameter signed [15:0] coeff26 = 16'b0000001010001000; //sfix16_En17
  parameter signed [15:0] coeff27 = 16'b0000000000000011; //sfix16_En17
  parameter signed [15:0] coeff28 = 16'b1111111101010010; //sfix16_En17
  parameter signed [15:0] coeff29 = 16'b0000000011100101; //sfix16_En17
  parameter signed [15:0] coeff30 = 16'b0000001011111011; //sfix16_En17
  parameter signed [15:0] coeff31 = 16'b0000001100001001; //sfix16_En17
  parameter signed [15:0] coeff32 = 16'b0000000000000101; //sfix16_En17
  parameter signed [15:0] coeff33 = 16'b1111101110010000; //sfix16_En17
  parameter signed [15:0] coeff34 = 16'b1111100011001110; //sfix16_En17
  parameter signed [15:0] coeff35 = 16'b1111100110111000; //sfix16_En17
  parameter signed [15:0] coeff36 = 16'b1111110100111101; //sfix16_En17
  parameter signed [15:0] coeff37 = 16'b1111111111111101; //sfix16_En17
  parameter signed [15:0] coeff38 = 16'b1111111100110011; //sfix16_En17
  parameter signed [15:0] coeff39 = 16'b1111101101100010; //sfix16_En17
  parameter signed [15:0] coeff40 = 16'b1111100001000010; //sfix16_En17
  parameter signed [15:0] coeff41 = 16'b1111100110101010; //sfix16_En17
  parameter signed [15:0] coeff42 = 16'b1111111111111011; //sfix16_En17
  parameter signed [15:0] coeff43 = 16'b0000011101001000; //sfix16_En17
  parameter signed [15:0] coeff44 = 16'b0000101001100110; //sfix16_En17
  parameter signed [15:0] coeff45 = 16'b0000011101110100; //sfix16_En17
  parameter signed [15:0] coeff46 = 16'b0000000111101101; //sfix16_En17
  parameter signed [15:0] coeff47 = 16'b0000000000000000; //sfix16_En17
  parameter signed [15:0] coeff48 = 16'b0000010100000011; //sfix16_En17
  parameter signed [15:0] coeff49 = 16'b0000110111001011; //sfix16_En17
  parameter signed [15:0] coeff50 = 16'b0001001010001111; //sfix16_En17
  parameter signed [15:0] coeff51 = 16'b0000110101100011; //sfix16_En17
  parameter signed [15:0] coeff52 = 16'b0000000000000110; //sfix16_En17
  parameter signed [15:0] coeff53 = 16'b1111001110001011; //sfix16_En17
  parameter signed [15:0] coeff54 = 16'b1111000100110100; //sfix16_En17
  parameter signed [15:0] coeff55 = 16'b1111100111011000; //sfix16_En17
  parameter signed [15:0] coeff56 = 16'b0000001101101010; //sfix16_En17
  parameter signed [15:0] coeff57 = 16'b0000000000000011; //sfix16_En17
  parameter signed [15:0] coeff58 = 16'b1110101000000110; //sfix16_En17
  parameter signed [15:0] coeff59 = 16'b1100101111001111; //sfix16_En17
  parameter signed [15:0] coeff60 = 16'b1011101110010000; //sfix16_En17
  parameter signed [15:0] coeff61 = 16'b1100110010011001; //sfix16_En17
  parameter signed [15:0] coeff62 = 16'b1111111111111011; //sfix16_En17
  parameter signed [15:0] coeff63 = 16'b0100000000110001; //sfix16_En17
  parameter signed [15:0] coeff64 = 16'b0110110001011101; //sfix16_En17
  parameter signed [15:0] coeff65 = 16'b0110110001011101; //sfix16_En17
  parameter signed [15:0] coeff66 = 16'b0100000000110001; //sfix16_En17
  parameter signed [15:0] coeff67 = 16'b1111111111111011; //sfix16_En17
  parameter signed [15:0] coeff68 = 16'b1100110010011001; //sfix16_En17
  parameter signed [15:0] coeff69 = 16'b1011101110010000; //sfix16_En17
  parameter signed [15:0] coeff70 = 16'b1100101111001111; //sfix16_En17
  parameter signed [15:0] coeff71 = 16'b1110101000000110; //sfix16_En17
  parameter signed [15:0] coeff72 = 16'b0000000000000011; //sfix16_En17
  parameter signed [15:0] coeff73 = 16'b0000001101101010; //sfix16_En17
  parameter signed [15:0] coeff74 = 16'b1111100111011000; //sfix16_En17
  parameter signed [15:0] coeff75 = 16'b1111000100110100; //sfix16_En17
  parameter signed [15:0] coeff76 = 16'b1111001110001011; //sfix16_En17
  parameter signed [15:0] coeff77 = 16'b0000000000000110; //sfix16_En17
  parameter signed [15:0] coeff78 = 16'b0000110101100011; //sfix16_En17
  parameter signed [15:0] coeff79 = 16'b0001001010001111; //sfix16_En17
  parameter signed [15:0] coeff80 = 16'b0000110111001011; //sfix16_En17
  parameter signed [15:0] coeff81 = 16'b0000010100000011; //sfix16_En17
  parameter signed [15:0] coeff82 = 16'b0000000000000000; //sfix16_En17
  parameter signed [15:0] coeff83 = 16'b0000000111101101; //sfix16_En17
  parameter signed [15:0] coeff84 = 16'b0000011101110100; //sfix16_En17
  parameter signed [15:0] coeff85 = 16'b0000101001100110; //sfix16_En17
  parameter signed [15:0] coeff86 = 16'b0000011101001000; //sfix16_En17
  parameter signed [15:0] coeff87 = 16'b1111111111111011; //sfix16_En17
  parameter signed [15:0] coeff88 = 16'b1111100110101010; //sfix16_En17
  parameter signed [15:0] coeff89 = 16'b1111100001000010; //sfix16_En17
  parameter signed [15:0] coeff90 = 16'b1111101101100010; //sfix16_En17
  parameter signed [15:0] coeff91 = 16'b1111111100110011; //sfix16_En17
  parameter signed [15:0] coeff92 = 16'b1111111111111101; //sfix16_En17
  parameter signed [15:0] coeff93 = 16'b1111110100111101; //sfix16_En17
  parameter signed [15:0] coeff94 = 16'b1111100110111000; //sfix16_En17
  parameter signed [15:0] coeff95 = 16'b1111100011001110; //sfix16_En17
  parameter signed [15:0] coeff96 = 16'b1111101110010000; //sfix16_En17
  parameter signed [15:0] coeff97 = 16'b0000000000000101; //sfix16_En17
  parameter signed [15:0] coeff98 = 16'b0000001100001001; //sfix16_En17
  parameter signed [15:0] coeff99 = 16'b0000001011111011; //sfix16_En17
  parameter signed [15:0] coeff100 = 16'b0000000011100101; //sfix16_En17
  parameter signed [15:0] coeff101 = 16'b1111111101010010; //sfix16_En17
  parameter signed [15:0] coeff102 = 16'b0000000000000011; //sfix16_En17
  parameter signed [15:0] coeff103 = 16'b0000001010001000; //sfix16_En17
  parameter signed [15:0] coeff104 = 16'b0000010011000110; //sfix16_En17
  parameter signed [15:0] coeff105 = 16'b0000010011011110; //sfix16_En17
  parameter signed [15:0] coeff106 = 16'b0000001010111000; //sfix16_En17
  parameter signed [15:0] coeff107 = 16'b1111111111111010; //sfix16_En17
  parameter signed [15:0] coeff108 = 16'b1111111010010100; //sfix16_En17
  parameter signed [15:0] coeff109 = 16'b1111111100101001; //sfix16_En17
  parameter signed [15:0] coeff110 = 16'b0000000010101001; //sfix16_En17
  parameter signed [15:0] coeff111 = 16'b0000000101001010; //sfix16_En17
  parameter signed [15:0] coeff112 = 16'b0000000000001100; //sfix16_En17
  parameter signed [15:0] coeff113 = 16'b1111110101111111; //sfix16_En17
  parameter signed [15:0] coeff114 = 16'b1111101101010001; //sfix16_En17
  parameter signed [15:0] coeff115 = 16'b1111101100000100; //sfix16_En17
  parameter signed [15:0] coeff116 = 16'b1111110011100100; //sfix16_En17
  parameter signed [15:0] coeff117 = 16'b1111111111101001; //sfix16_En17
  parameter signed [15:0] coeff118 = 16'b0000001001111111; //sfix16_En17
  parameter signed [15:0] coeff119 = 16'b0000001110001100; //sfix16_En17
  parameter signed [15:0] coeff120 = 16'b0000001011111001; //sfix16_En17
  parameter signed [15:0] coeff121 = 16'b0000000110000010; //sfix16_En17
  parameter signed [15:0] coeff122 = 16'b0000000000011001; //sfix16_En17
  parameter signed [15:0] coeff123 = 16'b1111111101010010; //sfix16_En17
  parameter signed [15:0] coeff124 = 16'b1111111100111001; //sfix16_En17
  parameter signed [15:0] coeff125 = 16'b1111111101111101; //sfix16_En17
  parameter signed [15:0] coeff126 = 16'b1111111111001001; //sfix16_En17
  parameter signed [15:0] coeff127 = 16'b1111111111111000; //sfix16_En17
  parameter signed [15:0] coeff128 = 16'b1111111111111100; //sfix16_En17

  // Signals
  reg  signed [15:0] delay_pipeline [0:127] ; // sfix16_En15
  wire signed [30:0] product128; // sfix31_En32
  wire signed [16:0] mulpwr2_temp; // sfix17_En15
  wire signed [30:0] product127; // sfix31_En32
  wire signed [16:0] mulpwr2_temp_1; // sfix17_En15
  wire signed [30:0] product126; // sfix31_En32
  wire signed [31:0] mul_temp; // sfix32_En32
  wire signed [30:0] product125; // sfix31_En32
  wire signed [31:0] mul_temp_1; // sfix32_En32
  wire signed [30:0] product124; // sfix31_En32
  wire signed [31:0] mul_temp_2; // sfix32_En32
  wire signed [30:0] product123; // sfix31_En32
  wire signed [31:0] mul_temp_3; // sfix32_En32
  wire signed [30:0] product122; // sfix31_En32
  wire signed [31:0] mul_temp_4; // sfix32_En32
  wire signed [30:0] product121; // sfix31_En32
  wire signed [31:0] mul_temp_5; // sfix32_En32
  wire signed [30:0] product120; // sfix31_En32
  wire signed [31:0] mul_temp_6; // sfix32_En32
  wire signed [30:0] product119; // sfix31_En32
  wire signed [31:0] mul_temp_7; // sfix32_En32
  wire signed [30:0] product118; // sfix31_En32
  wire signed [31:0] mul_temp_8; // sfix32_En32
  wire signed [30:0] product117; // sfix31_En32
  wire signed [31:0] mul_temp_9; // sfix32_En32
  wire signed [30:0] product116; // sfix31_En32
  wire signed [31:0] mul_temp_10; // sfix32_En32
  wire signed [30:0] product115; // sfix31_En32
  wire signed [31:0] mul_temp_11; // sfix32_En32
  wire signed [30:0] product114; // sfix31_En32
  wire signed [31:0] mul_temp_12; // sfix32_En32
  wire signed [30:0] product113; // sfix31_En32
  wire signed [31:0] mul_temp_13; // sfix32_En32
  wire signed [30:0] product112; // sfix31_En32
  wire signed [31:0] mul_temp_14; // sfix32_En32
  wire signed [30:0] product111; // sfix31_En32
  wire signed [31:0] mul_temp_15; // sfix32_En32
  wire signed [30:0] product110; // sfix31_En32
  wire signed [31:0] mul_temp_16; // sfix32_En32
  wire signed [30:0] product109; // sfix31_En32
  wire signed [31:0] mul_temp_17; // sfix32_En32
  wire signed [30:0] product108; // sfix31_En32
  wire signed [31:0] mul_temp_18; // sfix32_En32
  wire signed [30:0] product107; // sfix31_En32
  wire signed [31:0] mul_temp_19; // sfix32_En32
  wire signed [30:0] product106; // sfix31_En32
  wire signed [31:0] mul_temp_20; // sfix32_En32
  wire signed [30:0] product105; // sfix31_En32
  wire signed [31:0] mul_temp_21; // sfix32_En32
  wire signed [30:0] product104; // sfix31_En32
  wire signed [31:0] mul_temp_22; // sfix32_En32
  wire signed [30:0] product103; // sfix31_En32
  wire signed [31:0] mul_temp_23; // sfix32_En32
  wire signed [30:0] product102; // sfix31_En32
  wire signed [31:0] mul_temp_24; // sfix32_En32
  wire signed [30:0] product101; // sfix31_En32
  wire signed [31:0] mul_temp_25; // sfix32_En32
  wire signed [30:0] product100; // sfix31_En32
  wire signed [31:0] mul_temp_26; // sfix32_En32
  wire signed [30:0] product99; // sfix31_En32
  wire signed [31:0] mul_temp_27; // sfix32_En32
  wire signed [30:0] product98; // sfix31_En32
  wire signed [31:0] mul_temp_28; // sfix32_En32
  wire signed [30:0] product97; // sfix31_En32
  wire signed [31:0] mul_temp_29; // sfix32_En32
  wire signed [30:0] product96; // sfix31_En32
  wire signed [31:0] mul_temp_30; // sfix32_En32
  wire signed [30:0] product95; // sfix31_En32
  wire signed [31:0] mul_temp_31; // sfix32_En32
  wire signed [30:0] product94; // sfix31_En32
  wire signed [31:0] mul_temp_32; // sfix32_En32
  wire signed [30:0] product93; // sfix31_En32
  wire signed [31:0] mul_temp_33; // sfix32_En32
  wire signed [30:0] product92; // sfix31_En32
  wire signed [31:0] mul_temp_34; // sfix32_En32
  wire signed [30:0] product91; // sfix31_En32
  wire signed [31:0] mul_temp_35; // sfix32_En32
  wire signed [30:0] product90; // sfix31_En32
  wire signed [31:0] mul_temp_36; // sfix32_En32
  wire signed [30:0] product89; // sfix31_En32
  wire signed [31:0] mul_temp_37; // sfix32_En32
  wire signed [30:0] product88; // sfix31_En32
  wire signed [31:0] mul_temp_38; // sfix32_En32
  wire signed [30:0] product87; // sfix31_En32
  wire signed [31:0] mul_temp_39; // sfix32_En32
  wire signed [30:0] product86; // sfix31_En32
  wire signed [31:0] mul_temp_40; // sfix32_En32
  wire signed [30:0] product85; // sfix31_En32
  wire signed [31:0] mul_temp_41; // sfix32_En32
  wire signed [30:0] product84; // sfix31_En32
  wire signed [31:0] mul_temp_42; // sfix32_En32
  wire signed [30:0] product83; // sfix31_En32
  wire signed [31:0] mul_temp_43; // sfix32_En32
  wire signed [30:0] product81; // sfix31_En32
  wire signed [31:0] mul_temp_44; // sfix32_En32
  wire signed [30:0] product80; // sfix31_En32
  wire signed [31:0] mul_temp_45; // sfix32_En32
  wire signed [30:0] product79; // sfix31_En32
  wire signed [31:0] mul_temp_46; // sfix32_En32
  wire signed [30:0] product78; // sfix31_En32
  wire signed [31:0] mul_temp_47; // sfix32_En32
  wire signed [30:0] product77; // sfix31_En32
  wire signed [31:0] mul_temp_48; // sfix32_En32
  wire signed [30:0] product76; // sfix31_En32
  wire signed [31:0] mul_temp_49; // sfix32_En32
  wire signed [30:0] product75; // sfix31_En32
  wire signed [31:0] mul_temp_50; // sfix32_En32
  wire signed [30:0] product74; // sfix31_En32
  wire signed [31:0] mul_temp_51; // sfix32_En32
  wire signed [30:0] product73; // sfix31_En32
  wire signed [31:0] mul_temp_52; // sfix32_En32
  wire signed [30:0] product72; // sfix31_En32
  wire signed [31:0] mul_temp_53; // sfix32_En32
  wire signed [30:0] product71; // sfix31_En32
  wire signed [31:0] mul_temp_54; // sfix32_En32
  wire signed [30:0] product70; // sfix31_En32
  wire signed [31:0] mul_temp_55; // sfix32_En32
  wire signed [30:0] product69; // sfix31_En32
  wire signed [31:0] mul_temp_56; // sfix32_En32
  wire signed [30:0] product68; // sfix31_En32
  wire signed [31:0] mul_temp_57; // sfix32_En32
  wire signed [30:0] product67; // sfix31_En32
  wire signed [31:0] mul_temp_58; // sfix32_En32
  wire signed [30:0] product66; // sfix31_En32
  wire signed [31:0] mul_temp_59; // sfix32_En32
  wire signed [30:0] product65; // sfix31_En32
  wire signed [31:0] mul_temp_60; // sfix32_En32
  wire signed [30:0] product64; // sfix31_En32
  wire signed [31:0] mul_temp_61; // sfix32_En32
  wire signed [30:0] product63; // sfix31_En32
  wire signed [31:0] mul_temp_62; // sfix32_En32
  wire signed [30:0] product62; // sfix31_En32
  wire signed [31:0] mul_temp_63; // sfix32_En32
  wire signed [30:0] product61; // sfix31_En32
  wire signed [31:0] mul_temp_64; // sfix32_En32
  wire signed [30:0] product60; // sfix31_En32
  wire signed [31:0] mul_temp_65; // sfix32_En32
  wire signed [30:0] product59; // sfix31_En32
  wire signed [31:0] mul_temp_66; // sfix32_En32
  wire signed [30:0] product58; // sfix31_En32
  wire signed [31:0] mul_temp_67; // sfix32_En32
  wire signed [30:0] product57; // sfix31_En32
  wire signed [31:0] mul_temp_68; // sfix32_En32
  wire signed [30:0] product56; // sfix31_En32
  wire signed [31:0] mul_temp_69; // sfix32_En32
  wire signed [30:0] product55; // sfix31_En32
  wire signed [31:0] mul_temp_70; // sfix32_En32
  wire signed [30:0] product54; // sfix31_En32
  wire signed [31:0] mul_temp_71; // sfix32_En32
  wire signed [30:0] product53; // sfix31_En32
  wire signed [31:0] mul_temp_72; // sfix32_En32
  wire signed [30:0] product52; // sfix31_En32
  wire signed [31:0] mul_temp_73; // sfix32_En32
  wire signed [30:0] product51; // sfix31_En32
  wire signed [31:0] mul_temp_74; // sfix32_En32
  wire signed [30:0] product50; // sfix31_En32
  wire signed [31:0] mul_temp_75; // sfix32_En32
  wire signed [30:0] product49; // sfix31_En32
  wire signed [31:0] mul_temp_76; // sfix32_En32
  wire signed [30:0] product48; // sfix31_En32
  wire signed [31:0] mul_temp_77; // sfix32_En32
  wire signed [30:0] product46; // sfix31_En32
  wire signed [31:0] mul_temp_78; // sfix32_En32
  wire signed [30:0] product45; // sfix31_En32
  wire signed [31:0] mul_temp_79; // sfix32_En32
  wire signed [30:0] product44; // sfix31_En32
  wire signed [31:0] mul_temp_80; // sfix32_En32
  wire signed [30:0] product43; // sfix31_En32
  wire signed [31:0] mul_temp_81; // sfix32_En32
  wire signed [30:0] product42; // sfix31_En32
  wire signed [31:0] mul_temp_82; // sfix32_En32
  wire signed [30:0] product41; // sfix31_En32
  wire signed [31:0] mul_temp_83; // sfix32_En32
  wire signed [30:0] product40; // sfix31_En32
  wire signed [31:0] mul_temp_84; // sfix32_En32
  wire signed [30:0] product39; // sfix31_En32
  wire signed [31:0] mul_temp_85; // sfix32_En32
  wire signed [30:0] product38; // sfix31_En32
  wire signed [31:0] mul_temp_86; // sfix32_En32
  wire signed [30:0] product37; // sfix31_En32
  wire signed [31:0] mul_temp_87; // sfix32_En32
  wire signed [30:0] product36; // sfix31_En32
  wire signed [31:0] mul_temp_88; // sfix32_En32
  wire signed [30:0] product35; // sfix31_En32
  wire signed [31:0] mul_temp_89; // sfix32_En32
  wire signed [30:0] product34; // sfix31_En32
  wire signed [31:0] mul_temp_90; // sfix32_En32
  wire signed [30:0] product33; // sfix31_En32
  wire signed [31:0] mul_temp_91; // sfix32_En32
  wire signed [30:0] product32; // sfix31_En32
  wire signed [31:0] mul_temp_92; // sfix32_En32
  wire signed [30:0] product31; // sfix31_En32
  wire signed [31:0] mul_temp_93; // sfix32_En32
  wire signed [30:0] product30; // sfix31_En32
  wire signed [31:0] mul_temp_94; // sfix32_En32
  wire signed [30:0] product29; // sfix31_En32
  wire signed [31:0] mul_temp_95; // sfix32_En32
  wire signed [30:0] product28; // sfix31_En32
  wire signed [31:0] mul_temp_96; // sfix32_En32
  wire signed [30:0] product27; // sfix31_En32
  wire signed [31:0] mul_temp_97; // sfix32_En32
  wire signed [30:0] product26; // sfix31_En32
  wire signed [31:0] mul_temp_98; // sfix32_En32
  wire signed [30:0] product25; // sfix31_En32
  wire signed [31:0] mul_temp_99; // sfix32_En32
  wire signed [30:0] product24; // sfix31_En32
  wire signed [31:0] mul_temp_100; // sfix32_En32
  wire signed [30:0] product23; // sfix31_En32
  wire signed [31:0] mul_temp_101; // sfix32_En32
  wire signed [30:0] product22; // sfix31_En32
  wire signed [31:0] mul_temp_102; // sfix32_En32
  wire signed [30:0] product21; // sfix31_En32
  wire signed [31:0] mul_temp_103; // sfix32_En32
  wire signed [30:0] product20; // sfix31_En32
  wire signed [31:0] mul_temp_104; // sfix32_En32
  wire signed [30:0] product19; // sfix31_En32
  wire signed [31:0] mul_temp_105; // sfix32_En32
  wire signed [30:0] product18; // sfix31_En32
  wire signed [31:0] mul_temp_106; // sfix32_En32
  wire signed [30:0] product17; // sfix31_En32
  wire signed [31:0] mul_temp_107; // sfix32_En32
  wire signed [30:0] product16; // sfix31_En32
  wire signed [31:0] mul_temp_108; // sfix32_En32
  wire signed [30:0] product15; // sfix31_En32
  wire signed [31:0] mul_temp_109; // sfix32_En32
  wire signed [30:0] product14; // sfix31_En32
  wire signed [31:0] mul_temp_110; // sfix32_En32
  wire signed [30:0] product13; // sfix31_En32
  wire signed [31:0] mul_temp_111; // sfix32_En32
  wire signed [30:0] product12; // sfix31_En32
  wire signed [31:0] mul_temp_112; // sfix32_En32
  wire signed [30:0] product11; // sfix31_En32
  wire signed [31:0] mul_temp_113; // sfix32_En32
  wire signed [30:0] product10; // sfix31_En32
  wire signed [31:0] mul_temp_114; // sfix32_En32
  wire signed [30:0] product9; // sfix31_En32
  wire signed [31:0] mul_temp_115; // sfix32_En32
  wire signed [30:0] product8; // sfix31_En32
  wire signed [31:0] mul_temp_116; // sfix32_En32
  wire signed [30:0] product7; // sfix31_En32
  wire signed [31:0] mul_temp_117; // sfix32_En32
  wire signed [30:0] product6; // sfix31_En32
  wire signed [31:0] mul_temp_118; // sfix32_En32
  wire signed [30:0] product5; // sfix31_En32
  wire signed [31:0] mul_temp_119; // sfix32_En32
  wire signed [30:0] product4; // sfix31_En32
  wire signed [31:0] mul_temp_120; // sfix32_En32
  wire signed [30:0] product3; // sfix31_En32
  wire signed [31:0] mul_temp_121; // sfix32_En32
  wire signed [30:0] product2; // sfix31_En32
  wire signed [16:0] mulpwr2_temp_2; // sfix17_En15
  wire signed [34:0] product1_cast; // sfix35_En32
  wire signed [30:0] product1; // sfix31_En32
  wire signed [16:0] mulpwr2_temp_3; // sfix17_En15
  wire signed [34:0] sum1; // sfix35_En32
  wire signed [34:0] add_signext; // sfix35_En32
  wire signed [34:0] add_signext_1; // sfix35_En32
  wire signed [35:0] add_temp; // sfix36_En32
  wire signed [34:0] sum2; // sfix35_En32
  wire signed [34:0] add_signext_2; // sfix35_En32
  wire signed [34:0] add_signext_3; // sfix35_En32
  wire signed [35:0] add_temp_1; // sfix36_En32
  wire signed [34:0] sum3; // sfix35_En32
  wire signed [34:0] add_signext_4; // sfix35_En32
  wire signed [34:0] add_signext_5; // sfix35_En32
  wire signed [35:0] add_temp_2; // sfix36_En32
  wire signed [34:0] sum4; // sfix35_En32
  wire signed [34:0] add_signext_6; // sfix35_En32
  wire signed [34:0] add_signext_7; // sfix35_En32
  wire signed [35:0] add_temp_3; // sfix36_En32
  wire signed [34:0] sum5; // sfix35_En32
  wire signed [34:0] add_signext_8; // sfix35_En32
  wire signed [34:0] add_signext_9; // sfix35_En32
  wire signed [35:0] add_temp_4; // sfix36_En32
  wire signed [34:0] sum6; // sfix35_En32
  wire signed [34:0] add_signext_10; // sfix35_En32
  wire signed [34:0] add_signext_11; // sfix35_En32
  wire signed [35:0] add_temp_5; // sfix36_En32
  wire signed [34:0] sum7; // sfix35_En32
  wire signed [34:0] add_signext_12; // sfix35_En32
  wire signed [34:0] add_signext_13; // sfix35_En32
  wire signed [35:0] add_temp_6; // sfix36_En32
  wire signed [34:0] sum8; // sfix35_En32
  wire signed [34:0] add_signext_14; // sfix35_En32
  wire signed [34:0] add_signext_15; // sfix35_En32
  wire signed [35:0] add_temp_7; // sfix36_En32
  wire signed [34:0] sum9; // sfix35_En32
  wire signed [34:0] add_signext_16; // sfix35_En32
  wire signed [34:0] add_signext_17; // sfix35_En32
  wire signed [35:0] add_temp_8; // sfix36_En32
  wire signed [34:0] sum10; // sfix35_En32
  wire signed [34:0] add_signext_18; // sfix35_En32
  wire signed [34:0] add_signext_19; // sfix35_En32
  wire signed [35:0] add_temp_9; // sfix36_En32
  wire signed [34:0] sum11; // sfix35_En32
  wire signed [34:0] add_signext_20; // sfix35_En32
  wire signed [34:0] add_signext_21; // sfix35_En32
  wire signed [35:0] add_temp_10; // sfix36_En32
  wire signed [34:0] sum12; // sfix35_En32
  wire signed [34:0] add_signext_22; // sfix35_En32
  wire signed [34:0] add_signext_23; // sfix35_En32
  wire signed [35:0] add_temp_11; // sfix36_En32
  wire signed [34:0] sum13; // sfix35_En32
  wire signed [34:0] add_signext_24; // sfix35_En32
  wire signed [34:0] add_signext_25; // sfix35_En32
  wire signed [35:0] add_temp_12; // sfix36_En32
  wire signed [34:0] sum14; // sfix35_En32
  wire signed [34:0] add_signext_26; // sfix35_En32
  wire signed [34:0] add_signext_27; // sfix35_En32
  wire signed [35:0] add_temp_13; // sfix36_En32
  wire signed [34:0] sum15; // sfix35_En32
  wire signed [34:0] add_signext_28; // sfix35_En32
  wire signed [34:0] add_signext_29; // sfix35_En32
  wire signed [35:0] add_temp_14; // sfix36_En32
  wire signed [34:0] sum16; // sfix35_En32
  wire signed [34:0] add_signext_30; // sfix35_En32
  wire signed [34:0] add_signext_31; // sfix35_En32
  wire signed [35:0] add_temp_15; // sfix36_En32
  wire signed [34:0] sum17; // sfix35_En32
  wire signed [34:0] add_signext_32; // sfix35_En32
  wire signed [34:0] add_signext_33; // sfix35_En32
  wire signed [35:0] add_temp_16; // sfix36_En32
  wire signed [34:0] sum18; // sfix35_En32
  wire signed [34:0] add_signext_34; // sfix35_En32
  wire signed [34:0] add_signext_35; // sfix35_En32
  wire signed [35:0] add_temp_17; // sfix36_En32
  wire signed [34:0] sum19; // sfix35_En32
  wire signed [34:0] add_signext_36; // sfix35_En32
  wire signed [34:0] add_signext_37; // sfix35_En32
  wire signed [35:0] add_temp_18; // sfix36_En32
  wire signed [34:0] sum20; // sfix35_En32
  wire signed [34:0] add_signext_38; // sfix35_En32
  wire signed [34:0] add_signext_39; // sfix35_En32
  wire signed [35:0] add_temp_19; // sfix36_En32
  wire signed [34:0] sum21; // sfix35_En32
  wire signed [34:0] add_signext_40; // sfix35_En32
  wire signed [34:0] add_signext_41; // sfix35_En32
  wire signed [35:0] add_temp_20; // sfix36_En32
  wire signed [34:0] sum22; // sfix35_En32
  wire signed [34:0] add_signext_42; // sfix35_En32
  wire signed [34:0] add_signext_43; // sfix35_En32
  wire signed [35:0] add_temp_21; // sfix36_En32
  wire signed [34:0] sum23; // sfix35_En32
  wire signed [34:0] add_signext_44; // sfix35_En32
  wire signed [34:0] add_signext_45; // sfix35_En32
  wire signed [35:0] add_temp_22; // sfix36_En32
  wire signed [34:0] sum24; // sfix35_En32
  wire signed [34:0] add_signext_46; // sfix35_En32
  wire signed [34:0] add_signext_47; // sfix35_En32
  wire signed [35:0] add_temp_23; // sfix36_En32
  wire signed [34:0] sum25; // sfix35_En32
  wire signed [34:0] add_signext_48; // sfix35_En32
  wire signed [34:0] add_signext_49; // sfix35_En32
  wire signed [35:0] add_temp_24; // sfix36_En32
  wire signed [34:0] sum26; // sfix35_En32
  wire signed [34:0] add_signext_50; // sfix35_En32
  wire signed [34:0] add_signext_51; // sfix35_En32
  wire signed [35:0] add_temp_25; // sfix36_En32
  wire signed [34:0] sum27; // sfix35_En32
  wire signed [34:0] add_signext_52; // sfix35_En32
  wire signed [34:0] add_signext_53; // sfix35_En32
  wire signed [35:0] add_temp_26; // sfix36_En32
  wire signed [34:0] sum28; // sfix35_En32
  wire signed [34:0] add_signext_54; // sfix35_En32
  wire signed [34:0] add_signext_55; // sfix35_En32
  wire signed [35:0] add_temp_27; // sfix36_En32
  wire signed [34:0] sum29; // sfix35_En32
  wire signed [34:0] add_signext_56; // sfix35_En32
  wire signed [34:0] add_signext_57; // sfix35_En32
  wire signed [35:0] add_temp_28; // sfix36_En32
  wire signed [34:0] sum30; // sfix35_En32
  wire signed [34:0] add_signext_58; // sfix35_En32
  wire signed [34:0] add_signext_59; // sfix35_En32
  wire signed [35:0] add_temp_29; // sfix36_En32
  wire signed [34:0] sum31; // sfix35_En32
  wire signed [34:0] add_signext_60; // sfix35_En32
  wire signed [34:0] add_signext_61; // sfix35_En32
  wire signed [35:0] add_temp_30; // sfix36_En32
  wire signed [34:0] sum32; // sfix35_En32
  wire signed [34:0] add_signext_62; // sfix35_En32
  wire signed [34:0] add_signext_63; // sfix35_En32
  wire signed [35:0] add_temp_31; // sfix36_En32
  wire signed [34:0] sum33; // sfix35_En32
  wire signed [34:0] add_signext_64; // sfix35_En32
  wire signed [34:0] add_signext_65; // sfix35_En32
  wire signed [35:0] add_temp_32; // sfix36_En32
  wire signed [34:0] sum34; // sfix35_En32
  wire signed [34:0] add_signext_66; // sfix35_En32
  wire signed [34:0] add_signext_67; // sfix35_En32
  wire signed [35:0] add_temp_33; // sfix36_En32
  wire signed [34:0] sum35; // sfix35_En32
  wire signed [34:0] add_signext_68; // sfix35_En32
  wire signed [34:0] add_signext_69; // sfix35_En32
  wire signed [35:0] add_temp_34; // sfix36_En32
  wire signed [34:0] sum36; // sfix35_En32
  wire signed [34:0] add_signext_70; // sfix35_En32
  wire signed [34:0] add_signext_71; // sfix35_En32
  wire signed [35:0] add_temp_35; // sfix36_En32
  wire signed [34:0] sum37; // sfix35_En32
  wire signed [34:0] add_signext_72; // sfix35_En32
  wire signed [34:0] add_signext_73; // sfix35_En32
  wire signed [35:0] add_temp_36; // sfix36_En32
  wire signed [34:0] sum38; // sfix35_En32
  wire signed [34:0] add_signext_74; // sfix35_En32
  wire signed [34:0] add_signext_75; // sfix35_En32
  wire signed [35:0] add_temp_37; // sfix36_En32
  wire signed [34:0] sum39; // sfix35_En32
  wire signed [34:0] add_signext_76; // sfix35_En32
  wire signed [34:0] add_signext_77; // sfix35_En32
  wire signed [35:0] add_temp_38; // sfix36_En32
  wire signed [34:0] sum40; // sfix35_En32
  wire signed [34:0] add_signext_78; // sfix35_En32
  wire signed [34:0] add_signext_79; // sfix35_En32
  wire signed [35:0] add_temp_39; // sfix36_En32
  wire signed [34:0] sum41; // sfix35_En32
  wire signed [34:0] add_signext_80; // sfix35_En32
  wire signed [34:0] add_signext_81; // sfix35_En32
  wire signed [35:0] add_temp_40; // sfix36_En32
  wire signed [34:0] sum42; // sfix35_En32
  wire signed [34:0] add_signext_82; // sfix35_En32
  wire signed [34:0] add_signext_83; // sfix35_En32
  wire signed [35:0] add_temp_41; // sfix36_En32
  wire signed [34:0] sum43; // sfix35_En32
  wire signed [34:0] add_signext_84; // sfix35_En32
  wire signed [34:0] add_signext_85; // sfix35_En32
  wire signed [35:0] add_temp_42; // sfix36_En32
  wire signed [34:0] sum44; // sfix35_En32
  wire signed [34:0] add_signext_86; // sfix35_En32
  wire signed [34:0] add_signext_87; // sfix35_En32
  wire signed [35:0] add_temp_43; // sfix36_En32
  wire signed [34:0] sum45; // sfix35_En32
  wire signed [34:0] add_signext_88; // sfix35_En32
  wire signed [34:0] add_signext_89; // sfix35_En32
  wire signed [35:0] add_temp_44; // sfix36_En32
  wire signed [34:0] sum46; // sfix35_En32
  wire signed [34:0] add_signext_90; // sfix35_En32
  wire signed [34:0] add_signext_91; // sfix35_En32
  wire signed [35:0] add_temp_45; // sfix36_En32
  wire signed [34:0] sum47; // sfix35_En32
  wire signed [34:0] add_signext_92; // sfix35_En32
  wire signed [34:0] add_signext_93; // sfix35_En32
  wire signed [35:0] add_temp_46; // sfix36_En32
  wire signed [34:0] sum48; // sfix35_En32
  wire signed [34:0] add_signext_94; // sfix35_En32
  wire signed [34:0] add_signext_95; // sfix35_En32
  wire signed [35:0] add_temp_47; // sfix36_En32
  wire signed [34:0] sum49; // sfix35_En32
  wire signed [34:0] add_signext_96; // sfix35_En32
  wire signed [34:0] add_signext_97; // sfix35_En32
  wire signed [35:0] add_temp_48; // sfix36_En32
  wire signed [34:0] sum50; // sfix35_En32
  wire signed [34:0] add_signext_98; // sfix35_En32
  wire signed [34:0] add_signext_99; // sfix35_En32
  wire signed [35:0] add_temp_49; // sfix36_En32
  wire signed [34:0] sum51; // sfix35_En32
  wire signed [34:0] add_signext_100; // sfix35_En32
  wire signed [34:0] add_signext_101; // sfix35_En32
  wire signed [35:0] add_temp_50; // sfix36_En32
  wire signed [34:0] sum52; // sfix35_En32
  wire signed [34:0] add_signext_102; // sfix35_En32
  wire signed [34:0] add_signext_103; // sfix35_En32
  wire signed [35:0] add_temp_51; // sfix36_En32
  wire signed [34:0] sum53; // sfix35_En32
  wire signed [34:0] add_signext_104; // sfix35_En32
  wire signed [34:0] add_signext_105; // sfix35_En32
  wire signed [35:0] add_temp_52; // sfix36_En32
  wire signed [34:0] sum54; // sfix35_En32
  wire signed [34:0] add_signext_106; // sfix35_En32
  wire signed [34:0] add_signext_107; // sfix35_En32
  wire signed [35:0] add_temp_53; // sfix36_En32
  wire signed [34:0] sum55; // sfix35_En32
  wire signed [34:0] add_signext_108; // sfix35_En32
  wire signed [34:0] add_signext_109; // sfix35_En32
  wire signed [35:0] add_temp_54; // sfix36_En32
  wire signed [34:0] sum56; // sfix35_En32
  wire signed [34:0] add_signext_110; // sfix35_En32
  wire signed [34:0] add_signext_111; // sfix35_En32
  wire signed [35:0] add_temp_55; // sfix36_En32
  wire signed [34:0] sum57; // sfix35_En32
  wire signed [34:0] add_signext_112; // sfix35_En32
  wire signed [34:0] add_signext_113; // sfix35_En32
  wire signed [35:0] add_temp_56; // sfix36_En32
  wire signed [34:0] sum58; // sfix35_En32
  wire signed [34:0] add_signext_114; // sfix35_En32
  wire signed [34:0] add_signext_115; // sfix35_En32
  wire signed [35:0] add_temp_57; // sfix36_En32
  wire signed [34:0] sum59; // sfix35_En32
  wire signed [34:0] add_signext_116; // sfix35_En32
  wire signed [34:0] add_signext_117; // sfix35_En32
  wire signed [35:0] add_temp_58; // sfix36_En32
  wire signed [34:0] sum60; // sfix35_En32
  wire signed [34:0] add_signext_118; // sfix35_En32
  wire signed [34:0] add_signext_119; // sfix35_En32
  wire signed [35:0] add_temp_59; // sfix36_En32
  wire signed [34:0] sum61; // sfix35_En32
  wire signed [34:0] add_signext_120; // sfix35_En32
  wire signed [34:0] add_signext_121; // sfix35_En32
  wire signed [35:0] add_temp_60; // sfix36_En32
  wire signed [34:0] sum62; // sfix35_En32
  wire signed [34:0] add_signext_122; // sfix35_En32
  wire signed [34:0] add_signext_123; // sfix35_En32
  wire signed [35:0] add_temp_61; // sfix36_En32
  wire signed [34:0] sum63; // sfix35_En32
  wire signed [34:0] add_signext_124; // sfix35_En32
  wire signed [34:0] add_signext_125; // sfix35_En32
  wire signed [35:0] add_temp_62; // sfix36_En32
  wire signed [34:0] sum64; // sfix35_En32
  wire signed [34:0] add_signext_126; // sfix35_En32
  wire signed [34:0] add_signext_127; // sfix35_En32
  wire signed [35:0] add_temp_63; // sfix36_En32
  wire signed [34:0] sum65; // sfix35_En32
  wire signed [34:0] add_signext_128; // sfix35_En32
  wire signed [34:0] add_signext_129; // sfix35_En32
  wire signed [35:0] add_temp_64; // sfix36_En32
  wire signed [34:0] sum66; // sfix35_En32
  wire signed [34:0] add_signext_130; // sfix35_En32
  wire signed [34:0] add_signext_131; // sfix35_En32
  wire signed [35:0] add_temp_65; // sfix36_En32
  wire signed [34:0] sum67; // sfix35_En32
  wire signed [34:0] add_signext_132; // sfix35_En32
  wire signed [34:0] add_signext_133; // sfix35_En32
  wire signed [35:0] add_temp_66; // sfix36_En32
  wire signed [34:0] sum68; // sfix35_En32
  wire signed [34:0] add_signext_134; // sfix35_En32
  wire signed [34:0] add_signext_135; // sfix35_En32
  wire signed [35:0] add_temp_67; // sfix36_En32
  wire signed [34:0] sum69; // sfix35_En32
  wire signed [34:0] add_signext_136; // sfix35_En32
  wire signed [34:0] add_signext_137; // sfix35_En32
  wire signed [35:0] add_temp_68; // sfix36_En32
  wire signed [34:0] sum70; // sfix35_En32
  wire signed [34:0] add_signext_138; // sfix35_En32
  wire signed [34:0] add_signext_139; // sfix35_En32
  wire signed [35:0] add_temp_69; // sfix36_En32
  wire signed [34:0] sum71; // sfix35_En32
  wire signed [34:0] add_signext_140; // sfix35_En32
  wire signed [34:0] add_signext_141; // sfix35_En32
  wire signed [35:0] add_temp_70; // sfix36_En32
  wire signed [34:0] sum72; // sfix35_En32
  wire signed [34:0] add_signext_142; // sfix35_En32
  wire signed [34:0] add_signext_143; // sfix35_En32
  wire signed [35:0] add_temp_71; // sfix36_En32
  wire signed [34:0] sum73; // sfix35_En32
  wire signed [34:0] add_signext_144; // sfix35_En32
  wire signed [34:0] add_signext_145; // sfix35_En32
  wire signed [35:0] add_temp_72; // sfix36_En32
  wire signed [34:0] sum74; // sfix35_En32
  wire signed [34:0] add_signext_146; // sfix35_En32
  wire signed [34:0] add_signext_147; // sfix35_En32
  wire signed [35:0] add_temp_73; // sfix36_En32
  wire signed [34:0] sum75; // sfix35_En32
  wire signed [34:0] add_signext_148; // sfix35_En32
  wire signed [34:0] add_signext_149; // sfix35_En32
  wire signed [35:0] add_temp_74; // sfix36_En32
  wire signed [34:0] sum76; // sfix35_En32
  wire signed [34:0] add_signext_150; // sfix35_En32
  wire signed [34:0] add_signext_151; // sfix35_En32
  wire signed [35:0] add_temp_75; // sfix36_En32
  wire signed [34:0] sum77; // sfix35_En32
  wire signed [34:0] add_signext_152; // sfix35_En32
  wire signed [34:0] add_signext_153; // sfix35_En32
  wire signed [35:0] add_temp_76; // sfix36_En32
  wire signed [34:0] sum78; // sfix35_En32
  wire signed [34:0] add_signext_154; // sfix35_En32
  wire signed [34:0] add_signext_155; // sfix35_En32
  wire signed [35:0] add_temp_77; // sfix36_En32
  wire signed [34:0] sum79; // sfix35_En32
  wire signed [34:0] add_signext_156; // sfix35_En32
  wire signed [34:0] add_signext_157; // sfix35_En32
  wire signed [35:0] add_temp_78; // sfix36_En32
  wire signed [34:0] sum80; // sfix35_En32
  wire signed [34:0] add_signext_158; // sfix35_En32
  wire signed [34:0] add_signext_159; // sfix35_En32
  wire signed [35:0] add_temp_79; // sfix36_En32
  wire signed [34:0] sum81; // sfix35_En32
  wire signed [34:0] add_signext_160; // sfix35_En32
  wire signed [34:0] add_signext_161; // sfix35_En32
  wire signed [35:0] add_temp_80; // sfix36_En32
  wire signed [34:0] sum82; // sfix35_En32
  wire signed [34:0] add_signext_162; // sfix35_En32
  wire signed [34:0] add_signext_163; // sfix35_En32
  wire signed [35:0] add_temp_81; // sfix36_En32
  wire signed [34:0] sum83; // sfix35_En32
  wire signed [34:0] add_signext_164; // sfix35_En32
  wire signed [34:0] add_signext_165; // sfix35_En32
  wire signed [35:0] add_temp_82; // sfix36_En32
  wire signed [34:0] sum84; // sfix35_En32
  wire signed [34:0] add_signext_166; // sfix35_En32
  wire signed [34:0] add_signext_167; // sfix35_En32
  wire signed [35:0] add_temp_83; // sfix36_En32
  wire signed [34:0] sum85; // sfix35_En32
  wire signed [34:0] add_signext_168; // sfix35_En32
  wire signed [34:0] add_signext_169; // sfix35_En32
  wire signed [35:0] add_temp_84; // sfix36_En32
  wire signed [34:0] sum86; // sfix35_En32
  wire signed [34:0] add_signext_170; // sfix35_En32
  wire signed [34:0] add_signext_171; // sfix35_En32
  wire signed [35:0] add_temp_85; // sfix36_En32
  wire signed [34:0] sum87; // sfix35_En32
  wire signed [34:0] add_signext_172; // sfix35_En32
  wire signed [34:0] add_signext_173; // sfix35_En32
  wire signed [35:0] add_temp_86; // sfix36_En32
  wire signed [34:0] sum88; // sfix35_En32
  wire signed [34:0] add_signext_174; // sfix35_En32
  wire signed [34:0] add_signext_175; // sfix35_En32
  wire signed [35:0] add_temp_87; // sfix36_En32
  wire signed [34:0] sum89; // sfix35_En32
  wire signed [34:0] add_signext_176; // sfix35_En32
  wire signed [34:0] add_signext_177; // sfix35_En32
  wire signed [35:0] add_temp_88; // sfix36_En32
  wire signed [34:0] sum90; // sfix35_En32
  wire signed [34:0] add_signext_178; // sfix35_En32
  wire signed [34:0] add_signext_179; // sfix35_En32
  wire signed [35:0] add_temp_89; // sfix36_En32
  wire signed [34:0] sum91; // sfix35_En32
  wire signed [34:0] add_signext_180; // sfix35_En32
  wire signed [34:0] add_signext_181; // sfix35_En32
  wire signed [35:0] add_temp_90; // sfix36_En32
  wire signed [34:0] sum92; // sfix35_En32
  wire signed [34:0] add_signext_182; // sfix35_En32
  wire signed [34:0] add_signext_183; // sfix35_En32
  wire signed [35:0] add_temp_91; // sfix36_En32
  wire signed [34:0] sum93; // sfix35_En32
  wire signed [34:0] add_signext_184; // sfix35_En32
  wire signed [34:0] add_signext_185; // sfix35_En32
  wire signed [35:0] add_temp_92; // sfix36_En32
  wire signed [34:0] sum94; // sfix35_En32
  wire signed [34:0] add_signext_186; // sfix35_En32
  wire signed [34:0] add_signext_187; // sfix35_En32
  wire signed [35:0] add_temp_93; // sfix36_En32
  wire signed [34:0] sum95; // sfix35_En32
  wire signed [34:0] add_signext_188; // sfix35_En32
  wire signed [34:0] add_signext_189; // sfix35_En32
  wire signed [35:0] add_temp_94; // sfix36_En32
  wire signed [34:0] sum96; // sfix35_En32
  wire signed [34:0] add_signext_190; // sfix35_En32
  wire signed [34:0] add_signext_191; // sfix35_En32
  wire signed [35:0] add_temp_95; // sfix36_En32
  wire signed [34:0] sum97; // sfix35_En32
  wire signed [34:0] add_signext_192; // sfix35_En32
  wire signed [34:0] add_signext_193; // sfix35_En32
  wire signed [35:0] add_temp_96; // sfix36_En32
  wire signed [34:0] sum98; // sfix35_En32
  wire signed [34:0] add_signext_194; // sfix35_En32
  wire signed [34:0] add_signext_195; // sfix35_En32
  wire signed [35:0] add_temp_97; // sfix36_En32
  wire signed [34:0] sum99; // sfix35_En32
  wire signed [34:0] add_signext_196; // sfix35_En32
  wire signed [34:0] add_signext_197; // sfix35_En32
  wire signed [35:0] add_temp_98; // sfix36_En32
  wire signed [34:0] sum100; // sfix35_En32
  wire signed [34:0] add_signext_198; // sfix35_En32
  wire signed [34:0] add_signext_199; // sfix35_En32
  wire signed [35:0] add_temp_99; // sfix36_En32
  wire signed [34:0] sum101; // sfix35_En32
  wire signed [34:0] add_signext_200; // sfix35_En32
  wire signed [34:0] add_signext_201; // sfix35_En32
  wire signed [35:0] add_temp_100; // sfix36_En32
  wire signed [34:0] sum102; // sfix35_En32
  wire signed [34:0] add_signext_202; // sfix35_En32
  wire signed [34:0] add_signext_203; // sfix35_En32
  wire signed [35:0] add_temp_101; // sfix36_En32
  wire signed [34:0] sum103; // sfix35_En32
  wire signed [34:0] add_signext_204; // sfix35_En32
  wire signed [34:0] add_signext_205; // sfix35_En32
  wire signed [35:0] add_temp_102; // sfix36_En32
  wire signed [34:0] sum104; // sfix35_En32
  wire signed [34:0] add_signext_206; // sfix35_En32
  wire signed [34:0] add_signext_207; // sfix35_En32
  wire signed [35:0] add_temp_103; // sfix36_En32
  wire signed [34:0] sum105; // sfix35_En32
  wire signed [34:0] add_signext_208; // sfix35_En32
  wire signed [34:0] add_signext_209; // sfix35_En32
  wire signed [35:0] add_temp_104; // sfix36_En32
  wire signed [34:0] sum106; // sfix35_En32
  wire signed [34:0] add_signext_210; // sfix35_En32
  wire signed [34:0] add_signext_211; // sfix35_En32
  wire signed [35:0] add_temp_105; // sfix36_En32
  wire signed [34:0] sum107; // sfix35_En32
  wire signed [34:0] add_signext_212; // sfix35_En32
  wire signed [34:0] add_signext_213; // sfix35_En32
  wire signed [35:0] add_temp_106; // sfix36_En32
  wire signed [34:0] sum108; // sfix35_En32
  wire signed [34:0] add_signext_214; // sfix35_En32
  wire signed [34:0] add_signext_215; // sfix35_En32
  wire signed [35:0] add_temp_107; // sfix36_En32
  wire signed [34:0] sum109; // sfix35_En32
  wire signed [34:0] add_signext_216; // sfix35_En32
  wire signed [34:0] add_signext_217; // sfix35_En32
  wire signed [35:0] add_temp_108; // sfix36_En32
  wire signed [34:0] sum110; // sfix35_En32
  wire signed [34:0] add_signext_218; // sfix35_En32
  wire signed [34:0] add_signext_219; // sfix35_En32
  wire signed [35:0] add_temp_109; // sfix36_En32
  wire signed [34:0] sum111; // sfix35_En32
  wire signed [34:0] add_signext_220; // sfix35_En32
  wire signed [34:0] add_signext_221; // sfix35_En32
  wire signed [35:0] add_temp_110; // sfix36_En32
  wire signed [34:0] sum112; // sfix35_En32
  wire signed [34:0] add_signext_222; // sfix35_En32
  wire signed [34:0] add_signext_223; // sfix35_En32
  wire signed [35:0] add_temp_111; // sfix36_En32
  wire signed [34:0] sum113; // sfix35_En32
  wire signed [34:0] add_signext_224; // sfix35_En32
  wire signed [34:0] add_signext_225; // sfix35_En32
  wire signed [35:0] add_temp_112; // sfix36_En32
  wire signed [34:0] sum114; // sfix35_En32
  wire signed [34:0] add_signext_226; // sfix35_En32
  wire signed [34:0] add_signext_227; // sfix35_En32
  wire signed [35:0] add_temp_113; // sfix36_En32
  wire signed [34:0] sum115; // sfix35_En32
  wire signed [34:0] add_signext_228; // sfix35_En32
  wire signed [34:0] add_signext_229; // sfix35_En32
  wire signed [35:0] add_temp_114; // sfix36_En32
  wire signed [34:0] sum116; // sfix35_En32
  wire signed [34:0] add_signext_230; // sfix35_En32
  wire signed [34:0] add_signext_231; // sfix35_En32
  wire signed [35:0] add_temp_115; // sfix36_En32
  wire signed [34:0] sum117; // sfix35_En32
  wire signed [34:0] add_signext_232; // sfix35_En32
  wire signed [34:0] add_signext_233; // sfix35_En32
  wire signed [35:0] add_temp_116; // sfix36_En32
  wire signed [34:0] sum118; // sfix35_En32
  wire signed [34:0] add_signext_234; // sfix35_En32
  wire signed [34:0] add_signext_235; // sfix35_En32
  wire signed [35:0] add_temp_117; // sfix36_En32
  wire signed [34:0] sum119; // sfix35_En32
  wire signed [34:0] add_signext_236; // sfix35_En32
  wire signed [34:0] add_signext_237; // sfix35_En32
  wire signed [35:0] add_temp_118; // sfix36_En32
  wire signed [34:0] sum120; // sfix35_En32
  wire signed [34:0] add_signext_238; // sfix35_En32
  wire signed [34:0] add_signext_239; // sfix35_En32
  wire signed [35:0] add_temp_119; // sfix36_En32
  wire signed [34:0] sum121; // sfix35_En32
  wire signed [34:0] add_signext_240; // sfix35_En32
  wire signed [34:0] add_signext_241; // sfix35_En32
  wire signed [35:0] add_temp_120; // sfix36_En32
  wire signed [34:0] sum122; // sfix35_En32
  wire signed [34:0] add_signext_242; // sfix35_En32
  wire signed [34:0] add_signext_243; // sfix35_En32
  wire signed [35:0] add_temp_121; // sfix36_En32
  wire signed [34:0] sum123; // sfix35_En32
  wire signed [34:0] add_signext_244; // sfix35_En32
  wire signed [34:0] add_signext_245; // sfix35_En32
  wire signed [35:0] add_temp_122; // sfix36_En32
  wire signed [34:0] sum124; // sfix35_En32
  wire signed [34:0] add_signext_246; // sfix35_En32
  wire signed [34:0] add_signext_247; // sfix35_En32
  wire signed [35:0] add_temp_123; // sfix36_En32
  wire signed [34:0] sum125; // sfix35_En32
  wire signed [34:0] add_signext_248; // sfix35_En32
  wire signed [34:0] add_signext_249; // sfix35_En32
  wire signed [35:0] add_temp_124; // sfix36_En32
  reg  signed [34:0] output_register; // sfix35_En32

  // Block Statements
  always @( posedge clk or posedge reset)
    begin: Delay_Pipeline_process
      if (reset == 1'b1) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
        delay_pipeline[10] <= 0;
        delay_pipeline[11] <= 0;
        delay_pipeline[12] <= 0;
        delay_pipeline[13] <= 0;
        delay_pipeline[14] <= 0;
        delay_pipeline[15] <= 0;
        delay_pipeline[16] <= 0;
        delay_pipeline[17] <= 0;
        delay_pipeline[18] <= 0;
        delay_pipeline[19] <= 0;
        delay_pipeline[20] <= 0;
        delay_pipeline[21] <= 0;
        delay_pipeline[22] <= 0;
        delay_pipeline[23] <= 0;
        delay_pipeline[24] <= 0;
        delay_pipeline[25] <= 0;
        delay_pipeline[26] <= 0;
        delay_pipeline[27] <= 0;
        delay_pipeline[28] <= 0;
        delay_pipeline[29] <= 0;
        delay_pipeline[30] <= 0;
        delay_pipeline[31] <= 0;
        delay_pipeline[32] <= 0;
        delay_pipeline[33] <= 0;
        delay_pipeline[34] <= 0;
        delay_pipeline[35] <= 0;
        delay_pipeline[36] <= 0;
        delay_pipeline[37] <= 0;
        delay_pipeline[38] <= 0;
        delay_pipeline[39] <= 0;
        delay_pipeline[40] <= 0;
        delay_pipeline[41] <= 0;
        delay_pipeline[42] <= 0;
        delay_pipeline[43] <= 0;
        delay_pipeline[44] <= 0;
        delay_pipeline[45] <= 0;
        delay_pipeline[46] <= 0;
        delay_pipeline[47] <= 0;
        delay_pipeline[48] <= 0;
        delay_pipeline[49] <= 0;
        delay_pipeline[50] <= 0;
        delay_pipeline[51] <= 0;
        delay_pipeline[52] <= 0;
        delay_pipeline[53] <= 0;
        delay_pipeline[54] <= 0;
        delay_pipeline[55] <= 0;
        delay_pipeline[56] <= 0;
        delay_pipeline[57] <= 0;
        delay_pipeline[58] <= 0;
        delay_pipeline[59] <= 0;
        delay_pipeline[60] <= 0;
        delay_pipeline[61] <= 0;
        delay_pipeline[62] <= 0;
        delay_pipeline[63] <= 0;
        delay_pipeline[64] <= 0;
        delay_pipeline[65] <= 0;
        delay_pipeline[66] <= 0;
        delay_pipeline[67] <= 0;
        delay_pipeline[68] <= 0;
        delay_pipeline[69] <= 0;
        delay_pipeline[70] <= 0;
        delay_pipeline[71] <= 0;
        delay_pipeline[72] <= 0;
        delay_pipeline[73] <= 0;
        delay_pipeline[74] <= 0;
        delay_pipeline[75] <= 0;
        delay_pipeline[76] <= 0;
        delay_pipeline[77] <= 0;
        delay_pipeline[78] <= 0;
        delay_pipeline[79] <= 0;
        delay_pipeline[80] <= 0;
        delay_pipeline[81] <= 0;
        delay_pipeline[82] <= 0;
        delay_pipeline[83] <= 0;
        delay_pipeline[84] <= 0;
        delay_pipeline[85] <= 0;
        delay_pipeline[86] <= 0;
        delay_pipeline[87] <= 0;
        delay_pipeline[88] <= 0;
        delay_pipeline[89] <= 0;
        delay_pipeline[90] <= 0;
        delay_pipeline[91] <= 0;
        delay_pipeline[92] <= 0;
        delay_pipeline[93] <= 0;
        delay_pipeline[94] <= 0;
        delay_pipeline[95] <= 0;
        delay_pipeline[96] <= 0;
        delay_pipeline[97] <= 0;
        delay_pipeline[98] <= 0;
        delay_pipeline[99] <= 0;
        delay_pipeline[100] <= 0;
        delay_pipeline[101] <= 0;
        delay_pipeline[102] <= 0;
        delay_pipeline[103] <= 0;
        delay_pipeline[104] <= 0;
        delay_pipeline[105] <= 0;
        delay_pipeline[106] <= 0;
        delay_pipeline[107] <= 0;
        delay_pipeline[108] <= 0;
        delay_pipeline[109] <= 0;
        delay_pipeline[110] <= 0;
        delay_pipeline[111] <= 0;
        delay_pipeline[112] <= 0;
        delay_pipeline[113] <= 0;
        delay_pipeline[114] <= 0;
        delay_pipeline[115] <= 0;
        delay_pipeline[116] <= 0;
        delay_pipeline[117] <= 0;
        delay_pipeline[118] <= 0;
        delay_pipeline[119] <= 0;
        delay_pipeline[120] <= 0;
        delay_pipeline[121] <= 0;
        delay_pipeline[122] <= 0;
        delay_pipeline[123] <= 0;
        delay_pipeline[124] <= 0;
        delay_pipeline[125] <= 0;
        delay_pipeline[126] <= 0;
        delay_pipeline[127] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
          delay_pipeline[9] <= delay_pipeline[8];
          delay_pipeline[10] <= delay_pipeline[9];
          delay_pipeline[11] <= delay_pipeline[10];
          delay_pipeline[12] <= delay_pipeline[11];
          delay_pipeline[13] <= delay_pipeline[12];
          delay_pipeline[14] <= delay_pipeline[13];
          delay_pipeline[15] <= delay_pipeline[14];
          delay_pipeline[16] <= delay_pipeline[15];
          delay_pipeline[17] <= delay_pipeline[16];
          delay_pipeline[18] <= delay_pipeline[17];
          delay_pipeline[19] <= delay_pipeline[18];
          delay_pipeline[20] <= delay_pipeline[19];
          delay_pipeline[21] <= delay_pipeline[20];
          delay_pipeline[22] <= delay_pipeline[21];
          delay_pipeline[23] <= delay_pipeline[22];
          delay_pipeline[24] <= delay_pipeline[23];
          delay_pipeline[25] <= delay_pipeline[24];
          delay_pipeline[26] <= delay_pipeline[25];
          delay_pipeline[27] <= delay_pipeline[26];
          delay_pipeline[28] <= delay_pipeline[27];
          delay_pipeline[29] <= delay_pipeline[28];
          delay_pipeline[30] <= delay_pipeline[29];
          delay_pipeline[31] <= delay_pipeline[30];
          delay_pipeline[32] <= delay_pipeline[31];
          delay_pipeline[33] <= delay_pipeline[32];
          delay_pipeline[34] <= delay_pipeline[33];
          delay_pipeline[35] <= delay_pipeline[34];
          delay_pipeline[36] <= delay_pipeline[35];
          delay_pipeline[37] <= delay_pipeline[36];
          delay_pipeline[38] <= delay_pipeline[37];
          delay_pipeline[39] <= delay_pipeline[38];
          delay_pipeline[40] <= delay_pipeline[39];
          delay_pipeline[41] <= delay_pipeline[40];
          delay_pipeline[42] <= delay_pipeline[41];
          delay_pipeline[43] <= delay_pipeline[42];
          delay_pipeline[44] <= delay_pipeline[43];
          delay_pipeline[45] <= delay_pipeline[44];
          delay_pipeline[46] <= delay_pipeline[45];
          delay_pipeline[47] <= delay_pipeline[46];
          delay_pipeline[48] <= delay_pipeline[47];
          delay_pipeline[49] <= delay_pipeline[48];
          delay_pipeline[50] <= delay_pipeline[49];
          delay_pipeline[51] <= delay_pipeline[50];
          delay_pipeline[52] <= delay_pipeline[51];
          delay_pipeline[53] <= delay_pipeline[52];
          delay_pipeline[54] <= delay_pipeline[53];
          delay_pipeline[55] <= delay_pipeline[54];
          delay_pipeline[56] <= delay_pipeline[55];
          delay_pipeline[57] <= delay_pipeline[56];
          delay_pipeline[58] <= delay_pipeline[57];
          delay_pipeline[59] <= delay_pipeline[58];
          delay_pipeline[60] <= delay_pipeline[59];
          delay_pipeline[61] <= delay_pipeline[60];
          delay_pipeline[62] <= delay_pipeline[61];
          delay_pipeline[63] <= delay_pipeline[62];
          delay_pipeline[64] <= delay_pipeline[63];
          delay_pipeline[65] <= delay_pipeline[64];
          delay_pipeline[66] <= delay_pipeline[65];
          delay_pipeline[67] <= delay_pipeline[66];
          delay_pipeline[68] <= delay_pipeline[67];
          delay_pipeline[69] <= delay_pipeline[68];
          delay_pipeline[70] <= delay_pipeline[69];
          delay_pipeline[71] <= delay_pipeline[70];
          delay_pipeline[72] <= delay_pipeline[71];
          delay_pipeline[73] <= delay_pipeline[72];
          delay_pipeline[74] <= delay_pipeline[73];
          delay_pipeline[75] <= delay_pipeline[74];
          delay_pipeline[76] <= delay_pipeline[75];
          delay_pipeline[77] <= delay_pipeline[76];
          delay_pipeline[78] <= delay_pipeline[77];
          delay_pipeline[79] <= delay_pipeline[78];
          delay_pipeline[80] <= delay_pipeline[79];
          delay_pipeline[81] <= delay_pipeline[80];
          delay_pipeline[82] <= delay_pipeline[81];
          delay_pipeline[83] <= delay_pipeline[82];
          delay_pipeline[84] <= delay_pipeline[83];
          delay_pipeline[85] <= delay_pipeline[84];
          delay_pipeline[86] <= delay_pipeline[85];
          delay_pipeline[87] <= delay_pipeline[86];
          delay_pipeline[88] <= delay_pipeline[87];
          delay_pipeline[89] <= delay_pipeline[88];
          delay_pipeline[90] <= delay_pipeline[89];
          delay_pipeline[91] <= delay_pipeline[90];
          delay_pipeline[92] <= delay_pipeline[91];
          delay_pipeline[93] <= delay_pipeline[92];
          delay_pipeline[94] <= delay_pipeline[93];
          delay_pipeline[95] <= delay_pipeline[94];
          delay_pipeline[96] <= delay_pipeline[95];
          delay_pipeline[97] <= delay_pipeline[96];
          delay_pipeline[98] <= delay_pipeline[97];
          delay_pipeline[99] <= delay_pipeline[98];
          delay_pipeline[100] <= delay_pipeline[99];
          delay_pipeline[101] <= delay_pipeline[100];
          delay_pipeline[102] <= delay_pipeline[101];
          delay_pipeline[103] <= delay_pipeline[102];
          delay_pipeline[104] <= delay_pipeline[103];
          delay_pipeline[105] <= delay_pipeline[104];
          delay_pipeline[106] <= delay_pipeline[105];
          delay_pipeline[107] <= delay_pipeline[106];
          delay_pipeline[108] <= delay_pipeline[107];
          delay_pipeline[109] <= delay_pipeline[108];
          delay_pipeline[110] <= delay_pipeline[109];
          delay_pipeline[111] <= delay_pipeline[110];
          delay_pipeline[112] <= delay_pipeline[111];
          delay_pipeline[113] <= delay_pipeline[112];
          delay_pipeline[114] <= delay_pipeline[113];
          delay_pipeline[115] <= delay_pipeline[114];
          delay_pipeline[116] <= delay_pipeline[115];
          delay_pipeline[117] <= delay_pipeline[116];
          delay_pipeline[118] <= delay_pipeline[117];
          delay_pipeline[119] <= delay_pipeline[118];
          delay_pipeline[120] <= delay_pipeline[119];
          delay_pipeline[121] <= delay_pipeline[120];
          delay_pipeline[122] <= delay_pipeline[121];
          delay_pipeline[123] <= delay_pipeline[122];
          delay_pipeline[124] <= delay_pipeline[123];
          delay_pipeline[125] <= delay_pipeline[124];
          delay_pipeline[126] <= delay_pipeline[125];
          delay_pipeline[127] <= delay_pipeline[126];
        end
      end
    end // Delay_Pipeline_process


  assign mulpwr2_temp = (delay_pipeline[127]==16'b1000000000000000) ? $signed({1'b0, delay_pipeline[127]}) : -delay_pipeline[127];

  assign product128 = $signed({mulpwr2_temp[16:0], 2'b00});

  assign mulpwr2_temp_1 = (delay_pipeline[126]==16'b1000000000000000) ? $signed({1'b0, delay_pipeline[126]}) : -delay_pipeline[126];

  assign product127 = $signed({mulpwr2_temp_1[16:0], 3'b000});

  assign mul_temp = delay_pipeline[125] * coeff126;
  assign product126 = mul_temp[30:0];

  assign mul_temp_1 = delay_pipeline[124] * coeff125;
  assign product125 = mul_temp_1[30:0];

  assign mul_temp_2 = delay_pipeline[123] * coeff124;
  assign product124 = mul_temp_2[30:0];

  assign mul_temp_3 = delay_pipeline[122] * coeff123;
  assign product123 = mul_temp_3[30:0];

  assign mul_temp_4 = delay_pipeline[121] * coeff122;
  assign product122 = mul_temp_4[30:0];

  assign mul_temp_5 = delay_pipeline[120] * coeff121;
  assign product121 = mul_temp_5[30:0];

  assign mul_temp_6 = delay_pipeline[119] * coeff120;
  assign product120 = mul_temp_6[30:0];

  assign mul_temp_7 = delay_pipeline[118] * coeff119;
  assign product119 = mul_temp_7[30:0];

  assign mul_temp_8 = delay_pipeline[117] * coeff118;
  assign product118 = mul_temp_8[30:0];

  assign mul_temp_9 = delay_pipeline[116] * coeff117;
  assign product117 = mul_temp_9[30:0];

  assign mul_temp_10 = delay_pipeline[115] * coeff116;
  assign product116 = mul_temp_10[30:0];

  assign mul_temp_11 = delay_pipeline[114] * coeff115;
  assign product115 = mul_temp_11[30:0];

  assign mul_temp_12 = delay_pipeline[113] * coeff114;
  assign product114 = mul_temp_12[30:0];

  assign mul_temp_13 = delay_pipeline[112] * coeff113;
  assign product113 = mul_temp_13[30:0];

  assign mul_temp_14 = delay_pipeline[111] * coeff112;
  assign product112 = mul_temp_14[30:0];

  assign mul_temp_15 = delay_pipeline[110] * coeff111;
  assign product111 = mul_temp_15[30:0];

  assign mul_temp_16 = delay_pipeline[109] * coeff110;
  assign product110 = mul_temp_16[30:0];

  assign mul_temp_17 = delay_pipeline[108] * coeff109;
  assign product109 = mul_temp_17[30:0];

  assign mul_temp_18 = delay_pipeline[107] * coeff108;
  assign product108 = mul_temp_18[30:0];

  assign mul_temp_19 = delay_pipeline[106] * coeff107;
  assign product107 = mul_temp_19[30:0];

  assign mul_temp_20 = delay_pipeline[105] * coeff106;
  assign product106 = mul_temp_20[30:0];

  assign mul_temp_21 = delay_pipeline[104] * coeff105;
  assign product105 = mul_temp_21[30:0];

  assign mul_temp_22 = delay_pipeline[103] * coeff104;
  assign product104 = mul_temp_22[30:0];

  assign mul_temp_23 = delay_pipeline[102] * coeff103;
  assign product103 = mul_temp_23[30:0];

  assign mul_temp_24 = delay_pipeline[101] * coeff102;
  assign product102 = mul_temp_24[30:0];

  assign mul_temp_25 = delay_pipeline[100] * coeff101;
  assign product101 = mul_temp_25[30:0];

  assign mul_temp_26 = delay_pipeline[99] * coeff100;
  assign product100 = mul_temp_26[30:0];

  assign mul_temp_27 = delay_pipeline[98] * coeff99;
  assign product99 = mul_temp_27[30:0];

  assign mul_temp_28 = delay_pipeline[97] * coeff98;
  assign product98 = mul_temp_28[30:0];

  assign mul_temp_29 = delay_pipeline[96] * coeff97;
  assign product97 = mul_temp_29[30:0];

  assign mul_temp_30 = delay_pipeline[95] * coeff96;
  assign product96 = mul_temp_30[30:0];

  assign mul_temp_31 = delay_pipeline[94] * coeff95;
  assign product95 = mul_temp_31[30:0];

  assign mul_temp_32 = delay_pipeline[93] * coeff94;
  assign product94 = mul_temp_32[30:0];

  assign mul_temp_33 = delay_pipeline[92] * coeff93;
  assign product93 = mul_temp_33[30:0];

  assign mul_temp_34 = delay_pipeline[91] * coeff92;
  assign product92 = mul_temp_34[30:0];

  assign mul_temp_35 = delay_pipeline[90] * coeff91;
  assign product91 = mul_temp_35[30:0];

  assign mul_temp_36 = delay_pipeline[89] * coeff90;
  assign product90 = mul_temp_36[30:0];

  assign mul_temp_37 = delay_pipeline[88] * coeff89;
  assign product89 = mul_temp_37[30:0];

  assign mul_temp_38 = delay_pipeline[87] * coeff88;
  assign product88 = mul_temp_38[30:0];

  assign mul_temp_39 = delay_pipeline[86] * coeff87;
  assign product87 = mul_temp_39[30:0];

  assign mul_temp_40 = delay_pipeline[85] * coeff86;
  assign product86 = mul_temp_40[30:0];

  assign mul_temp_41 = delay_pipeline[84] * coeff85;
  assign product85 = mul_temp_41[30:0];

  assign mul_temp_42 = delay_pipeline[83] * coeff84;
  assign product84 = mul_temp_42[30:0];

  assign mul_temp_43 = delay_pipeline[82] * coeff83;
  assign product83 = mul_temp_43[30:0];

  assign mul_temp_44 = delay_pipeline[80] * coeff81;
  assign product81 = mul_temp_44[30:0];

  assign mul_temp_45 = delay_pipeline[79] * coeff80;
  assign product80 = mul_temp_45[30:0];

  assign mul_temp_46 = delay_pipeline[78] * coeff79;
  assign product79 = mul_temp_46[30:0];

  assign mul_temp_47 = delay_pipeline[77] * coeff78;
  assign product78 = mul_temp_47[30:0];

  assign mul_temp_48 = delay_pipeline[76] * coeff77;
  assign product77 = mul_temp_48[30:0];

  assign mul_temp_49 = delay_pipeline[75] * coeff76;
  assign product76 = mul_temp_49[30:0];

  assign mul_temp_50 = delay_pipeline[74] * coeff75;
  assign product75 = mul_temp_50[30:0];

  assign mul_temp_51 = delay_pipeline[73] * coeff74;
  assign product74 = mul_temp_51[30:0];

  assign mul_temp_52 = delay_pipeline[72] * coeff73;
  assign product73 = mul_temp_52[30:0];

  assign mul_temp_53 = delay_pipeline[71] * coeff72;
  assign product72 = mul_temp_53[30:0];

  assign mul_temp_54 = delay_pipeline[70] * coeff71;
  assign product71 = mul_temp_54[30:0];

  assign mul_temp_55 = delay_pipeline[69] * coeff70;
  assign product70 = mul_temp_55[30:0];

  assign mul_temp_56 = delay_pipeline[68] * coeff69;
  assign product69 = mul_temp_56[30:0];

  assign mul_temp_57 = delay_pipeline[67] * coeff68;
  assign product68 = mul_temp_57[30:0];

  assign mul_temp_58 = delay_pipeline[66] * coeff67;
  assign product67 = mul_temp_58[30:0];

  assign mul_temp_59 = delay_pipeline[65] * coeff66;
  assign product66 = mul_temp_59[30:0];

  assign mul_temp_60 = delay_pipeline[64] * coeff65;
  assign product65 = mul_temp_60[30:0];

  assign mul_temp_61 = delay_pipeline[63] * coeff64;
  assign product64 = mul_temp_61[30:0];

  assign mul_temp_62 = delay_pipeline[62] * coeff63;
  assign product63 = mul_temp_62[30:0];

  assign mul_temp_63 = delay_pipeline[61] * coeff62;
  assign product62 = mul_temp_63[30:0];

  assign mul_temp_64 = delay_pipeline[60] * coeff61;
  assign product61 = mul_temp_64[30:0];

  assign mul_temp_65 = delay_pipeline[59] * coeff60;
  assign product60 = mul_temp_65[30:0];

  assign mul_temp_66 = delay_pipeline[58] * coeff59;
  assign product59 = mul_temp_66[30:0];

  assign mul_temp_67 = delay_pipeline[57] * coeff58;
  assign product58 = mul_temp_67[30:0];

  assign mul_temp_68 = delay_pipeline[56] * coeff57;
  assign product57 = mul_temp_68[30:0];

  assign mul_temp_69 = delay_pipeline[55] * coeff56;
  assign product56 = mul_temp_69[30:0];

  assign mul_temp_70 = delay_pipeline[54] * coeff55;
  assign product55 = mul_temp_70[30:0];

  assign mul_temp_71 = delay_pipeline[53] * coeff54;
  assign product54 = mul_temp_71[30:0];

  assign mul_temp_72 = delay_pipeline[52] * coeff53;
  assign product53 = mul_temp_72[30:0];

  assign mul_temp_73 = delay_pipeline[51] * coeff52;
  assign product52 = mul_temp_73[30:0];

  assign mul_temp_74 = delay_pipeline[50] * coeff51;
  assign product51 = mul_temp_74[30:0];

  assign mul_temp_75 = delay_pipeline[49] * coeff50;
  assign product50 = mul_temp_75[30:0];

  assign mul_temp_76 = delay_pipeline[48] * coeff49;
  assign product49 = mul_temp_76[30:0];

  assign mul_temp_77 = delay_pipeline[47] * coeff48;
  assign product48 = mul_temp_77[30:0];

  assign mul_temp_78 = delay_pipeline[45] * coeff46;
  assign product46 = mul_temp_78[30:0];

  assign mul_temp_79 = delay_pipeline[44] * coeff45;
  assign product45 = mul_temp_79[30:0];

  assign mul_temp_80 = delay_pipeline[43] * coeff44;
  assign product44 = mul_temp_80[30:0];

  assign mul_temp_81 = delay_pipeline[42] * coeff43;
  assign product43 = mul_temp_81[30:0];

  assign mul_temp_82 = delay_pipeline[41] * coeff42;
  assign product42 = mul_temp_82[30:0];

  assign mul_temp_83 = delay_pipeline[40] * coeff41;
  assign product41 = mul_temp_83[30:0];

  assign mul_temp_84 = delay_pipeline[39] * coeff40;
  assign product40 = mul_temp_84[30:0];

  assign mul_temp_85 = delay_pipeline[38] * coeff39;
  assign product39 = mul_temp_85[30:0];

  assign mul_temp_86 = delay_pipeline[37] * coeff38;
  assign product38 = mul_temp_86[30:0];

  assign mul_temp_87 = delay_pipeline[36] * coeff37;
  assign product37 = mul_temp_87[30:0];

  assign mul_temp_88 = delay_pipeline[35] * coeff36;
  assign product36 = mul_temp_88[30:0];

  assign mul_temp_89 = delay_pipeline[34] * coeff35;
  assign product35 = mul_temp_89[30:0];

  assign mul_temp_90 = delay_pipeline[33] * coeff34;
  assign product34 = mul_temp_90[30:0];

  assign mul_temp_91 = delay_pipeline[32] * coeff33;
  assign product33 = mul_temp_91[30:0];

  assign mul_temp_92 = delay_pipeline[31] * coeff32;
  assign product32 = mul_temp_92[30:0];

  assign mul_temp_93 = delay_pipeline[30] * coeff31;
  assign product31 = mul_temp_93[30:0];

  assign mul_temp_94 = delay_pipeline[29] * coeff30;
  assign product30 = mul_temp_94[30:0];

  assign mul_temp_95 = delay_pipeline[28] * coeff29;
  assign product29 = mul_temp_95[30:0];

  assign mul_temp_96 = delay_pipeline[27] * coeff28;
  assign product28 = mul_temp_96[30:0];

  assign mul_temp_97 = delay_pipeline[26] * coeff27;
  assign product27 = mul_temp_97[30:0];

  assign mul_temp_98 = delay_pipeline[25] * coeff26;
  assign product26 = mul_temp_98[30:0];

  assign mul_temp_99 = delay_pipeline[24] * coeff25;
  assign product25 = mul_temp_99[30:0];

  assign mul_temp_100 = delay_pipeline[23] * coeff24;
  assign product24 = mul_temp_100[30:0];

  assign mul_temp_101 = delay_pipeline[22] * coeff23;
  assign product23 = mul_temp_101[30:0];

  assign mul_temp_102 = delay_pipeline[21] * coeff22;
  assign product22 = mul_temp_102[30:0];

  assign mul_temp_103 = delay_pipeline[20] * coeff21;
  assign product21 = mul_temp_103[30:0];

  assign mul_temp_104 = delay_pipeline[19] * coeff20;
  assign product20 = mul_temp_104[30:0];

  assign mul_temp_105 = delay_pipeline[18] * coeff19;
  assign product19 = mul_temp_105[30:0];

  assign mul_temp_106 = delay_pipeline[17] * coeff18;
  assign product18 = mul_temp_106[30:0];

  assign mul_temp_107 = delay_pipeline[16] * coeff17;
  assign product17 = mul_temp_107[30:0];

  assign mul_temp_108 = delay_pipeline[15] * coeff16;
  assign product16 = mul_temp_108[30:0];

  assign mul_temp_109 = delay_pipeline[14] * coeff15;
  assign product15 = mul_temp_109[30:0];

  assign mul_temp_110 = delay_pipeline[13] * coeff14;
  assign product14 = mul_temp_110[30:0];

  assign mul_temp_111 = delay_pipeline[12] * coeff13;
  assign product13 = mul_temp_111[30:0];

  assign mul_temp_112 = delay_pipeline[11] * coeff12;
  assign product12 = mul_temp_112[30:0];

  assign mul_temp_113 = delay_pipeline[10] * coeff11;
  assign product11 = mul_temp_113[30:0];

  assign mul_temp_114 = delay_pipeline[9] * coeff10;
  assign product10 = mul_temp_114[30:0];

  assign mul_temp_115 = delay_pipeline[8] * coeff9;
  assign product9 = mul_temp_115[30:0];

  assign mul_temp_116 = delay_pipeline[7] * coeff8;
  assign product8 = mul_temp_116[30:0];

  assign mul_temp_117 = delay_pipeline[6] * coeff7;
  assign product7 = mul_temp_117[30:0];

  assign mul_temp_118 = delay_pipeline[5] * coeff6;
  assign product6 = mul_temp_118[30:0];

  assign mul_temp_119 = delay_pipeline[4] * coeff5;
  assign product5 = mul_temp_119[30:0];

  assign mul_temp_120 = delay_pipeline[3] * coeff4;
  assign product4 = mul_temp_120[30:0];

  assign mul_temp_121 = delay_pipeline[2] * coeff3;
  assign product3 = mul_temp_121[30:0];

  assign mulpwr2_temp_2 = (delay_pipeline[1]==16'b1000000000000000) ? $signed({1'b0, delay_pipeline[1]}) : -delay_pipeline[1];

  assign product2 = $signed({mulpwr2_temp_2[16:0], 3'b000});

  assign product1_cast = $signed({{4{product1[30]}}, product1});

  assign mulpwr2_temp_3 = (delay_pipeline[0]==16'b1000000000000000) ? $signed({1'b0, delay_pipeline[0]}) : -delay_pipeline[0];

  assign product1 = $signed({mulpwr2_temp_3[16:0], 2'b00});

  assign add_signext = product1_cast;
  assign add_signext_1 = $signed({{4{product2[30]}}, product2});
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = add_temp[34:0];

  assign add_signext_2 = sum1;
  assign add_signext_3 = $signed({{4{product3[30]}}, product3});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[34:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $signed({{4{product4[30]}}, product4});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[34:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $signed({{4{product5[30]}}, product5});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[34:0];

  assign add_signext_8 = sum4;
  assign add_signext_9 = $signed({{4{product6[30]}}, product6});
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum5 = add_temp_4[34:0];

  assign add_signext_10 = sum5;
  assign add_signext_11 = $signed({{4{product7[30]}}, product7});
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sum6 = add_temp_5[34:0];

  assign add_signext_12 = sum6;
  assign add_signext_13 = $signed({{4{product8[30]}}, product8});
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sum7 = add_temp_6[34:0];

  assign add_signext_14 = sum7;
  assign add_signext_15 = $signed({{4{product9[30]}}, product9});
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sum8 = add_temp_7[34:0];

  assign add_signext_16 = sum8;
  assign add_signext_17 = $signed({{4{product10[30]}}, product10});
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sum9 = add_temp_8[34:0];

  assign add_signext_18 = sum9;
  assign add_signext_19 = $signed({{4{product11[30]}}, product11});
  assign add_temp_9 = add_signext_18 + add_signext_19;
  assign sum10 = add_temp_9[34:0];

  assign add_signext_20 = sum10;
  assign add_signext_21 = $signed({{4{product12[30]}}, product12});
  assign add_temp_10 = add_signext_20 + add_signext_21;
  assign sum11 = add_temp_10[34:0];

  assign add_signext_22 = sum11;
  assign add_signext_23 = $signed({{4{product13[30]}}, product13});
  assign add_temp_11 = add_signext_22 + add_signext_23;
  assign sum12 = add_temp_11[34:0];

  assign add_signext_24 = sum12;
  assign add_signext_25 = $signed({{4{product14[30]}}, product14});
  assign add_temp_12 = add_signext_24 + add_signext_25;
  assign sum13 = add_temp_12[34:0];

  assign add_signext_26 = sum13;
  assign add_signext_27 = $signed({{4{product15[30]}}, product15});
  assign add_temp_13 = add_signext_26 + add_signext_27;
  assign sum14 = add_temp_13[34:0];

  assign add_signext_28 = sum14;
  assign add_signext_29 = $signed({{4{product16[30]}}, product16});
  assign add_temp_14 = add_signext_28 + add_signext_29;
  assign sum15 = add_temp_14[34:0];

  assign add_signext_30 = sum15;
  assign add_signext_31 = $signed({{4{product17[30]}}, product17});
  assign add_temp_15 = add_signext_30 + add_signext_31;
  assign sum16 = add_temp_15[34:0];

  assign add_signext_32 = sum16;
  assign add_signext_33 = $signed({{4{product18[30]}}, product18});
  assign add_temp_16 = add_signext_32 + add_signext_33;
  assign sum17 = add_temp_16[34:0];

  assign add_signext_34 = sum17;
  assign add_signext_35 = $signed({{4{product19[30]}}, product19});
  assign add_temp_17 = add_signext_34 + add_signext_35;
  assign sum18 = add_temp_17[34:0];

  assign add_signext_36 = sum18;
  assign add_signext_37 = $signed({{4{product20[30]}}, product20});
  assign add_temp_18 = add_signext_36 + add_signext_37;
  assign sum19 = add_temp_18[34:0];

  assign add_signext_38 = sum19;
  assign add_signext_39 = $signed({{4{product21[30]}}, product21});
  assign add_temp_19 = add_signext_38 + add_signext_39;
  assign sum20 = add_temp_19[34:0];

  assign add_signext_40 = sum20;
  assign add_signext_41 = $signed({{4{product22[30]}}, product22});
  assign add_temp_20 = add_signext_40 + add_signext_41;
  assign sum21 = add_temp_20[34:0];

  assign add_signext_42 = sum21;
  assign add_signext_43 = $signed({{4{product23[30]}}, product23});
  assign add_temp_21 = add_signext_42 + add_signext_43;
  assign sum22 = add_temp_21[34:0];

  assign add_signext_44 = sum22;
  assign add_signext_45 = $signed({{4{product24[30]}}, product24});
  assign add_temp_22 = add_signext_44 + add_signext_45;
  assign sum23 = add_temp_22[34:0];

  assign add_signext_46 = sum23;
  assign add_signext_47 = $signed({{4{product25[30]}}, product25});
  assign add_temp_23 = add_signext_46 + add_signext_47;
  assign sum24 = add_temp_23[34:0];

  assign add_signext_48 = sum24;
  assign add_signext_49 = $signed({{4{product26[30]}}, product26});
  assign add_temp_24 = add_signext_48 + add_signext_49;
  assign sum25 = add_temp_24[34:0];

  assign add_signext_50 = sum25;
  assign add_signext_51 = $signed({{4{product27[30]}}, product27});
  assign add_temp_25 = add_signext_50 + add_signext_51;
  assign sum26 = add_temp_25[34:0];

  assign add_signext_52 = sum26;
  assign add_signext_53 = $signed({{4{product28[30]}}, product28});
  assign add_temp_26 = add_signext_52 + add_signext_53;
  assign sum27 = add_temp_26[34:0];

  assign add_signext_54 = sum27;
  assign add_signext_55 = $signed({{4{product29[30]}}, product29});
  assign add_temp_27 = add_signext_54 + add_signext_55;
  assign sum28 = add_temp_27[34:0];

  assign add_signext_56 = sum28;
  assign add_signext_57 = $signed({{4{product30[30]}}, product30});
  assign add_temp_28 = add_signext_56 + add_signext_57;
  assign sum29 = add_temp_28[34:0];

  assign add_signext_58 = sum29;
  assign add_signext_59 = $signed({{4{product31[30]}}, product31});
  assign add_temp_29 = add_signext_58 + add_signext_59;
  assign sum30 = add_temp_29[34:0];

  assign add_signext_60 = sum30;
  assign add_signext_61 = $signed({{4{product32[30]}}, product32});
  assign add_temp_30 = add_signext_60 + add_signext_61;
  assign sum31 = add_temp_30[34:0];

  assign add_signext_62 = sum31;
  assign add_signext_63 = $signed({{4{product33[30]}}, product33});
  assign add_temp_31 = add_signext_62 + add_signext_63;
  assign sum32 = add_temp_31[34:0];

  assign add_signext_64 = sum32;
  assign add_signext_65 = $signed({{4{product34[30]}}, product34});
  assign add_temp_32 = add_signext_64 + add_signext_65;
  assign sum33 = add_temp_32[34:0];

  assign add_signext_66 = sum33;
  assign add_signext_67 = $signed({{4{product35[30]}}, product35});
  assign add_temp_33 = add_signext_66 + add_signext_67;
  assign sum34 = add_temp_33[34:0];

  assign add_signext_68 = sum34;
  assign add_signext_69 = $signed({{4{product36[30]}}, product36});
  assign add_temp_34 = add_signext_68 + add_signext_69;
  assign sum35 = add_temp_34[34:0];

  assign add_signext_70 = sum35;
  assign add_signext_71 = $signed({{4{product37[30]}}, product37});
  assign add_temp_35 = add_signext_70 + add_signext_71;
  assign sum36 = add_temp_35[34:0];

  assign add_signext_72 = sum36;
  assign add_signext_73 = $signed({{4{product38[30]}}, product38});
  assign add_temp_36 = add_signext_72 + add_signext_73;
  assign sum37 = add_temp_36[34:0];

  assign add_signext_74 = sum37;
  assign add_signext_75 = $signed({{4{product39[30]}}, product39});
  assign add_temp_37 = add_signext_74 + add_signext_75;
  assign sum38 = add_temp_37[34:0];

  assign add_signext_76 = sum38;
  assign add_signext_77 = $signed({{4{product40[30]}}, product40});
  assign add_temp_38 = add_signext_76 + add_signext_77;
  assign sum39 = add_temp_38[34:0];

  assign add_signext_78 = sum39;
  assign add_signext_79 = $signed({{4{product41[30]}}, product41});
  assign add_temp_39 = add_signext_78 + add_signext_79;
  assign sum40 = add_temp_39[34:0];

  assign add_signext_80 = sum40;
  assign add_signext_81 = $signed({{4{product42[30]}}, product42});
  assign add_temp_40 = add_signext_80 + add_signext_81;
  assign sum41 = add_temp_40[34:0];

  assign add_signext_82 = sum41;
  assign add_signext_83 = $signed({{4{product43[30]}}, product43});
  assign add_temp_41 = add_signext_82 + add_signext_83;
  assign sum42 = add_temp_41[34:0];

  assign add_signext_84 = sum42;
  assign add_signext_85 = $signed({{4{product44[30]}}, product44});
  assign add_temp_42 = add_signext_84 + add_signext_85;
  assign sum43 = add_temp_42[34:0];

  assign add_signext_86 = sum43;
  assign add_signext_87 = $signed({{4{product45[30]}}, product45});
  assign add_temp_43 = add_signext_86 + add_signext_87;
  assign sum44 = add_temp_43[34:0];

  assign add_signext_88 = sum44;
  assign add_signext_89 = $signed({{4{product46[30]}}, product46});
  assign add_temp_44 = add_signext_88 + add_signext_89;
  assign sum45 = add_temp_44[34:0];

  assign add_signext_90 = sum45;
  assign add_signext_91 = $signed({{4{product48[30]}}, product48});
  assign add_temp_45 = add_signext_90 + add_signext_91;
  assign sum46 = add_temp_45[34:0];

  assign add_signext_92 = sum46;
  assign add_signext_93 = $signed({{4{product49[30]}}, product49});
  assign add_temp_46 = add_signext_92 + add_signext_93;
  assign sum47 = add_temp_46[34:0];

  assign add_signext_94 = sum47;
  assign add_signext_95 = $signed({{4{product50[30]}}, product50});
  assign add_temp_47 = add_signext_94 + add_signext_95;
  assign sum48 = add_temp_47[34:0];

  assign add_signext_96 = sum48;
  assign add_signext_97 = $signed({{4{product51[30]}}, product51});
  assign add_temp_48 = add_signext_96 + add_signext_97;
  assign sum49 = add_temp_48[34:0];

  assign add_signext_98 = sum49;
  assign add_signext_99 = $signed({{4{product52[30]}}, product52});
  assign add_temp_49 = add_signext_98 + add_signext_99;
  assign sum50 = add_temp_49[34:0];

  assign add_signext_100 = sum50;
  assign add_signext_101 = $signed({{4{product53[30]}}, product53});
  assign add_temp_50 = add_signext_100 + add_signext_101;
  assign sum51 = add_temp_50[34:0];

  assign add_signext_102 = sum51;
  assign add_signext_103 = $signed({{4{product54[30]}}, product54});
  assign add_temp_51 = add_signext_102 + add_signext_103;
  assign sum52 = add_temp_51[34:0];

  assign add_signext_104 = sum52;
  assign add_signext_105 = $signed({{4{product55[30]}}, product55});
  assign add_temp_52 = add_signext_104 + add_signext_105;
  assign sum53 = add_temp_52[34:0];

  assign add_signext_106 = sum53;
  assign add_signext_107 = $signed({{4{product56[30]}}, product56});
  assign add_temp_53 = add_signext_106 + add_signext_107;
  assign sum54 = add_temp_53[34:0];

  assign add_signext_108 = sum54;
  assign add_signext_109 = $signed({{4{product57[30]}}, product57});
  assign add_temp_54 = add_signext_108 + add_signext_109;
  assign sum55 = add_temp_54[34:0];

  assign add_signext_110 = sum55;
  assign add_signext_111 = $signed({{4{product58[30]}}, product58});
  assign add_temp_55 = add_signext_110 + add_signext_111;
  assign sum56 = add_temp_55[34:0];

  assign add_signext_112 = sum56;
  assign add_signext_113 = $signed({{4{product59[30]}}, product59});
  assign add_temp_56 = add_signext_112 + add_signext_113;
  assign sum57 = add_temp_56[34:0];

  assign add_signext_114 = sum57;
  assign add_signext_115 = $signed({{4{product60[30]}}, product60});
  assign add_temp_57 = add_signext_114 + add_signext_115;
  assign sum58 = add_temp_57[34:0];

  assign add_signext_116 = sum58;
  assign add_signext_117 = $signed({{4{product61[30]}}, product61});
  assign add_temp_58 = add_signext_116 + add_signext_117;
  assign sum59 = add_temp_58[34:0];

  assign add_signext_118 = sum59;
  assign add_signext_119 = $signed({{4{product62[30]}}, product62});
  assign add_temp_59 = add_signext_118 + add_signext_119;
  assign sum60 = add_temp_59[34:0];

  assign add_signext_120 = sum60;
  assign add_signext_121 = $signed({{4{product63[30]}}, product63});
  assign add_temp_60 = add_signext_120 + add_signext_121;
  assign sum61 = add_temp_60[34:0];

  assign add_signext_122 = sum61;
  assign add_signext_123 = $signed({{4{product64[30]}}, product64});
  assign add_temp_61 = add_signext_122 + add_signext_123;
  assign sum62 = add_temp_61[34:0];

  assign add_signext_124 = sum62;
  assign add_signext_125 = $signed({{4{product65[30]}}, product65});
  assign add_temp_62 = add_signext_124 + add_signext_125;
  assign sum63 = add_temp_62[34:0];

  assign add_signext_126 = sum63;
  assign add_signext_127 = $signed({{4{product66[30]}}, product66});
  assign add_temp_63 = add_signext_126 + add_signext_127;
  assign sum64 = add_temp_63[34:0];

  assign add_signext_128 = sum64;
  assign add_signext_129 = $signed({{4{product67[30]}}, product67});
  assign add_temp_64 = add_signext_128 + add_signext_129;
  assign sum65 = add_temp_64[34:0];

  assign add_signext_130 = sum65;
  assign add_signext_131 = $signed({{4{product68[30]}}, product68});
  assign add_temp_65 = add_signext_130 + add_signext_131;
  assign sum66 = add_temp_65[34:0];

  assign add_signext_132 = sum66;
  assign add_signext_133 = $signed({{4{product69[30]}}, product69});
  assign add_temp_66 = add_signext_132 + add_signext_133;
  assign sum67 = add_temp_66[34:0];

  assign add_signext_134 = sum67;
  assign add_signext_135 = $signed({{4{product70[30]}}, product70});
  assign add_temp_67 = add_signext_134 + add_signext_135;
  assign sum68 = add_temp_67[34:0];

  assign add_signext_136 = sum68;
  assign add_signext_137 = $signed({{4{product71[30]}}, product71});
  assign add_temp_68 = add_signext_136 + add_signext_137;
  assign sum69 = add_temp_68[34:0];

  assign add_signext_138 = sum69;
  assign add_signext_139 = $signed({{4{product72[30]}}, product72});
  assign add_temp_69 = add_signext_138 + add_signext_139;
  assign sum70 = add_temp_69[34:0];

  assign add_signext_140 = sum70;
  assign add_signext_141 = $signed({{4{product73[30]}}, product73});
  assign add_temp_70 = add_signext_140 + add_signext_141;
  assign sum71 = add_temp_70[34:0];

  assign add_signext_142 = sum71;
  assign add_signext_143 = $signed({{4{product74[30]}}, product74});
  assign add_temp_71 = add_signext_142 + add_signext_143;
  assign sum72 = add_temp_71[34:0];

  assign add_signext_144 = sum72;
  assign add_signext_145 = $signed({{4{product75[30]}}, product75});
  assign add_temp_72 = add_signext_144 + add_signext_145;
  assign sum73 = add_temp_72[34:0];

  assign add_signext_146 = sum73;
  assign add_signext_147 = $signed({{4{product76[30]}}, product76});
  assign add_temp_73 = add_signext_146 + add_signext_147;
  assign sum74 = add_temp_73[34:0];

  assign add_signext_148 = sum74;
  assign add_signext_149 = $signed({{4{product77[30]}}, product77});
  assign add_temp_74 = add_signext_148 + add_signext_149;
  assign sum75 = add_temp_74[34:0];

  assign add_signext_150 = sum75;
  assign add_signext_151 = $signed({{4{product78[30]}}, product78});
  assign add_temp_75 = add_signext_150 + add_signext_151;
  assign sum76 = add_temp_75[34:0];

  assign add_signext_152 = sum76;
  assign add_signext_153 = $signed({{4{product79[30]}}, product79});
  assign add_temp_76 = add_signext_152 + add_signext_153;
  assign sum77 = add_temp_76[34:0];

  assign add_signext_154 = sum77;
  assign add_signext_155 = $signed({{4{product80[30]}}, product80});
  assign add_temp_77 = add_signext_154 + add_signext_155;
  assign sum78 = add_temp_77[34:0];

  assign add_signext_156 = sum78;
  assign add_signext_157 = $signed({{4{product81[30]}}, product81});
  assign add_temp_78 = add_signext_156 + add_signext_157;
  assign sum79 = add_temp_78[34:0];

  assign add_signext_158 = sum79;
  assign add_signext_159 = $signed({{4{product83[30]}}, product83});
  assign add_temp_79 = add_signext_158 + add_signext_159;
  assign sum80 = add_temp_79[34:0];

  assign add_signext_160 = sum80;
  assign add_signext_161 = $signed({{4{product84[30]}}, product84});
  assign add_temp_80 = add_signext_160 + add_signext_161;
  assign sum81 = add_temp_80[34:0];

  assign add_signext_162 = sum81;
  assign add_signext_163 = $signed({{4{product85[30]}}, product85});
  assign add_temp_81 = add_signext_162 + add_signext_163;
  assign sum82 = add_temp_81[34:0];

  assign add_signext_164 = sum82;
  assign add_signext_165 = $signed({{4{product86[30]}}, product86});
  assign add_temp_82 = add_signext_164 + add_signext_165;
  assign sum83 = add_temp_82[34:0];

  assign add_signext_166 = sum83;
  assign add_signext_167 = $signed({{4{product87[30]}}, product87});
  assign add_temp_83 = add_signext_166 + add_signext_167;
  assign sum84 = add_temp_83[34:0];

  assign add_signext_168 = sum84;
  assign add_signext_169 = $signed({{4{product88[30]}}, product88});
  assign add_temp_84 = add_signext_168 + add_signext_169;
  assign sum85 = add_temp_84[34:0];

  assign add_signext_170 = sum85;
  assign add_signext_171 = $signed({{4{product89[30]}}, product89});
  assign add_temp_85 = add_signext_170 + add_signext_171;
  assign sum86 = add_temp_85[34:0];

  assign add_signext_172 = sum86;
  assign add_signext_173 = $signed({{4{product90[30]}}, product90});
  assign add_temp_86 = add_signext_172 + add_signext_173;
  assign sum87 = add_temp_86[34:0];

  assign add_signext_174 = sum87;
  assign add_signext_175 = $signed({{4{product91[30]}}, product91});
  assign add_temp_87 = add_signext_174 + add_signext_175;
  assign sum88 = add_temp_87[34:0];

  assign add_signext_176 = sum88;
  assign add_signext_177 = $signed({{4{product92[30]}}, product92});
  assign add_temp_88 = add_signext_176 + add_signext_177;
  assign sum89 = add_temp_88[34:0];

  assign add_signext_178 = sum89;
  assign add_signext_179 = $signed({{4{product93[30]}}, product93});
  assign add_temp_89 = add_signext_178 + add_signext_179;
  assign sum90 = add_temp_89[34:0];

  assign add_signext_180 = sum90;
  assign add_signext_181 = $signed({{4{product94[30]}}, product94});
  assign add_temp_90 = add_signext_180 + add_signext_181;
  assign sum91 = add_temp_90[34:0];

  assign add_signext_182 = sum91;
  assign add_signext_183 = $signed({{4{product95[30]}}, product95});
  assign add_temp_91 = add_signext_182 + add_signext_183;
  assign sum92 = add_temp_91[34:0];

  assign add_signext_184 = sum92;
  assign add_signext_185 = $signed({{4{product96[30]}}, product96});
  assign add_temp_92 = add_signext_184 + add_signext_185;
  assign sum93 = add_temp_92[34:0];

  assign add_signext_186 = sum93;
  assign add_signext_187 = $signed({{4{product97[30]}}, product97});
  assign add_temp_93 = add_signext_186 + add_signext_187;
  assign sum94 = add_temp_93[34:0];

  assign add_signext_188 = sum94;
  assign add_signext_189 = $signed({{4{product98[30]}}, product98});
  assign add_temp_94 = add_signext_188 + add_signext_189;
  assign sum95 = add_temp_94[34:0];

  assign add_signext_190 = sum95;
  assign add_signext_191 = $signed({{4{product99[30]}}, product99});
  assign add_temp_95 = add_signext_190 + add_signext_191;
  assign sum96 = add_temp_95[34:0];

  assign add_signext_192 = sum96;
  assign add_signext_193 = $signed({{4{product100[30]}}, product100});
  assign add_temp_96 = add_signext_192 + add_signext_193;
  assign sum97 = add_temp_96[34:0];

  assign add_signext_194 = sum97;
  assign add_signext_195 = $signed({{4{product101[30]}}, product101});
  assign add_temp_97 = add_signext_194 + add_signext_195;
  assign sum98 = add_temp_97[34:0];

  assign add_signext_196 = sum98;
  assign add_signext_197 = $signed({{4{product102[30]}}, product102});
  assign add_temp_98 = add_signext_196 + add_signext_197;
  assign sum99 = add_temp_98[34:0];

  assign add_signext_198 = sum99;
  assign add_signext_199 = $signed({{4{product103[30]}}, product103});
  assign add_temp_99 = add_signext_198 + add_signext_199;
  assign sum100 = add_temp_99[34:0];

  assign add_signext_200 = sum100;
  assign add_signext_201 = $signed({{4{product104[30]}}, product104});
  assign add_temp_100 = add_signext_200 + add_signext_201;
  assign sum101 = add_temp_100[34:0];

  assign add_signext_202 = sum101;
  assign add_signext_203 = $signed({{4{product105[30]}}, product105});
  assign add_temp_101 = add_signext_202 + add_signext_203;
  assign sum102 = add_temp_101[34:0];

  assign add_signext_204 = sum102;
  assign add_signext_205 = $signed({{4{product106[30]}}, product106});
  assign add_temp_102 = add_signext_204 + add_signext_205;
  assign sum103 = add_temp_102[34:0];

  assign add_signext_206 = sum103;
  assign add_signext_207 = $signed({{4{product107[30]}}, product107});
  assign add_temp_103 = add_signext_206 + add_signext_207;
  assign sum104 = add_temp_103[34:0];

  assign add_signext_208 = sum104;
  assign add_signext_209 = $signed({{4{product108[30]}}, product108});
  assign add_temp_104 = add_signext_208 + add_signext_209;
  assign sum105 = add_temp_104[34:0];

  assign add_signext_210 = sum105;
  assign add_signext_211 = $signed({{4{product109[30]}}, product109});
  assign add_temp_105 = add_signext_210 + add_signext_211;
  assign sum106 = add_temp_105[34:0];

  assign add_signext_212 = sum106;
  assign add_signext_213 = $signed({{4{product110[30]}}, product110});
  assign add_temp_106 = add_signext_212 + add_signext_213;
  assign sum107 = add_temp_106[34:0];

  assign add_signext_214 = sum107;
  assign add_signext_215 = $signed({{4{product111[30]}}, product111});
  assign add_temp_107 = add_signext_214 + add_signext_215;
  assign sum108 = add_temp_107[34:0];

  assign add_signext_216 = sum108;
  assign add_signext_217 = $signed({{4{product112[30]}}, product112});
  assign add_temp_108 = add_signext_216 + add_signext_217;
  assign sum109 = add_temp_108[34:0];

  assign add_signext_218 = sum109;
  assign add_signext_219 = $signed({{4{product113[30]}}, product113});
  assign add_temp_109 = add_signext_218 + add_signext_219;
  assign sum110 = add_temp_109[34:0];

  assign add_signext_220 = sum110;
  assign add_signext_221 = $signed({{4{product114[30]}}, product114});
  assign add_temp_110 = add_signext_220 + add_signext_221;
  assign sum111 = add_temp_110[34:0];

  assign add_signext_222 = sum111;
  assign add_signext_223 = $signed({{4{product115[30]}}, product115});
  assign add_temp_111 = add_signext_222 + add_signext_223;
  assign sum112 = add_temp_111[34:0];

  assign add_signext_224 = sum112;
  assign add_signext_225 = $signed({{4{product116[30]}}, product116});
  assign add_temp_112 = add_signext_224 + add_signext_225;
  assign sum113 = add_temp_112[34:0];

  assign add_signext_226 = sum113;
  assign add_signext_227 = $signed({{4{product117[30]}}, product117});
  assign add_temp_113 = add_signext_226 + add_signext_227;
  assign sum114 = add_temp_113[34:0];

  assign add_signext_228 = sum114;
  assign add_signext_229 = $signed({{4{product118[30]}}, product118});
  assign add_temp_114 = add_signext_228 + add_signext_229;
  assign sum115 = add_temp_114[34:0];

  assign add_signext_230 = sum115;
  assign add_signext_231 = $signed({{4{product119[30]}}, product119});
  assign add_temp_115 = add_signext_230 + add_signext_231;
  assign sum116 = add_temp_115[34:0];

  assign add_signext_232 = sum116;
  assign add_signext_233 = $signed({{4{product120[30]}}, product120});
  assign add_temp_116 = add_signext_232 + add_signext_233;
  assign sum117 = add_temp_116[34:0];

  assign add_signext_234 = sum117;
  assign add_signext_235 = $signed({{4{product121[30]}}, product121});
  assign add_temp_117 = add_signext_234 + add_signext_235;
  assign sum118 = add_temp_117[34:0];

  assign add_signext_236 = sum118;
  assign add_signext_237 = $signed({{4{product122[30]}}, product122});
  assign add_temp_118 = add_signext_236 + add_signext_237;
  assign sum119 = add_temp_118[34:0];

  assign add_signext_238 = sum119;
  assign add_signext_239 = $signed({{4{product123[30]}}, product123});
  assign add_temp_119 = add_signext_238 + add_signext_239;
  assign sum120 = add_temp_119[34:0];

  assign add_signext_240 = sum120;
  assign add_signext_241 = $signed({{4{product124[30]}}, product124});
  assign add_temp_120 = add_signext_240 + add_signext_241;
  assign sum121 = add_temp_120[34:0];

  assign add_signext_242 = sum121;
  assign add_signext_243 = $signed({{4{product125[30]}}, product125});
  assign add_temp_121 = add_signext_242 + add_signext_243;
  assign sum122 = add_temp_121[34:0];

  assign add_signext_244 = sum122;
  assign add_signext_245 = $signed({{4{product126[30]}}, product126});
  assign add_temp_122 = add_signext_244 + add_signext_245;
  assign sum123 = add_temp_122[34:0];

  assign add_signext_246 = sum123;
  assign add_signext_247 = $signed({{4{product127[30]}}, product127});
  assign add_temp_123 = add_signext_246 + add_signext_247;
  assign sum124 = add_temp_123[34:0];

  assign add_signext_248 = sum124;
  assign add_signext_249 = $signed({{4{product128[30]}}, product128});
  assign add_temp_124 = add_signext_248 + add_signext_249;
  assign sum125 = add_temp_124[34:0];

  always @ (posedge clk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= sum125;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // filter1

