module Decoder2to4(input [1:0]x, 
				   output[3:0]d ); 
	// Shift 1 bit x times
	assign d = 1 << x;

endmodule

module Mux2to1(input x,
			   input s,
			   input value,
			   output y );

	// Assign y to either the value (1) or x (0)
	assign y = s ? value : x;

endmodule

module Bitset(
		input [3:0]x,
		input [1:0]index,
		input value,
		output [3:0]y );

	wire [3:0]tempout;

	// Decode index to determine which mux to use
	Decoder2to4 decode(index, tempout);
	// Assign y based on Mux inputs and value
	Mux2to1 mux_0 (x[0], tempout[0], value, y[0]);
	Mux2to1 mux_1 (x[1], tempout[1], value, y[1]);
	Mux2to1 mux_2 (x[2], tempout[2], value, y[2]);
	Mux2to1 mux_3 (x[3], tempout[3], value, y[3]);

endmodule 

module tb();
	reg [3:0]x;
	reg [1:0]index;
	reg value;
	wire [3:0]y;

	// Call BitSet module
	Bitset uut(x, index, value, y);

	initial begin
		$monitor("%d index=%b, x=%b, value=%b, y=%b",
				  $time, index, x, value, y);
		#10
		index=2'b00;
		x=4'b1000;
		value = 1'b1;

		#10
		index=2'b01;
		x=4'b0010;
		value = 1'b0;

		#10
		index=2'b10;
		x=4'b0000;
		value = 1'b1;

		#10
		index=2'b11;
		x=4'b1101;
		value = 1'b0;
	end
endmodule