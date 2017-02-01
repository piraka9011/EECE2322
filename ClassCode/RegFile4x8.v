module RegFile4x8(input clock,
				  input clear,
				  input [1:0] read_index1,
				  input [1:0] read_index2,
				  input write,
				  input [1:0] write_index,
				  input [7:0] write_data,
				  output [7:0] read_data1,
				  output [7:0] read_data2 );
    // Create 4 registers, each 8 bits
    reg [7:0] content[3:0];
    // int for for loop
    integer i;

    // Check for changes in the clock or clear only
    // Changes only occur during negative edge of clock or if clear
    // signal is set
    always @(negedge clock, posedge clear)
    	// If clear is set, reset contents or register
    	if (clear)
    		for (i = 0; i < 4; i++)
    			content[i] = 0;
    	// If we want to write, write data into the contents of the register
    	// at the specified index
    	else if (write)
    		content[write_index] = write_data;
endmodule