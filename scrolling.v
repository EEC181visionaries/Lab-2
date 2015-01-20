module scrolling (clock, byteenable, speed_in, out);

	// ==== I/O List
	input clock;
	input [31:0] speed_in;
	output reg [31:0] out;
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

		out[3:0] = hex0;
		out[7:4] = hex1;
		out[11:8] = hex2;
		out[15:12] = hex3;
		out[19:16] = hex4;
		out[23:20] = hex5;
		out[27:24] = hex6;
		out[31:28] = hex7;
end
endmodule
