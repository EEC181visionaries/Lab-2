module scrolling (clock, resetn, byteenable, speed_in, val_out);

	// ==== I/O List
	input clock, resetn;
	input [31:0] speed_in;
	output reg [31:0] val_out;
	input [3:0] byteenable;

	// ==== Variables
	reg [31:0] count;
	reg [31:0] speed, prev_speed;
	reg [31:0] scroll_value;
	reg [3:0] hex7, hex6, hex5, hex4, hex3, hex2, hex1, hex0;


	// ==== Initialize State
	initial begin
		prev_speed = 50;
		speed = 101010000 - 1010000*50;
		scroll_value = 2645; // A55h

		hex0 = scroll_value[3:0];
		hex1 = scroll_value[7:4];
		hex2 = scroll_value[11:8];
		hex3 = scroll_value[15:12];
		hex4 = scroll_value[19:16];
		hex5 = scroll_value[23:20];
		hex6 = scroll_value[27:24];
		hex7 = scroll_value[31:28];
		count = 0;
	end

	// ==== Main
	always @(posedge clock) begin
		if (speed_in != prev_speed) begin
			speed <= 101010000 - 1010000*speed_in;
			prev_speed <= speed_in;
		end

		if (count < speed)begin
			count <= count + 1;
		end
		else begin
			hex0 <= hex7;
			hex1 <= hex0;
			hex2 <= hex1;
			hex3 <= hex2;
			hex4 <= hex3;
			hex5 <= hex4;
			hex6 <= hex5;
			hex7 <= hex6;
			count = 0;
		end

		val_out[3:0] = hex0;
		val_out[7:4] = hex1;
		val_out[11:8] = hex2;
		val_out[15:12] = hex3;
		val_out[19:16] = hex4;
		val_out[23:20] = hex5;
		val_out[27:24] = hex6;
		val_out[31:28] = hex7;
end
endmodule
