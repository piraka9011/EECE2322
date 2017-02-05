module Mux1Bit2to1 (input x_0,
										input x_1,
										input sel,
										output y);
    assign y = sel ? x_1 : x_0;
endmodule

module Dec2to4 (input [1:0]in,
								output [3:0]out);
	  assign in = 1 << out;
endmodule

module BitSet(input [3:0]x,
			  			input [1:0]index,
			  			input value,
			  			output [3:0]y);
	  wire [3:0]dec2mux;

    Dec2to4 dec_1(.in(index), .out(dec2mux));
		Mux1Bit2to1 mux_1(.x_0(x[0]), .x_1(dec2mux[0]), .sel(value), .y(y[0]));
		Mux1Bit2to1 mux_2(.x_0(x[1]), .x_1(dec2mux[1]), .sel(value), .y(y[1]));
		Mux1Bit2to1 mux_3(.x_0(x[2]), .x_1(dec2mux[2]), .sel(value), .y(y[2]));
		Mux1Bit2to1 mux_4(.x_0(x[3]), .x_1(dec2mux[3]), .sel(value), .y(y[3]));
endmodule

module BitSetTB;
	  reg [3:0]x;
		reg [1:0]index;
		reg value;
		wire [3:0]y;

		BitSet bitsy(.x(x), .index(index), .value(value), .y(y));

		initial begin
		$monitor("%d index=%b, value=%b, x=%b, y=%b",
						 $time,
						 index, value, x, y);
		    #10
				x = 4'b0111;
				index = 0;
				value = 0;
				#10
				x = 4'b0101;
				index = 1;
				value = 1;
				#10
				x = 4'b1010;
				index = 2;
				value = 1;
				#10
				x = 4'b100;
				index = 3;
				value = 0;
		end

endmodule
