// megafunction wizard: %ALTDDIO_OUT%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTDDIO_OUT 

// ============================================================
// File Name: Myddio.v
// Megafunction Name(s):
// 			ALTDDIO_OUT
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 17.1.0 Build 590 10/25/2017 SJ Lite Edition
// ************************************************************

//Copyright (C) 2017  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.

module Myddio (
	datain_h,
	datain_l,
	outclock,
	dataout);

	input	[0:0]  datain_h;
	input	[0:0]  datain_l;
	input	  outclock;
	output	[0:0]  dataout;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: EXTEND_OE_DISABLE STRING "OFF"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: INVERT_OUTPUT STRING "OFF"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altddio_out"
// Retrieval info: CONSTANT: OE_REG STRING "UNREGISTERED"
// Retrieval info: CONSTANT: POWER_UP_HIGH STRING "OFF"
// Retrieval info: CONSTANT: WIDTH NUMERIC "1"
// Retrieval info: USED_PORT: datain_h 0 0 1 0 INPUT NODEFVAL "datain_h[0..0]"
// Retrieval info: CONNECT: @datain_h 0 0 1 0 datain_h 0 0 1 0
// Retrieval info: USED_PORT: datain_l 0 0 1 0 INPUT NODEFVAL "datain_l[0..0]"
// Retrieval info: CONNECT: @datain_l 0 0 1 0 datain_l 0 0 1 0
// Retrieval info: USED_PORT: dataout 0 0 1 0 OUTPUT NODEFVAL "dataout[0..0]"
// Retrieval info: CONNECT: dataout 0 0 1 0 @dataout 0 0 1 0
// Retrieval info: USED_PORT: outclock 0 0 0 0 INPUT_CLK_EXT NODEFVAL "outclock"
// Retrieval info: CONNECT: @outclock 0 0 0 0 outclock 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL Myddio.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL Myddio.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL Myddio.bsf TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL Myddio_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL Myddio_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL Myddio.inc TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL Myddio.cmp TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL Myddio.ppf TRUE FALSE
// Retrieval info: LIB_FILE: altera_mf
