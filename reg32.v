module reg32 (clock, resetn, D, byteenable, Q);
input [0:0] clock;
input [0:0] resetn;
input [31:0] D;
input [1:0] byteenable;
output reg [31:0] Q;

always @(posedge clock or negedge resetn) begin
	if (resetn == 0) begin
		Q = 0;
	end
	else begin
		Q = D;
	end // if (reset == 1)
	
end // @(posedge clock)
endmodule // reg32
