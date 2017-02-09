module reg_file(
				input rst,
				input clk,
				input wr_en,
				input [1:0] rd0_addr,
				input [1:0] rd1_addr,
				input [1:0] wr_addr,
				input [8:0] wr_data,
				output [8:0] rd0_data,
				output [8:0] rd1_data
				);
reg [8:0] register [3:0];
integer i;

	always @(negedge clk, posedge rst) begin
		if (rst) begin
			for(i=0; i<4; i++)
			register[i] = 0;
			
		end
		else if (wr_en) begin
			register[wr_addr] = wr_data;			
		end
	end

assign rd0_data = register[rd0_addr] ;
assign rd1_data = register[rd1_addr] ;

endmodule 

module tb; 
reg clk,rst,wr_en;
reg [1:0] rd1_addr,rd0_addr,wr_addr;
reg [8:0] wr_data;
wire [8:0] rd0_data,rd1_data;

reg_file uut(rst,clk,wr_en,rd0_addr,rd1_addr,
				wr_addr,wr_data,rd0_data,rd1_data);




initial begin
		rst =1;
		#10 rst=0;
end

initial begin
	clk = 1;
	forever #5 clk = ~clk;
end

initial begin
	$monitor("%d ", $time,
			"clock = %d ", clk,
			"clear = %d ", rst,	
			"wr_en = %d ", wr_en,
			"read0 add. = %d ", rd0_addr,
			"read1 add. = %d ", rd1_addr,
			"write add. = %d ",wr_addr,
			"write data = %d ", wr_data,
			"read0 = %d ", rd0_data,
			"read1 = %d ", rd1_data
			);

	#10;
	wr_addr =0;
	wr_data=55;

	#10;
	wr_en = 1;
	wr_addr = 1;
	wr_data = 25;

	#10;
	wr_addr = 2;
	wr_data = 30;

	#10;
	wr_addr = 3;
	wr_data = 80;

	#10;
	wr_en=0;
	wr_data =0;
	rd0_addr = 0;
	rd1_addr = 1;

	#10;
	rd0_addr = 2;
	rd1_addr = 3;

	#10 $finish;

end

endmodule