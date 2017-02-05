module RegFile1x32(
				input clock,
				input clear,
				//input read_index,
				input inc,
				input write,
				input [31:0]write_data,
				output [31:0]read
				);

	reg [31:0] block;
	integer i;

	always @(negedge clock, posedge clear) begin
		if (clear) begin
			block = 0;
		end
		else if (write) begin
			block = write_data;
		end
		else if (inc) begin
			block = block + 3;
		end
	end

	assign read = block ;

endmodule 

module RegisterfileTB;
reg clock, clear, write,inc;
reg [31:0] write_data;
wire [31:0]read;


RegFile1x32 uut(clock, clear,inc, write, write_data,read);

initial begin
		clear =1;
		#10 clear=0;
end

initial begin
	clock = 1;
	forever #5 clock = ~clock;
end

initial begin
	$monitor("%d ", $time,
			"clock= %b ", clock,
			"Clear = %b ", clear,
			"write sgnl= %b ", write,
			"write_data = %d ", write_data,
			"Inc signal = %d ", inc,
			"Read = %d ", read);

	write =0;
	write_data =0;

	#10 write=1;
		write_data = 25;

	#10 write =0;
	#10 inc =1;
	#10 inc =0;
	#10 $finish;

end

endmodule
