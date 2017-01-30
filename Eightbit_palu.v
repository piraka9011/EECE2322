module Eightbitpalu(
		input [7:0]a,
		input [7:0]b,
		input [1:0]s,
		output [7:0]f,
		output ovf);
reg [7:0]f;
reg ovf;

 
	always @(s or b or a) begin
		if (s==2'b00)begin
			f = a+b;
			ovf = (a[7]^f[7]) && (b[7]^f[7]); 
		end else if (s==2'b01)begin
			f= ~b;
			ovf =0;
		end else if (s==2'b10)begin
			f = a&b;
			ovf=0;
		end else if (s==2'b11) begin
			f=a|b;
			ovf=0;
		end else begin
			f = 8'b11111111;
			ovf=0;	
		end	
	end


endmodule 

`timescale 1ns / 10ps
module testbench();
	
	reg [7:0]a;
	reg [7:0]b;
	reg [1:0]s;
	wire [7:0]f;
	wire ovf;

Eightbitpalu DUT(
	.a(a),
	.b(b),
	.s(s),
	.f(f),
	.ovf(ovf)
	);

	initial begin
		$monitor("%d Value of f = %b, value of a= %b, value b=%b, value ovf=%b, s=%d",$time, f,a,b,ovf,s);
		
		#150;
		s=2'b00;
		a=8'b00000111;
		b=8'b01100100;

		//$monitor("%d Value of f = %d, value of a= %d, value b=%d, value ovf=%b",$time, f,a,b,ovf) ;
		
		#150;
        s=2'b00; // add
        a = 8'b01010000;    // 15
        b = 8'b01011010;    // 90


		#150;
        a = 8'b00001111;    // 15
        b = 8'b01011010;    // 90
		s=2'b01; // B inverse

		#150;
		a=8'b10001111;
		b=8'b10010101;
		s=2'b10;

		#150;
		a=8'b10001111;
		b=8'b10010101;
		s=2'b11;





        
		$finish;
	end
		//$finish;
endmodule