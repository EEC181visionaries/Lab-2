module lab2(
	///////////////////////////////////
	// FPGA Pins
	///////////////////////////////////
	// Clock pins
	CLOCK_50,
	// Seven Segment Displays
	HEX0,	HEX1,	HEX2,	HEX3,	HEX4,	HEX5,
    
	// Pushbuttons
	KEY,
	// LEDs
	LEDR,
    
	/////////////////////////////////////
	// HPS Pins
	/////////////////////////////////////
    
	// DDR3 SDRAM
	HPS_DDR3_ADDR,
	HPS_DDR3_BA,
	HPS_DDR3_CAS_N,
	HPS_DDR3_CKE,
	HPS_DDR3_CK_N,
	HPS_DDR3_CK_P,
	HPS_DDR3_CS_N,
	HPS_DDR3_DM,
	HPS_DDR3_DQ,
	HPS_DDR3_DQS_N,
	HPS_DDR3_DQS_P,
	HPS_DDR3_ODT,
	HPS_DDR3_RAS_N,
	HPS_DDR3_RESET_N,
	HPS_DDR3_RZQ,
	HPS_DDR3_WE_N,
    
    DRAM_CLK
);



//===========================================
// PORT declarations
//===========================================

///////////////////////////////////
// FPGA Pins
///////////////////////////////////
output DRAM_CLK;
input CLOCK_50;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
input [3:0] KEY;
output [9:0] LEDR;



////////////////////////////////////
// HPS Pins
////////////////////////////////////

// DDR3 SDRAM
output [14:0] HPS_DDR3_ADDR;
output [2:0] HPS_DDR3_BA;
output HPS_DDR3_CAS_N;
output HPS_DDR3_CKE;
output HPS_DDR3_CK_N;
output HPS_DDR3_CK_P;
output HPS_DDR3_CS_N;
output [3:0] HPS_DDR3_DM;
inout [31:0] HPS_DDR3_DQ;
inout [3:0] HPS_DDR3_DQS_N;
inout [3:0] HPS_DDR3_DQS_P;
output HPS_DDR3_ODT;
output HPS_DDR3_RAS_N;
output HPS_DDR3_RESET_N;
input HPS_DDR3_RZQ;
output HPS_DDR3_WE_N;

//===================================
// REG/WIRE declarations
//===================================

wire [31:0] hex3_hex0;
wire [15:0] hex5_hex4;
wire [31:0] REG32;
assign LEDR[7:0] = REG32[31:24];



hex_7seg CONVERTER0(REG32[3:0],HEX0);
hex_7seg CONVERTER1(REG32[7:4],HEX1);
hex_7seg CONVERTER2(REG32[11:8],HEX2);
hex_7seg CONVERTER3(REG32[15:12],HEX3);
hex_7seg CONVERTER4(REG32[19:16],HEX4);
hex_7seg CONVERTER5(REG32[23:20],HEX5);

//=======================================
// Structural coding
//=======================================

    mysystem u0 (
        .system_ref_clk_clk     (CLOCK_50),     //   system_ref_clk.clk
        .system_ref_reset_reset (~KEY[0]), // system_ref_reset.reset
        .sys_clk_clk            (DRAM_CLK),            //          sys_clk.clk
        
        .memory_mem_a       (HPS_DDR3_ADDR),       //      memory.mem_a
        .memory_mem_ba      (HPS_DDR3_BA),      //            .mem_ba
        .memory_mem_ck      (HPS_DDR3_CK_P),      //            .mem_ck
        .memory_mem_ck_n    (HPS_DDR3_CK_N),    //            .mem_ck_n
        .memory_mem_cke     (HPS_DDR3_CKE),     //            .mem_cke
        .memory_mem_cs_n    (HPS_DDR3_CS_N),    //            .mem_cs_n
        .memory_mem_ras_n   (HPS_DDR3_RAS_N),   //            .mem_ras_n
        .memory_mem_cas_n   (HPS_DDR3_CAS_N),   //            .mem_cas_n
        .memory_mem_we_n    (HPS_DDR3_WE_N),    //            .mem_we_n
        .memory_mem_reset_n (HPS_DDR3_RESET_N), //            .mem_reset_n
        .memory_mem_dq      (HPS_DDR3_DQ),      //            .mem_dq
        .memory_mem_dqs     (HPS_DDR3_DQS_P),     //            .mem_dqs
        .memory_mem_dqs_n   (HPS_DDR3_DQS_N),   //            .mem_dqs_n
        .memory_mem_odt     (HPS_DDR3_ODT),     //            .mem_odt
        .memory_mem_dm      (HPS_DDR3_DM),      //            .mem_dm
        .memory_oct_rzqin   (HPS_DDR3_RZQ),   //            .oct_rzqin
        
        .pushbutton_export      (~KEY[3:1]),      //       pushbutton.export
        .hex3_0bus_export       (hex3_hex0),       //        hex3_0bus.export
        .hex5_4bus_export       (hex5_hex4),       //        hex5_4bus.export
        .hex_to_led_export      (REG32),      //       hex_to_led.export
    );

endmodule



module hex_7seg (input [3:0] hex,  output reg [0:6] seg);
parameter ZERO = 7'b000_0001;
parameter ONE = 7'b100_1111;
parameter TWO = 7'b010_0100;
parameter THREE = 7'b011_0000;
parameter FOUR = 7'b001_1001;
parameter FIVE = 7'b001_0010;
parameter SIX = 7'b000_0010;
parameter SEVEN = 7'b111_1000;
parameter EIGHT = 7'b000_0000;
parameter NINE = 7'b001_1000;
parameter A = 7'b000_1000;
parameter B = 7'b000_0011;
parameter C = 7'b100_0110;
parameter D = 7'b010_0001;
parameter E = 7'b000_0110;
parameter F = 7'b000_1110;

always @(hex)

case (hex)
0: seg = ZERO;
1: seg = ONE;
2: seg = TWO;
3: seg = THREE;
4: seg = FOUR;
5: seg = FIVE;
6: seg = SIX;
7: seg = SEVEN;
8: seg = EIGHT;
9: seg = NINE;
10: seg = A;
11: seg = B;
12: seg = C;
13: seg = D;
14: seg = E;
15: seg = F;
endcase

endmodule
