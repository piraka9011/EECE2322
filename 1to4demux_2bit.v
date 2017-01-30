module DeMux1To4(input e,
				 input x,
				 input [1:0]s,
				 output [3:0]y);
	reg y;
	// Check if any of the inputs change
	always @(e, x, s)
		if (e)	// If input is enabled, continue
			case (s)
				// Selector determines the output, note that demux
				// has same process as decoder

				// Concatenate the bits accordingly based on selector where,
				// x is the demux input
				0: y = {3'b000, x};
				1: y = {2'b0, x, 1'b0};
				2: y = {1'b0, x, 2'b00};
				3: y = {x, 3'b000};
			endcase
		else	// If input disabled, output 0
			y = 0;
endmodule
