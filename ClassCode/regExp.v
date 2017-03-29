module RegExp(input clk, 
			  input clr, 
			  input x, 
			  output reg y);
	reg[1:0] state;
	reg[1:0] next;

	// Clear or advance state
	always @(posedge clr, negedge clk)
		if (clr)
			state = 0;
		else
			state = next;

	// Calculate next state
	always @(state, x)
		// Check all possible values for state (truth table)
		case ({state, x})
			3'b000: next = 2'b01;
			3'b001: next = 2'b11;
			3'b010: next = 2'b10;
			3'b011: next = 2'b01;
			3'b100: next = 2'b11;
			3'b101: next = 2'b11;
			3'b110: next = 2'b11;
			3'b111: next = 2'b11;
		endcase

	// Calculate output
	// Implementing Moore FSM which only depends on current state
	always @(state)
		case(state)
			2'b00: y = 1'b0;
			2'b01: y = 1'b0;
			2'b10: y = 1'b1;
			2'b11: y = 1'b0;
		endcase
endmodule