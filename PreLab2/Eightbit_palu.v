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
		$monitor("%d Value of f = %b, value of a= %d, value b=%d, value ovf=%b, s=%d\n",$time, f,a,b,ovf,s);
		
		#10;
		s=2'b00; // Add 1
		a=8'b00000111;
		b=8'b01100100;
	
		#10;
        s=2'b00; // Add 2
        a = 8'b11110110;    
        b = 8'b11111111;    

		#10;
		s=2'b00; //Add 3
        a = 8'b00001100;    
        b = 8'b01011010;    
		

		#10;
		s=2'b00; //Add 4
        a = 8'b01001100;    
        b = 8'b01011010;    

        #10;
		s=2'b00; //Add 5
        a = 8'b00110010;    
        b = 8'b10010001; 

        #10;
		s=2'b01; //inverse1 b
        a = 8'b00000111;    
        b = 8'b01100100;  

        #10;
		s=2'b01; //inverse2 b
        a = 8'b11110000;    
        b = 8'b00011010;

        #10;
		s=2'b01; //inverse3 b
        a = 8'b00001000;    
        b = 8'b10000001; 
	
		#10;
		s=2'b10; //and 1
		a=8'b10101000;
		b=8'b10101000;
		
		#10;
		s=2'b10; //and 2
		a=8'b01010111;
		b=8'b01010111;
		
		#10;
		s=2'b11; // or1 
		a=8'b10110000;
		b=8'b01110101;

		#10;
		s=2'b11; // or2
		a=8'b00001011;
		b=8'b10001010;

		#10;
		s=2'b11; // or3
		a=8'b01001100;
		b=8'b10001010;


		





        
		$finish;
	end
		//$finish;
endmodule