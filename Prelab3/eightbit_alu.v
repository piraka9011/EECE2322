module EightbitALU(
		input [7:0]a,
		input [7:0]b,
		input [2:0]s,
		output reg [7:0]f,
		output reg ovf,
		output reg take_branch);

	always @(s, b, a) begin
		if (s == 3'b000)begin
			f = a + b;
			ovf = (a[7] ^ f[7]) && (b[7] ^ f[7]);
			take_branch = 0;
		end else if (s == 3'b001)begin
			f = ~b;
			ovf = 0;
			take_branch = 0;
		end else if (s == 3'b010)begin
			f = a & b;
			ovf = 0;
			take_branch = 0;
		end else if (s == 3'b011) begin
			f = a | b;
			ovf = 0;
			take_branch = 0;
		end else if (s == 3'b100) begin
			f = a >>> 1;
			ovf = 0;
			take_branch = 0;
		end else if (s == 3'b101) begin
			f = a << 1;
			ovf = 0;
			take_branch = 0;
		end else if (s == 3'b110) begin
			f = 0;
			ovf = 0;
			if(a == b)begin
				take_branch = 1;
			end
			else begin
				take_branch = 0;
			end
		end else if (s == 3'b111) begin
			f = 0;
			ovf = 0;
			if(a != b)begin
				take_branch = 1;
			end
			else begin
				take_branch = 0;
			end
		end
	end
endmodule

`timescale 1ns / 10ps
module testbench();

	reg [7:0]a;
	reg [7:0]b;
	reg [2:0]s;
	wire [7:0]f;
	wire ovf;
	wire take_branch;
	EightbitALU DUT(a,b,s,f,ovf,take_branch);

	initial begin
		$monitor("%d, s=%b, a=%b, b=%b, f=%b, ovf=%b, branch=%b",
							$time, s, a, b, f, ovf, take_branch);
		#10
		s = 3'b000;				// Addition
		a = 8'b01001110;
		b = 8'b01100101;

		#10
		s = 3'b001;				// Inversion (b)
		b = 8'b10011010;

		#10
		s = 3'b010;				// AND
		a = 8'b00110001;
		b = 8'b00110101;

		#10
		s = 3'b011;				// OR
		a = 8'b10100101;
		b = 8'b01011010;

		#10
		s = 3'b100;				// Right Arithmetic Shift
		a = 8'b01001010;

		#10
		s = 3'b101;				// Right Logical Shift
		a = 8'b01110011;

		#10
		s = 3'b110;				// Equal
		a = 8'b10000110;
		b = 8'b10000110;

		#10
		s = 3'b111;				// Not Equal
		a = 8'b10000110;
		b = 8'b10000110;
	end
endmodule
