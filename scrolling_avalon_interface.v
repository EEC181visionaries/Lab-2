module scrolling_avalon_interface (clock, resetn, write, writedata, read, readdata, byteenable, chipselect, val_out);

	// Standard clock and reset signals
	input clock, resetn;

	// Avalon MMI signals - These will be automatically be detected and organized by Qsys
	input read, write, chipselect;
	input [3:0] byteenable;
	input [31:0] writedata;
	output [31:0] readdata;

	// Signal for exporting register contents to the outside of the embedded system
	output [31:0] val_out;

	// Internal signals used in this module only
	wire [3:0] local_byteenable;
	wire [31:0] to_reg, from_reg;

	assign to_reg = writedata;
	assign local_byteenable = (chipselect & write) ? byteenable : 4'b0;
	assign readdata = from_reg;
	assign val_out = from_reg;

	scrolling U1 (.clock(clock), .resetn(resetn), .byteenable(local_byteenable), .speed_in(to_reg), .val_out(from_reg));


endmodule
