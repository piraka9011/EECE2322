module Adder4Bit(
input[3:0] a,
input[3:0] b,
input c_in,
output[3:0] s,
output c_out);
wire [4:0] result;
assign result = a + b + c_in;
assign c_out = result[4];
assign s = result[3:0];
endmodule

module Subtractor4BitStructural(
input[3:0] a,
input[3:0] b,
output[3:0] d);
wire c_out;
wire[3:0] not_b;
not(not_b[0], b[0]);
not(not_b[1], b[1]);
not(not_b[2], b[2]);
not(not_b[3], b[3]);
Adder4Bit adder_4_bit(a, not_b, 1'b1, d, c_out);
endmodule

module Subtractor4BitDataflow(
input[3:0] a,
input[3:0] b,
output[3:0] d);
assign d = a - b;
endmodule
module Subtractor4BitTest;
wire[3:0] d;
reg[3:0] a, b;
Subtractor4BitStructural subtractor_4_bit(a, b, d);
initial begin
$monitor("%d a=%b, b=%b, d=%b",
$time,
a, b, d);
#10
a = 2;
b = 2;
#10
a = 1;
b = 5;
#10
a = 3;
b = 7;
#10
a = 8;
b = 9;
end
endmodule