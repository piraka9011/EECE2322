module HalfAdder(input a,
				 input b,
				 output s,
				 output c);
	xor G1(s, a, b);
	and G2(c, a, b);
endmodule

module FullAdder(input x,
				 input y,
				 input z,
				 output s,
				 output c);
	wire w1, w2, w3;
	HalfAdder half_adder_1(x, y, w1, w2);
	HalfAdder half_adder_2(w1, z, s, w3);
	or G1(c, w2, w3);
endmodule

module Adder4BitStructural(input[3:0] a,
						   input[3:0] b,
						   input c_in,
						   output[3:0] s,
						   output c_out);
						   wire[3:1] c;
	FullAdder full_adder_1(c_in, a[0], b[0], s[0], c[1]);
	FullAdder full_adder_2(c[1], a[1], b[1], s[1], c[2]);
	FullAdder full_adder_3(c[2], a[2], b[2], s[2], c[3]);
	FullAdder full_adder_4(c[3], a[3], b[3], s[3], c_out);
endmodule
