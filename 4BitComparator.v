module 4BitComparator(input [3:0]a, 
					  input [3:0]b, 
					  output eq, 
					  output lt,
					  output gt);
	assign eq = (a == b);
	assign lt = (a < b);
	assign gt = (a > b);
endmodule

module 8BitComparator(input [7:0]a,
					  input	[7:0]b,
					  output eq,
					  output lt,
					  output gt);

	4BitComparator 4bc_1(a[3:0], b[3:0], eq, lt, gt);
	4BitComparator 4bc_2(a[7:4])
endmodule