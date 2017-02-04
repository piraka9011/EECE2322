module TFlipFlop (input t,
				  input clock, 
				  input clear,
				  output reg q);
	always @ (negedge clock, posedge clear)
		if (~clear)
			assign q = 1'b0;
		else if (t)
			assign q = ~q;
endmodule

module TFFTest;
	// Create variables
	reg t, clock, clear;
	wire q;

	// Call T Flip Flop Module
	TFlipFlop tff_1(t, clock, clear, q);

	// Initial clear pulse
	initial begin
		clear = 1'b1;
		#10 clear = 1'b0;
	end

	// Continuous clock pulse
	initial begin
		clock = 1;
		forever 
		#5 clock = ~clock;
	end

	initial begin
		$monitor("%d clear=%b, clock=%b, t=%b, q=%b",
			  	  $time, clear, clock, t, q);
		#10
		t = 1'b0;

		#10
		t = 1'b1;

		#10 $finish;
	end

endmodule