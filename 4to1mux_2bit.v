module Mux2Bit4to1(input e,
				   input [7:0]x,
				   input [1:0]s,
				   input [1:0]y);
	// Remember that inputs are 2 bits each, selector must select
	// the 2 bits corresponding to each input

	// The first bit of the output is the first bit of x_i
	// First bit is a multiple of 2
	assign y[0] = e ? x[s*2] : 0; 
	// The second bit of the output is the second bit of x_i
	// Second bit is just adding one to first
	assign y[1] = e ? x[s*2 +1] : 0;
endmodule