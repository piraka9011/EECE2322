module Bitset(
		input [3:0]x,
		input [1:0]index,
		input value,
		output [3:0]y 
		);

wire [3:0]tempout;
wire [1:0]selector;
wire [3:0]y;
decoder2to4 decode(index,tempout);
Mux2to1 mux_0 (x[0],selector[tempout[0]],value, y[0]);
Mux2to1 mux_1 (x[1],selector[tempout[1]],value, y[1]);
Mux2to1 mux_2 (x[2],selector[tempout[2]],value, y[2]);
Mux2to1 mux_3 (x[3],selector[tempout[3]],value, y[3]);

endmodule 

module decoder2to4(input [1:0]x, output[3:0]d);
wire [3:0]d; 
assign d[0] = ~x[1] & ~x[0];
assign d[1] = ~x[1] & x[0];
assign d[2] = x[1] & ~x[0];
assign d[3] = x[1] & x[0];

endmodule

module Mux2to1(input x,input s,input value,
output y);

assign y = (s)? value:x;

endmodule

module Mux4to1(input [3:0]x, input [1:0]s, output y);
assign y = x[s];
endmodule

module tb();
reg [3:0]x;
reg [1:0]index;
reg value;
wire [3:0]y;

Bitset uut(x,index,value,y);

initial begin
	$monitor("%d index: %d, x: %b, value:b, f:%b",$time, 
		index,x,index,value,y);
	#10;
	index=2'b00;
	x=4'b0000;
	value = 1;

	#10;
	index=2'b01;
	x=4'b0000;
	value = 0;

	#10;
	index=2'b10;
	x=4'b0000;
	value = 0;

	#10;
	index=2'b11;
	x=4'b0000;
	value = 1'b0;


end


endmodule