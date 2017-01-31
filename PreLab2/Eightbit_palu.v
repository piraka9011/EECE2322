module Eightbitpalu(
		input [7:0]a,
		input [7:0]b,
		input [1:0]sel,
		output [7:0]f,
		output ovf);

reg [7:0]f;
reg ovf;

	always @(sel or b or a) begin
		if (sel == 2'b00)begin
			f = a+b;
			ovf = (a[7] ^ f[7]) && (b[7] ^ f[7]); 
		end else if (sel == 2'b01)begin
			f = ~b;
			ovf = 0;
		end else if (sel == 2'b10)begin
			f = a & b;
			ovf = 0;
		end else if (sel == 2'b11) begin
			f = a | b;
			ovf = 0;
		end else begin
			f = 8'b11111111;
			ovf = 0;	
		end	
	end
endmodule 

`timescale 1ns / 10ps
module testbench();
	
	reg [7:0]a;
	reg [7:0]b;
	reg [1:0]sel;
	wire [7:0]f;
	wire ovf;

Eightbitpalu DUT(
	.a(a),
	.b(b),
	.sel(sel),
	.f(f),
	.ovf(ovf)
	);

	initial begin
		$monitor("%d s=%d, a=%b, b=%b, f=%b, ovf=%b",
				  $time, sel, a, b, f, ovf);
		
		#150;
		sel = 2'b00;		// Add
		a = 8'b00000111;	// 7
		b = 8'b01100100;	// 
		
		#150;
        sel = 2'b00; 		// Add
        a = 8'b01010000;    // 15
        b = 8'b01011010;    // 90

		#150;
		sel = 2'b01; 		// B inverse
        a = 8'b00001111;    // 15
        b = 8'b01011010;    // 90

		#150;
		sel = 2'b10;		// Bitwise AND
		a = 8'b10001111;
		b = 8'b10010101;

		#150;
		sel = 2'b11;		// Bitwise OR
		a = 8'b10101111;
		b = 8'b10010101;

		$finish;
	end
endmodule