module RegFile32x32(
		input write1,
		input [31:0] write_data1,
		input [4:0] write_index1,
		input write2,
		input [31:0] write_data2,
		input [4:0] write_index2,
		input [4:0] read_index,
		input clear,
		input clock,
		output [31:0] read_value
					);

reg [7:0] blocks [3:0];
integer i;

always @(negedge clock, posedge clear) begin
	if (clear) begin
		for(i=0; i<4;i++)
			blocks[i] = 0;		
	end
	else if (write1) begin
		blocks[write_index1] = write_data1;
	end
	else if(write2) begin
		blocks[write_index2] = write_data2;
	end
	else if(write1&write2)begin
		blocks[write_index1] = write_data1;
	end
end

assign read_value = blocks [read_index];

endmodule



module RegFileTB;
reg wr1,wr2;
reg [31:0] wrd1,wrd2;
reg [4:0] wri1, wri2, rdi;
reg clock,clear;
wire [31:0] rdv;

RegFile32x32 uut(wr1,wrd1,wri1,wr2,wrd2,wri2,rdi,clear,clock,rdv);

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
			"clock = %d ", clock,
			"clear = %d ", clear,	
			"write1 = %d ", wr1,
			"write_data1 = %d ", wrd1,
			"write_index1 = %d ", wri1,
			"write2 = %d ", wr2,
			"write_data2 = %d ", wrd2,
			"write_index2 = %d ", wri2,
			"read_index = %d ", rdi,
			"read_value = %d ", rdv
			);

	#10;
	wr1=1;
	wr2=1;
	wrd1 = 11;
	wrd2 = 25; 
	wri1 = 1;
	wri2 = 2; 

	#10;
	wr1 = 0;
	wr2 = 0;
	rdi = 1;

	#10;
	rdi = 2;

	#10;
	wr1=1;
	wr2=1;
	wrd1=55;
	wrd2=66;
	wri1=3;
	wri2=3;

	#10;
	wr1 = 0;
	wr2 = 0;
	rdi = 3;


	#10 $finish;

end

endmodule