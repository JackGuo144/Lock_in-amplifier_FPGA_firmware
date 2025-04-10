

// -------------------------------------------------------------
// HDL Implementation    : Fully parallel
// Folding Factor        : 1
// -------------------------------------------------------------




`timescale 1 ns / 1 ns

module filter_phase
               (
                clk,
                clk_enable,
                reset,
                filter_in,      //15:0
                filter_out      //33:0
                );

  input   clk; 
  input   clk_enable; 
  input   reset; 
  input   signed [15:0] filter_in; //sfix16_En15
  output  signed [33:0] filter_out; //sfix34_En32

////////////////////////////////////////////////////////////////
//Module Architecture: filter_phase
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [15:0] coeff1 = 16'b0000000000100110; //sfix16_En17
  parameter signed [15:0] coeff2 = 16'b0000000001010001; //sfix16_En17
  parameter signed [15:0] coeff3 = 16'b0000000010010100; //sfix16_En17
  parameter signed [15:0] coeff4 = 16'b0000000011100100; //sfix16_En17
  parameter signed [15:0] coeff5 = 16'b0000000100101101; //sfix16_En17
  parameter signed [15:0] coeff6 = 16'b0000000101010010; //sfix16_En17
  parameter signed [15:0] coeff7 = 16'b0000000100101011; //sfix16_En17
  parameter signed [15:0] coeff8 = 16'b0000000010010010; //sfix16_En17
  parameter signed [15:0] coeff9 = 16'b1111111101101000; //sfix16_En17
  parameter signed [15:0] coeff10 = 16'b1111110110100000; //sfix16_En17
  parameter signed [15:0] coeff11 = 16'b1111101101001111; //sfix16_En17
  parameter signed [15:0] coeff12 = 16'b1111100010110000; //sfix16_En17
  parameter signed [15:0] coeff13 = 16'b1111011000100110; //sfix16_En17
  parameter signed [15:0] coeff14 = 16'b1111010000111000; //sfix16_En17
  parameter signed [15:0] coeff15 = 16'b1111001101111110; //sfix16_En17
  parameter signed [15:0] coeff16 = 16'b1111010010001101; //sfix16_En17
  parameter signed [15:0] coeff17 = 16'b1111011111011011; //sfix16_En17
  parameter signed [15:0] coeff18 = 16'b1111110110100100; //sfix16_En17
  parameter signed [15:0] coeff19 = 16'b0000010111010110; //sfix16_En17
  parameter signed [15:0] coeff20 = 16'b0001000000000110; //sfix16_En17
  parameter signed [15:0] coeff21 = 16'b0001101101110100; //sfix16_En17
  parameter signed [15:0] coeff22 = 16'b0010011100011100; //sfix16_En17
  parameter signed [15:0] coeff23 = 16'b0011000111010110; //sfix16_En17
  parameter signed [15:0] coeff24 = 16'b0011101001111111; //sfix16_En17
  parameter signed [15:0] coeff25 = 16'b0100000000100000; //sfix16_En17
  parameter signed [15:0] coeff26 = 16'b0100001000010011; //sfix16_En17
  parameter signed [15:0] coeff27 = 16'b0100000000100000; //sfix16_En17
  parameter signed [15:0] coeff28 = 16'b0011101001111111; //sfix16_En17
  parameter signed [15:0] coeff29 = 16'b0011000111010110; //sfix16_En17
  parameter signed [15:0] coeff30 = 16'b0010011100011100; //sfix16_En17
  parameter signed [15:0] coeff31 = 16'b0001101101110100; //sfix16_En17
  parameter signed [15:0] coeff32 = 16'b0001000000000110; //sfix16_En17
  parameter signed [15:0] coeff33 = 16'b0000010111010110; //sfix16_En17
  parameter signed [15:0] coeff34 = 16'b1111110110100100; //sfix16_En17
  parameter signed [15:0] coeff35 = 16'b1111011111011011; //sfix16_En17
  parameter signed [15:0] coeff36 = 16'b1111010010001101; //sfix16_En17
  parameter signed [15:0] coeff37 = 16'b1111001101111110; //sfix16_En17
  parameter signed [15:0] coeff38 = 16'b1111010000111000; //sfix16_En17
  parameter signed [15:0] coeff39 = 16'b1111011000100110; //sfix16_En17
  parameter signed [15:0] coeff40 = 16'b1111100010110000; //sfix16_En17
  parameter signed [15:0] coeff41 = 16'b1111101101001111; //sfix16_En17
  parameter signed [15:0] coeff42 = 16'b1111110110100000; //sfix16_En17
  parameter signed [15:0] coeff43 = 16'b1111111101101000; //sfix16_En17
  parameter signed [15:0] coeff44 = 16'b0000000010010010; //sfix16_En17
  parameter signed [15:0] coeff45 = 16'b0000000100101011; //sfix16_En17
  parameter signed [15:0] coeff46 = 16'b0000000101010010; //sfix16_En17
  parameter signed [15:0] coeff47 = 16'b0000000100101101; //sfix16_En17
  parameter signed [15:0] coeff48 = 16'b0000000011100100; //sfix16_En17
  parameter signed [15:0] coeff49 = 16'b0000000010010100; //sfix16_En17
  parameter signed [15:0] coeff50 = 16'b0000000001010001; //sfix16_En17
  parameter signed [15:0] coeff51 = 16'b0000000000100110; //sfix16_En17

  // Signals
  reg  signed [15:0] delay_pipeline [0:50] ; // sfix16_En15
  wire signed [30:0] product51; // sfix31_En32
  wire signed [31:0] mul_temp; // sfix32_En32
  wire signed [30:0] product50; // sfix31_En32
  wire signed [31:0] mul_temp_1; // sfix32_En32
  wire signed [30:0] product49; // sfix31_En32
  wire signed [31:0] mul_temp_2; // sfix32_En32
  wire signed [30:0] product48; // sfix31_En32
  wire signed [31:0] mul_temp_3; // sfix32_En32
  wire signed [30:0] product47; // sfix31_En32
  wire signed [31:0] mul_temp_4; // sfix32_En32
  wire signed [30:0] product46; // sfix31_En32
  wire signed [31:0] mul_temp_5; // sfix32_En32
  wire signed [30:0] product45; // sfix31_En32
  wire signed [31:0] mul_temp_6; // sfix32_En32
  wire signed [30:0] product44; // sfix31_En32
  wire signed [31:0] mul_temp_7; // sfix32_En32
  wire signed [30:0] product43; // sfix31_En32
  wire signed [31:0] mul_temp_8; // sfix32_En32
  wire signed [30:0] product42; // sfix31_En32
  wire signed [31:0] mul_temp_9; // sfix32_En32
  wire signed [30:0] product41; // sfix31_En32
  wire signed [31:0] mul_temp_10; // sfix32_En32
  wire signed [30:0] product40; // sfix31_En32
  wire signed [31:0] mul_temp_11; // sfix32_En32
  wire signed [30:0] product39; // sfix31_En32
  wire signed [31:0] mul_temp_12; // sfix32_En32
  wire signed [30:0] product38; // sfix31_En32
  wire signed [31:0] mul_temp_13; // sfix32_En32
  wire signed [30:0] product37; // sfix31_En32
  wire signed [31:0] mul_temp_14; // sfix32_En32
  wire signed [30:0] product36; // sfix31_En32
  wire signed [31:0] mul_temp_15; // sfix32_En32
  wire signed [30:0] product35; // sfix31_En32
  wire signed [31:0] mul_temp_16; // sfix32_En32
  wire signed [30:0] product34; // sfix31_En32
  wire signed [31:0] mul_temp_17; // sfix32_En32
  wire signed [30:0] product33; // sfix31_En32
  wire signed [31:0] mul_temp_18; // sfix32_En32
  wire signed [30:0] product32; // sfix31_En32
  wire signed [31:0] mul_temp_19; // sfix32_En32
  wire signed [30:0] product31; // sfix31_En32
  wire signed [31:0] mul_temp_20; // sfix32_En32
  wire signed [30:0] product30; // sfix31_En32
  wire signed [31:0] mul_temp_21; // sfix32_En32
  wire signed [30:0] product29; // sfix31_En32
  wire signed [31:0] mul_temp_22; // sfix32_En32
  wire signed [30:0] product28; // sfix31_En32
  wire signed [31:0] mul_temp_23; // sfix32_En32
  wire signed [30:0] product27; // sfix31_En32
  wire signed [31:0] mul_temp_24; // sfix32_En32
  wire signed [30:0] product26; // sfix31_En32
  wire signed [31:0] mul_temp_25; // sfix32_En32
  wire signed [30:0] product25; // sfix31_En32
  wire signed [31:0] mul_temp_26; // sfix32_En32
  wire signed [30:0] product24; // sfix31_En32
  wire signed [31:0] mul_temp_27; // sfix32_En32
  wire signed [30:0] product23; // sfix31_En32
  wire signed [31:0] mul_temp_28; // sfix32_En32
  wire signed [30:0] product22; // sfix31_En32
  wire signed [31:0] mul_temp_29; // sfix32_En32
  wire signed [30:0] product21; // sfix31_En32
  wire signed [31:0] mul_temp_30; // sfix32_En32
  wire signed [30:0] product20; // sfix31_En32
  wire signed [31:0] mul_temp_31; // sfix32_En32
  wire signed [30:0] product19; // sfix31_En32
  wire signed [31:0] mul_temp_32; // sfix32_En32
  wire signed [30:0] product18; // sfix31_En32
  wire signed [31:0] mul_temp_33; // sfix32_En32
  wire signed [30:0] product17; // sfix31_En32
  wire signed [31:0] mul_temp_34; // sfix32_En32
  wire signed [30:0] product16; // sfix31_En32
  wire signed [31:0] mul_temp_35; // sfix32_En32
  wire signed [30:0] product15; // sfix31_En32
  wire signed [31:0] mul_temp_36; // sfix32_En32
  wire signed [30:0] product14; // sfix31_En32
  wire signed [31:0] mul_temp_37; // sfix32_En32
  wire signed [30:0] product13; // sfix31_En32
  wire signed [31:0] mul_temp_38; // sfix32_En32
  wire signed [30:0] product12; // sfix31_En32
  wire signed [31:0] mul_temp_39; // sfix32_En32
  wire signed [30:0] product11; // sfix31_En32
  wire signed [31:0] mul_temp_40; // sfix32_En32
  wire signed [30:0] product10; // sfix31_En32
  wire signed [31:0] mul_temp_41; // sfix32_En32
  wire signed [30:0] product9; // sfix31_En32
  wire signed [31:0] mul_temp_42; // sfix32_En32
  wire signed [30:0] product8; // sfix31_En32
  wire signed [31:0] mul_temp_43; // sfix32_En32
  wire signed [30:0] product7; // sfix31_En32
  wire signed [31:0] mul_temp_44; // sfix32_En32
  wire signed [30:0] product6; // sfix31_En32
  wire signed [31:0] mul_temp_45; // sfix32_En32
  wire signed [30:0] product5; // sfix31_En32
  wire signed [31:0] mul_temp_46; // sfix32_En32
  wire signed [30:0] product4; // sfix31_En32
  wire signed [31:0] mul_temp_47; // sfix32_En32
  wire signed [30:0] product3; // sfix31_En32
  wire signed [31:0] mul_temp_48; // sfix32_En32
  wire signed [30:0] product2; // sfix31_En32
  wire signed [31:0] mul_temp_49; // sfix32_En32
  wire signed [33:0] product1_cast; // sfix34_En32
  wire signed [30:0] product1; // sfix31_En32
  wire signed [31:0] mul_temp_50; // sfix32_En32
  wire signed [33:0] sum1; // sfix34_En32
  wire signed [33:0] add_signext; // sfix34_En32
  wire signed [33:0] add_signext_1; // sfix34_En32
  wire signed [34:0] add_temp; // sfix35_En32
  wire signed [33:0] sum2; // sfix34_En32
  wire signed [33:0] add_signext_2; // sfix34_En32
  wire signed [33:0] add_signext_3; // sfix34_En32
  wire signed [34:0] add_temp_1; // sfix35_En32
  wire signed [33:0] sum3; // sfix34_En32
  wire signed [33:0] add_signext_4; // sfix34_En32
  wire signed [33:0] add_signext_5; // sfix34_En32
  wire signed [34:0] add_temp_2; // sfix35_En32
  wire signed [33:0] sum4; // sfix34_En32
  wire signed [33:0] add_signext_6; // sfix34_En32
  wire signed [33:0] add_signext_7; // sfix34_En32
  wire signed [34:0] add_temp_3; // sfix35_En32
  wire signed [33:0] sum5; // sfix34_En32
  wire signed [33:0] add_signext_8; // sfix34_En32
  wire signed [33:0] add_signext_9; // sfix34_En32
  wire signed [34:0] add_temp_4; // sfix35_En32
  wire signed [33:0] sum6; // sfix34_En32
  wire signed [33:0] add_signext_10; // sfix34_En32
  wire signed [33:0] add_signext_11; // sfix34_En32
  wire signed [34:0] add_temp_5; // sfix35_En32
  wire signed [33:0] sum7; // sfix34_En32
  wire signed [33:0] add_signext_12; // sfix34_En32
  wire signed [33:0] add_signext_13; // sfix34_En32
  wire signed [34:0] add_temp_6; // sfix35_En32
  wire signed [33:0] sum8; // sfix34_En32
  wire signed [33:0] add_signext_14; // sfix34_En32
  wire signed [33:0] add_signext_15; // sfix34_En32
  wire signed [34:0] add_temp_7; // sfix35_En32
  wire signed [33:0] sum9; // sfix34_En32
  wire signed [33:0] add_signext_16; // sfix34_En32
  wire signed [33:0] add_signext_17; // sfix34_En32
  wire signed [34:0] add_temp_8; // sfix35_En32
  wire signed [33:0] sum10; // sfix34_En32
  wire signed [33:0] add_signext_18; // sfix34_En32
  wire signed [33:0] add_signext_19; // sfix34_En32
  wire signed [34:0] add_temp_9; // sfix35_En32
  wire signed [33:0] sum11; // sfix34_En32
  wire signed [33:0] add_signext_20; // sfix34_En32
  wire signed [33:0] add_signext_21; // sfix34_En32
  wire signed [34:0] add_temp_10; // sfix35_En32
  wire signed [33:0] sum12; // sfix34_En32
  wire signed [33:0] add_signext_22; // sfix34_En32
  wire signed [33:0] add_signext_23; // sfix34_En32
  wire signed [34:0] add_temp_11; // sfix35_En32
  wire signed [33:0] sum13; // sfix34_En32
  wire signed [33:0] add_signext_24; // sfix34_En32
  wire signed [33:0] add_signext_25; // sfix34_En32
  wire signed [34:0] add_temp_12; // sfix35_En32
  wire signed [33:0] sum14; // sfix34_En32
  wire signed [33:0] add_signext_26; // sfix34_En32
  wire signed [33:0] add_signext_27; // sfix34_En32
  wire signed [34:0] add_temp_13; // sfix35_En32
  wire signed [33:0] sum15; // sfix34_En32
  wire signed [33:0] add_signext_28; // sfix34_En32
  wire signed [33:0] add_signext_29; // sfix34_En32
  wire signed [34:0] add_temp_14; // sfix35_En32
  wire signed [33:0] sum16; // sfix34_En32
  wire signed [33:0] add_signext_30; // sfix34_En32
  wire signed [33:0] add_signext_31; // sfix34_En32
  wire signed [34:0] add_temp_15; // sfix35_En32
  wire signed [33:0] sum17; // sfix34_En32
  wire signed [33:0] add_signext_32; // sfix34_En32
  wire signed [33:0] add_signext_33; // sfix34_En32
  wire signed [34:0] add_temp_16; // sfix35_En32
  wire signed [33:0] sum18; // sfix34_En32
  wire signed [33:0] add_signext_34; // sfix34_En32
  wire signed [33:0] add_signext_35; // sfix34_En32
  wire signed [34:0] add_temp_17; // sfix35_En32
  wire signed [33:0] sum19; // sfix34_En32
  wire signed [33:0] add_signext_36; // sfix34_En32
  wire signed [33:0] add_signext_37; // sfix34_En32
  wire signed [34:0] add_temp_18; // sfix35_En32
  wire signed [33:0] sum20; // sfix34_En32
  wire signed [33:0] add_signext_38; // sfix34_En32
  wire signed [33:0] add_signext_39; // sfix34_En32
  wire signed [34:0] add_temp_19; // sfix35_En32
  wire signed [33:0] sum21; // sfix34_En32
  wire signed [33:0] add_signext_40; // sfix34_En32
  wire signed [33:0] add_signext_41; // sfix34_En32
  wire signed [34:0] add_temp_20; // sfix35_En32
  wire signed [33:0] sum22; // sfix34_En32
  wire signed [33:0] add_signext_42; // sfix34_En32
  wire signed [33:0] add_signext_43; // sfix34_En32
  wire signed [34:0] add_temp_21; // sfix35_En32
  wire signed [33:0] sum23; // sfix34_En32
  wire signed [33:0] add_signext_44; // sfix34_En32
  wire signed [33:0] add_signext_45; // sfix34_En32
  wire signed [34:0] add_temp_22; // sfix35_En32
  wire signed [33:0] sum24; // sfix34_En32
  wire signed [33:0] add_signext_46; // sfix34_En32
  wire signed [33:0] add_signext_47; // sfix34_En32
  wire signed [34:0] add_temp_23; // sfix35_En32
  wire signed [33:0] sum25; // sfix34_En32
  wire signed [33:0] add_signext_48; // sfix34_En32
  wire signed [33:0] add_signext_49; // sfix34_En32
  wire signed [34:0] add_temp_24; // sfix35_En32
  wire signed [33:0] sum26; // sfix34_En32
  wire signed [33:0] add_signext_50; // sfix34_En32
  wire signed [33:0] add_signext_51; // sfix34_En32
  wire signed [34:0] add_temp_25; // sfix35_En32
  wire signed [33:0] sum27; // sfix34_En32
  wire signed [33:0] add_signext_52; // sfix34_En32
  wire signed [33:0] add_signext_53; // sfix34_En32
  wire signed [34:0] add_temp_26; // sfix35_En32
  wire signed [33:0] sum28; // sfix34_En32
  wire signed [33:0] add_signext_54; // sfix34_En32
  wire signed [33:0] add_signext_55; // sfix34_En32
  wire signed [34:0] add_temp_27; // sfix35_En32
  wire signed [33:0] sum29; // sfix34_En32
  wire signed [33:0] add_signext_56; // sfix34_En32
  wire signed [33:0] add_signext_57; // sfix34_En32
  wire signed [34:0] add_temp_28; // sfix35_En32
  wire signed [33:0] sum30; // sfix34_En32
  wire signed [33:0] add_signext_58; // sfix34_En32
  wire signed [33:0] add_signext_59; // sfix34_En32
  wire signed [34:0] add_temp_29; // sfix35_En32
  wire signed [33:0] sum31; // sfix34_En32
  wire signed [33:0] add_signext_60; // sfix34_En32
  wire signed [33:0] add_signext_61; // sfix34_En32
  wire signed [34:0] add_temp_30; // sfix35_En32
  wire signed [33:0] sum32; // sfix34_En32
  wire signed [33:0] add_signext_62; // sfix34_En32
  wire signed [33:0] add_signext_63; // sfix34_En32
  wire signed [34:0] add_temp_31; // sfix35_En32
  wire signed [33:0] sum33; // sfix34_En32
  wire signed [33:0] add_signext_64; // sfix34_En32
  wire signed [33:0] add_signext_65; // sfix34_En32
  wire signed [34:0] add_temp_32; // sfix35_En32
  wire signed [33:0] sum34; // sfix34_En32
  wire signed [33:0] add_signext_66; // sfix34_En32
  wire signed [33:0] add_signext_67; // sfix34_En32
  wire signed [34:0] add_temp_33; // sfix35_En32
  wire signed [33:0] sum35; // sfix34_En32
  wire signed [33:0] add_signext_68; // sfix34_En32
  wire signed [33:0] add_signext_69; // sfix34_En32
  wire signed [34:0] add_temp_34; // sfix35_En32
  wire signed [33:0] sum36; // sfix34_En32
  wire signed [33:0] add_signext_70; // sfix34_En32
  wire signed [33:0] add_signext_71; // sfix34_En32
  wire signed [34:0] add_temp_35; // sfix35_En32
  wire signed [33:0] sum37; // sfix34_En32
  wire signed [33:0] add_signext_72; // sfix34_En32
  wire signed [33:0] add_signext_73; // sfix34_En32
  wire signed [34:0] add_temp_36; // sfix35_En32
  wire signed [33:0] sum38; // sfix34_En32
  wire signed [33:0] add_signext_74; // sfix34_En32
  wire signed [33:0] add_signext_75; // sfix34_En32
  wire signed [34:0] add_temp_37; // sfix35_En32
  wire signed [33:0] sum39; // sfix34_En32
  wire signed [33:0] add_signext_76; // sfix34_En32
  wire signed [33:0] add_signext_77; // sfix34_En32
  wire signed [34:0] add_temp_38; // sfix35_En32
  wire signed [33:0] sum40; // sfix34_En32
  wire signed [33:0] add_signext_78; // sfix34_En32
  wire signed [33:0] add_signext_79; // sfix34_En32
  wire signed [34:0] add_temp_39; // sfix35_En32
  wire signed [33:0] sum41; // sfix34_En32
  wire signed [33:0] add_signext_80; // sfix34_En32
  wire signed [33:0] add_signext_81; // sfix34_En32
  wire signed [34:0] add_temp_40; // sfix35_En32
  wire signed [33:0] sum42; // sfix34_En32
  wire signed [33:0] add_signext_82; // sfix34_En32
  wire signed [33:0] add_signext_83; // sfix34_En32
  wire signed [34:0] add_temp_41; // sfix35_En32
  wire signed [33:0] sum43; // sfix34_En32
  wire signed [33:0] add_signext_84; // sfix34_En32
  wire signed [33:0] add_signext_85; // sfix34_En32
  wire signed [34:0] add_temp_42; // sfix35_En32
  wire signed [33:0] sum44; // sfix34_En32
  wire signed [33:0] add_signext_86; // sfix34_En32
  wire signed [33:0] add_signext_87; // sfix34_En32
  wire signed [34:0] add_temp_43; // sfix35_En32
  wire signed [33:0] sum45; // sfix34_En32
  wire signed [33:0] add_signext_88; // sfix34_En32
  wire signed [33:0] add_signext_89; // sfix34_En32
  wire signed [34:0] add_temp_44; // sfix35_En32
  wire signed [33:0] sum46; // sfix34_En32
  wire signed [33:0] add_signext_90; // sfix34_En32
  wire signed [33:0] add_signext_91; // sfix34_En32
  wire signed [34:0] add_temp_45; // sfix35_En32
  wire signed [33:0] sum47; // sfix34_En32
  wire signed [33:0] add_signext_92; // sfix34_En32
  wire signed [33:0] add_signext_93; // sfix34_En32
  wire signed [34:0] add_temp_46; // sfix35_En32
  wire signed [33:0] sum48; // sfix34_En32
  wire signed [33:0] add_signext_94; // sfix34_En32
  wire signed [33:0] add_signext_95; // sfix34_En32
  wire signed [34:0] add_temp_47; // sfix35_En32
  wire signed [33:0] sum49; // sfix34_En32
  wire signed [33:0] add_signext_96; // sfix34_En32
  wire signed [33:0] add_signext_97; // sfix34_En32
  wire signed [34:0] add_temp_48; // sfix35_En32
  wire signed [33:0] sum50; // sfix34_En32
  wire signed [33:0] add_signext_98; // sfix34_En32
  wire signed [33:0] add_signext_99; // sfix34_En32
  wire signed [34:0] add_temp_49; // sfix35_En32
  reg  signed [33:0] output_register; // sfix34_En32

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
        end
      end
    end // Delay_Pipeline_process


  assign mul_temp = delay_pipeline[50] * coeff51;
  assign product51 = mul_temp[30:0];

  assign mul_temp_1 = delay_pipeline[49] * coeff50;
  assign product50 = mul_temp_1[30:0];

  assign mul_temp_2 = delay_pipeline[48] * coeff49;
  assign product49 = mul_temp_2[30:0];

  assign mul_temp_3 = delay_pipeline[47] * coeff48;
  assign product48 = mul_temp_3[30:0];

  assign mul_temp_4 = delay_pipeline[46] * coeff47;
  assign product47 = mul_temp_4[30:0];

  assign mul_temp_5 = delay_pipeline[45] * coeff46;
  assign product46 = mul_temp_5[30:0];

  assign mul_temp_6 = delay_pipeline[44] * coeff45;
  assign product45 = mul_temp_6[30:0];

  assign mul_temp_7 = delay_pipeline[43] * coeff44;
  assign product44 = mul_temp_7[30:0];

  assign mul_temp_8 = delay_pipeline[42] * coeff43;
  assign product43 = mul_temp_8[30:0];

  assign mul_temp_9 = delay_pipeline[41] * coeff42;
  assign product42 = mul_temp_9[30:0];

  assign mul_temp_10 = delay_pipeline[40] * coeff41;
  assign product41 = mul_temp_10[30:0];

  assign mul_temp_11 = delay_pipeline[39] * coeff40;
  assign product40 = mul_temp_11[30:0];

  assign mul_temp_12 = delay_pipeline[38] * coeff39;
  assign product39 = mul_temp_12[30:0];

  assign mul_temp_13 = delay_pipeline[37] * coeff38;
  assign product38 = mul_temp_13[30:0];

  assign mul_temp_14 = delay_pipeline[36] * coeff37;
  assign product37 = mul_temp_14[30:0];

  assign mul_temp_15 = delay_pipeline[35] * coeff36;
  assign product36 = mul_temp_15[30:0];

  assign mul_temp_16 = delay_pipeline[34] * coeff35;
  assign product35 = mul_temp_16[30:0];

  assign mul_temp_17 = delay_pipeline[33] * coeff34;
  assign product34 = mul_temp_17[30:0];

  assign mul_temp_18 = delay_pipeline[32] * coeff33;
  assign product33 = mul_temp_18[30:0];

  assign mul_temp_19 = delay_pipeline[31] * coeff32;
  assign product32 = mul_temp_19[30:0];

  assign mul_temp_20 = delay_pipeline[30] * coeff31;
  assign product31 = mul_temp_20[30:0];

  assign mul_temp_21 = delay_pipeline[29] * coeff30;
  assign product30 = mul_temp_21[30:0];

  assign mul_temp_22 = delay_pipeline[28] * coeff29;
  assign product29 = mul_temp_22[30:0];

  assign mul_temp_23 = delay_pipeline[27] * coeff28;
  assign product28 = mul_temp_23[30:0];

  assign mul_temp_24 = delay_pipeline[26] * coeff27;
  assign product27 = mul_temp_24[30:0];

  assign mul_temp_25 = delay_pipeline[25] * coeff26;
  assign product26 = mul_temp_25[30:0];

  assign mul_temp_26 = delay_pipeline[24] * coeff25;
  assign product25 = mul_temp_26[30:0];

  assign mul_temp_27 = delay_pipeline[23] * coeff24;
  assign product24 = mul_temp_27[30:0];

  assign mul_temp_28 = delay_pipeline[22] * coeff23;
  assign product23 = mul_temp_28[30:0];

  assign mul_temp_29 = delay_pipeline[21] * coeff22;
  assign product22 = mul_temp_29[30:0];

  assign mul_temp_30 = delay_pipeline[20] * coeff21;
  assign product21 = mul_temp_30[30:0];

  assign mul_temp_31 = delay_pipeline[19] * coeff20;
  assign product20 = mul_temp_31[30:0];

  assign mul_temp_32 = delay_pipeline[18] * coeff19;
  assign product19 = mul_temp_32[30:0];

  assign mul_temp_33 = delay_pipeline[17] * coeff18;
  assign product18 = mul_temp_33[30:0];

  assign mul_temp_34 = delay_pipeline[16] * coeff17;
  assign product17 = mul_temp_34[30:0];

  assign mul_temp_35 = delay_pipeline[15] * coeff16;
  assign product16 = mul_temp_35[30:0];

  assign mul_temp_36 = delay_pipeline[14] * coeff15;
  assign product15 = mul_temp_36[30:0];

  assign mul_temp_37 = delay_pipeline[13] * coeff14;
  assign product14 = mul_temp_37[30:0];

  assign mul_temp_38 = delay_pipeline[12] * coeff13;
  assign product13 = mul_temp_38[30:0];

  assign mul_temp_39 = delay_pipeline[11] * coeff12;
  assign product12 = mul_temp_39[30:0];

  assign mul_temp_40 = delay_pipeline[10] * coeff11;
  assign product11 = mul_temp_40[30:0];

  assign mul_temp_41 = delay_pipeline[9] * coeff10;
  assign product10 = mul_temp_41[30:0];

  assign mul_temp_42 = delay_pipeline[8] * coeff9;
  assign product9 = mul_temp_42[30:0];

  assign mul_temp_43 = delay_pipeline[7] * coeff8;
  assign product8 = mul_temp_43[30:0];

  assign mul_temp_44 = delay_pipeline[6] * coeff7;
  assign product7 = mul_temp_44[30:0];

  assign mul_temp_45 = delay_pipeline[5] * coeff6;
  assign product6 = mul_temp_45[30:0];

  assign mul_temp_46 = delay_pipeline[4] * coeff5;
  assign product5 = mul_temp_46[30:0];

  assign mul_temp_47 = delay_pipeline[3] * coeff4;
  assign product4 = mul_temp_47[30:0];

  assign mul_temp_48 = delay_pipeline[2] * coeff3;
  assign product3 = mul_temp_48[30:0];

  assign mul_temp_49 = delay_pipeline[1] * coeff2;
  assign product2 = mul_temp_49[30:0];

  assign product1_cast = $signed({{3{product1[30]}}, product1});

  assign mul_temp_50 = delay_pipeline[0] * coeff1;
  assign product1 = mul_temp_50[30:0];

  assign add_signext = product1_cast;
  assign add_signext_1 = $signed({{3{product2[30]}}, product2});
  assign add_temp = add_signext + add_signext_1;
  assign sum1 = add_temp[33:0];

  assign add_signext_2 = sum1;
  assign add_signext_3 = $signed({{3{product3[30]}}, product3});
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sum2 = add_temp_1[33:0];

  assign add_signext_4 = sum2;
  assign add_signext_5 = $signed({{3{product4[30]}}, product4});
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sum3 = add_temp_2[33:0];

  assign add_signext_6 = sum3;
  assign add_signext_7 = $signed({{3{product5[30]}}, product5});
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sum4 = add_temp_3[33:0];

  assign add_signext_8 = sum4;
  assign add_signext_9 = $signed({{3{product6[30]}}, product6});
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum5 = add_temp_4[33:0];

  assign add_signext_10 = sum5;
  assign add_signext_11 = $signed({{3{product7[30]}}, product7});
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sum6 = add_temp_5[33:0];

  assign add_signext_12 = sum6;
  assign add_signext_13 = $signed({{3{product8[30]}}, product8});
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sum7 = add_temp_6[33:0];

  assign add_signext_14 = sum7;
  assign add_signext_15 = $signed({{3{product9[30]}}, product9});
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sum8 = add_temp_7[33:0];

  assign add_signext_16 = sum8;
  assign add_signext_17 = $signed({{3{product10[30]}}, product10});
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sum9 = add_temp_8[33:0];

  assign add_signext_18 = sum9;
  assign add_signext_19 = $signed({{3{product11[30]}}, product11});
  assign add_temp_9 = add_signext_18 + add_signext_19;
  assign sum10 = add_temp_9[33:0];

  assign add_signext_20 = sum10;
  assign add_signext_21 = $signed({{3{product12[30]}}, product12});
  assign add_temp_10 = add_signext_20 + add_signext_21;
  assign sum11 = add_temp_10[33:0];

  assign add_signext_22 = sum11;
  assign add_signext_23 = $signed({{3{product13[30]}}, product13});
  assign add_temp_11 = add_signext_22 + add_signext_23;
  assign sum12 = add_temp_11[33:0];

  assign add_signext_24 = sum12;
  assign add_signext_25 = $signed({{3{product14[30]}}, product14});
  assign add_temp_12 = add_signext_24 + add_signext_25;
  assign sum13 = add_temp_12[33:0];

  assign add_signext_26 = sum13;
  assign add_signext_27 = $signed({{3{product15[30]}}, product15});
  assign add_temp_13 = add_signext_26 + add_signext_27;
  assign sum14 = add_temp_13[33:0];

  assign add_signext_28 = sum14;
  assign add_signext_29 = $signed({{3{product16[30]}}, product16});
  assign add_temp_14 = add_signext_28 + add_signext_29;
  assign sum15 = add_temp_14[33:0];

  assign add_signext_30 = sum15;
  assign add_signext_31 = $signed({{3{product17[30]}}, product17});
  assign add_temp_15 = add_signext_30 + add_signext_31;
  assign sum16 = add_temp_15[33:0];

  assign add_signext_32 = sum16;
  assign add_signext_33 = $signed({{3{product18[30]}}, product18});
  assign add_temp_16 = add_signext_32 + add_signext_33;
  assign sum17 = add_temp_16[33:0];

  assign add_signext_34 = sum17;
  assign add_signext_35 = $signed({{3{product19[30]}}, product19});
  assign add_temp_17 = add_signext_34 + add_signext_35;
  assign sum18 = add_temp_17[33:0];

  assign add_signext_36 = sum18;
  assign add_signext_37 = $signed({{3{product20[30]}}, product20});
  assign add_temp_18 = add_signext_36 + add_signext_37;
  assign sum19 = add_temp_18[33:0];

  assign add_signext_38 = sum19;
  assign add_signext_39 = $signed({{3{product21[30]}}, product21});
  assign add_temp_19 = add_signext_38 + add_signext_39;
  assign sum20 = add_temp_19[33:0];

  assign add_signext_40 = sum20;
  assign add_signext_41 = $signed({{3{product22[30]}}, product22});
  assign add_temp_20 = add_signext_40 + add_signext_41;
  assign sum21 = add_temp_20[33:0];

  assign add_signext_42 = sum21;
  assign add_signext_43 = $signed({{3{product23[30]}}, product23});
  assign add_temp_21 = add_signext_42 + add_signext_43;
  assign sum22 = add_temp_21[33:0];

  assign add_signext_44 = sum22;
  assign add_signext_45 = $signed({{3{product24[30]}}, product24});
  assign add_temp_22 = add_signext_44 + add_signext_45;
  assign sum23 = add_temp_22[33:0];

  assign add_signext_46 = sum23;
  assign add_signext_47 = $signed({{3{product25[30]}}, product25});
  assign add_temp_23 = add_signext_46 + add_signext_47;
  assign sum24 = add_temp_23[33:0];

  assign add_signext_48 = sum24;
  assign add_signext_49 = $signed({{3{product26[30]}}, product26});
  assign add_temp_24 = add_signext_48 + add_signext_49;
  assign sum25 = add_temp_24[33:0];

  assign add_signext_50 = sum25;
  assign add_signext_51 = $signed({{3{product27[30]}}, product27});
  assign add_temp_25 = add_signext_50 + add_signext_51;
  assign sum26 = add_temp_25[33:0];

  assign add_signext_52 = sum26;
  assign add_signext_53 = $signed({{3{product28[30]}}, product28});
  assign add_temp_26 = add_signext_52 + add_signext_53;
  assign sum27 = add_temp_26[33:0];

  assign add_signext_54 = sum27;
  assign add_signext_55 = $signed({{3{product29[30]}}, product29});
  assign add_temp_27 = add_signext_54 + add_signext_55;
  assign sum28 = add_temp_27[33:0];

  assign add_signext_56 = sum28;
  assign add_signext_57 = $signed({{3{product30[30]}}, product30});
  assign add_temp_28 = add_signext_56 + add_signext_57;
  assign sum29 = add_temp_28[33:0];

  assign add_signext_58 = sum29;
  assign add_signext_59 = $signed({{3{product31[30]}}, product31});
  assign add_temp_29 = add_signext_58 + add_signext_59;
  assign sum30 = add_temp_29[33:0];

  assign add_signext_60 = sum30;
  assign add_signext_61 = $signed({{3{product32[30]}}, product32});
  assign add_temp_30 = add_signext_60 + add_signext_61;
  assign sum31 = add_temp_30[33:0];

  assign add_signext_62 = sum31;
  assign add_signext_63 = $signed({{3{product33[30]}}, product33});
  assign add_temp_31 = add_signext_62 + add_signext_63;
  assign sum32 = add_temp_31[33:0];

  assign add_signext_64 = sum32;
  assign add_signext_65 = $signed({{3{product34[30]}}, product34});
  assign add_temp_32 = add_signext_64 + add_signext_65;
  assign sum33 = add_temp_32[33:0];

  assign add_signext_66 = sum33;
  assign add_signext_67 = $signed({{3{product35[30]}}, product35});
  assign add_temp_33 = add_signext_66 + add_signext_67;
  assign sum34 = add_temp_33[33:0];

  assign add_signext_68 = sum34;
  assign add_signext_69 = $signed({{3{product36[30]}}, product36});
  assign add_temp_34 = add_signext_68 + add_signext_69;
  assign sum35 = add_temp_34[33:0];

  assign add_signext_70 = sum35;
  assign add_signext_71 = $signed({{3{product37[30]}}, product37});
  assign add_temp_35 = add_signext_70 + add_signext_71;
  assign sum36 = add_temp_35[33:0];

  assign add_signext_72 = sum36;
  assign add_signext_73 = $signed({{3{product38[30]}}, product38});
  assign add_temp_36 = add_signext_72 + add_signext_73;
  assign sum37 = add_temp_36[33:0];

  assign add_signext_74 = sum37;
  assign add_signext_75 = $signed({{3{product39[30]}}, product39});
  assign add_temp_37 = add_signext_74 + add_signext_75;
  assign sum38 = add_temp_37[33:0];

  assign add_signext_76 = sum38;
  assign add_signext_77 = $signed({{3{product40[30]}}, product40});
  assign add_temp_38 = add_signext_76 + add_signext_77;
  assign sum39 = add_temp_38[33:0];

  assign add_signext_78 = sum39;
  assign add_signext_79 = $signed({{3{product41[30]}}, product41});
  assign add_temp_39 = add_signext_78 + add_signext_79;
  assign sum40 = add_temp_39[33:0];

  assign add_signext_80 = sum40;
  assign add_signext_81 = $signed({{3{product42[30]}}, product42});
  assign add_temp_40 = add_signext_80 + add_signext_81;
  assign sum41 = add_temp_40[33:0];

  assign add_signext_82 = sum41;
  assign add_signext_83 = $signed({{3{product43[30]}}, product43});
  assign add_temp_41 = add_signext_82 + add_signext_83;
  assign sum42 = add_temp_41[33:0];

  assign add_signext_84 = sum42;
  assign add_signext_85 = $signed({{3{product44[30]}}, product44});
  assign add_temp_42 = add_signext_84 + add_signext_85;
  assign sum43 = add_temp_42[33:0];

  assign add_signext_86 = sum43;
  assign add_signext_87 = $signed({{3{product45[30]}}, product45});
  assign add_temp_43 = add_signext_86 + add_signext_87;
  assign sum44 = add_temp_43[33:0];

  assign add_signext_88 = sum44;
  assign add_signext_89 = $signed({{3{product46[30]}}, product46});
  assign add_temp_44 = add_signext_88 + add_signext_89;
  assign sum45 = add_temp_44[33:0];

  assign add_signext_90 = sum45;
  assign add_signext_91 = $signed({{3{product47[30]}}, product47});
  assign add_temp_45 = add_signext_90 + add_signext_91;
  assign sum46 = add_temp_45[33:0];

  assign add_signext_92 = sum46;
  assign add_signext_93 = $signed({{3{product48[30]}}, product48});
  assign add_temp_46 = add_signext_92 + add_signext_93;
  assign sum47 = add_temp_46[33:0];

  assign add_signext_94 = sum47;
  assign add_signext_95 = $signed({{3{product49[30]}}, product49});
  assign add_temp_47 = add_signext_94 + add_signext_95;
  assign sum48 = add_temp_47[33:0];

  assign add_signext_96 = sum48;
  assign add_signext_97 = $signed({{3{product50[30]}}, product50});
  assign add_temp_48 = add_signext_96 + add_signext_97;
  assign sum49 = add_temp_48[33:0];

  assign add_signext_98 = sum49;
  assign add_signext_99 = $signed({{3{product51[30]}}, product51});
  assign add_temp_49 = add_signext_98 + add_signext_99;
  assign sum50 = add_temp_49[33:0];

  always @ (posedge clk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= sum50;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // filter_phase
