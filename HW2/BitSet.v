module Bitset(
		input[3:0]x,
		input [1:0]index,
		input value,
		output reg [3:0]y 
		);

wire [3:0]tempout;
wire [1:0]test;
wire [3:0] tempy;
decoder2to4 decode(index,tempout);
Mux2to1 mux_0 (x[tempout],test[tempout],value, tempy[0]);
/*
Mux2to1 mux_2 (x[1],value,y);
Mux2to1 mux_3 (x[2],value,y);
Mux2to1 mux_4 (x[3],value,y);
*/



endmodule 

module decoder2to4(input [1:0]x, output[3:0]d);
wire [3:0]d; 
assign d[0] = ~x[1] & ~x[0];
assign d[1] = ~x[1] & x[0];
assign d[2] = x[1] & ~x[0];
assign d[3] = x[1] & x[0];

endmodule

module Mux2to1(input [1:0]x,input s,input value,
output reg y);



endmodule

module Mux4to1(input [3:0]x, input [1:0]s, output y);
assign y = x[s] ;
endmodule

/*
module tb;
reg [3:0]x;
reg [1:0]index;
reg value;
wire [3:0]y;

initial begin
	
	#10;
	index=
end


endmodule
*/