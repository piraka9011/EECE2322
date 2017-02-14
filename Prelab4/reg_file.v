`include "eightbit_alu.v"
module Mux8Bit2to1(input [7:0]x1,
									 input [7:0]x2,
				   				 input s,
				   		 		 output [7:0]y);
	assign y = s ? x1 : x2;
endmodule

module reg_file(input rst,
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
				for(i=0; i<4; i=i+1)
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
	// Reg file IO
	reg clk, rst, wr_en;
	reg [1:0] rd1_addr, rd0_addr, wr_addr;
	reg [8:0] wr_data;
	wire [8:0] rd0_data, rd1_data;

	// MUX IO
	reg [7:0] instr_i;
	reg ALUSrc2, ALUSrc1;
	reg [2:0] ALUOp;
	wire [7:0] mux_out1, mux_out2;

	// ALU IO
	reg [7:0] a, b;
	wire [7:0] f;
	wire ovf, take_branch;
	reg_file uut(rst, clk, wr_en, rd0_addr, rd1_addr,
							 wr_addr, wr_data, rd0_data, rd1_data);
  Mux8Bit2to1 mux_uut1(.x1(rd0_data[7:0]), .x2(8'b00000000), .s(ALUSrc1), .y(mux_out1));
	Mux8Bit2to1 mux_uut2(.x1(rd1_data[7:0]), .x2(instr_i), .s(ALUSrc2), .y(mux_out2));
	EightbitALU alu_uut(.a(mux_out1), .b(mux_out2), .s(ALUOp),
											.f(f), .ovf(ovf), .take_branch(take_branch) );

	initial begin
			rst = 1;
			#10
			rst = 0;
	end

	initial begin
		clk = 1;
		forever #5
		clk = ~clk;
	end

	initial begin
		$monitor("%d ", $time,
				"clock=%d ", clk,
				"clear=%d ", rst,
				"wr_en=%d ", wr_en,
				"rd0_addr=%d ", rd0_addr,
				"rd1_addr=%d ", rd1_addr,
				"wr_addr=%d ",wr_addr,
				"wr_data=%d ", wr_data,
				"rd0_data=%d ", rd0_data,
				"rd1_data=%d ", rd1_data,
				"f=%d", f,
				);

		/// Writing values to register file
		#10;
		wr_addr = 2'b00;
		wr_data = 55;
		rd0_addr = 2'b00;
		rd1_addr = 2'b01;

		#10;	// Enable Write
		wr_en = 1'b1;
		wr_addr = 2'b00;	// Address 0
		wr_data = 9'b101010101;

		#10;
		wr_addr = 2'b01;	// Address 1
		wr_data = 9'b010101010;

		#10;
		wr_addr = 2'b10;	// Address 2
		wr_data = 40;

		#10
		wr_addr = 2'b11;	// Address 3
		wr_data = 50;

		/// Different MUX configurations
		#10;	// Disable write
		wr_en = 1'b0;
		wr_data = 0;
		ALUSrc1 = 1'b1;
		ALUSrc2 = 1'b1;
		ALUOp = 3'b000;			// Add
		rd0_addr = 2'b00;		// Read address 0
		rd1_addr = 2'b01;		// Read Address 1

		#10
		rd0_addr = 2'b01;
		rd1_addr = 2'b00;

		#10
		rd0_addr = 2'b11;
		rd1_addr = 2'b00;

		#10;
		ALUSrc1 = 1'b0;		// 0
		ALUSrc2 = 1'b0;		// 01010101
		ALUOp = 3'b001;		// Sub
		instr_i = 8'b01010101;
		rd0_addr = 2'b10;
		rd1_addr = 2'b11;

		#10
		ALUSrc1 = 1'b1;
		ALUSrc2 = 1'b1;
		ALUOp = 3'b010;

		#10
		$finish;
	end
endmodule
