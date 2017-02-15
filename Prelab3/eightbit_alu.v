module EightbitALU(
		input signed [7:0]a,
		input signed [7:0]b,
		input [2:0]s,
		output signed [7:0]f,
		output ovf,
		output take_branch);
reg [7:0]f;
reg ovf;
reg take_branch;

 
	always @(s,b, a) begin
		if (s==3'b000)begin
			f = a+b;
			ovf = (a[7]^f[7]) && (b[7]^f[7]);
			take_branch=0; 
		end else if (s==3'b001)begin
			f= ~b;
			ovf =0;
			take_branch=0;
		end else if (s==3'b010)begin
			f = a&b;
			ovf=0;
			take_branch=0;
		end else if (s==3'b011) begin
			f=a|b;
			ovf=0;
			take_branch=0;
		end else if (s==3'b100) begin
			f=a >>>1;
			ovf=0;
			take_branch=0;
		end else if (s==3'b101) begin
			f=a<<1;
			ovf=0;
			take_branch=0;
		end else if (s==3'b110) begin
			f=0;
			ovf=0;
			if(a==b)begin
				take_branch=1;
			end
			else begin
				take_branch=0;
			end
		end else if (s==3'b111) begin
			f=0;
			ovf=0;
			if(a!=b)begin
				take_branch=1;
			end
			else begin
				take_branch=0;
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
		$monitor("%d f = %b, a= %d, value b=%d, ovf=%b, branch=%d s=%d\n",$time, f,a,b,ovf,take_branch,s);

		
		
	end
endmodule