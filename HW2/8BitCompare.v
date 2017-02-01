module FourBitComparator (input [3:0]a,
                          input [3:0]b,
                          output eq,  // Equals
                          output gt,  // Greater than
                          output lt); // Less than
    // Simple dataflow model assignment to the outputs
    // of the 4Bit comparator
    assign eq = a == b;
    assign gt = a > b;
    assign lt = a < b;
endmodule

module EightBitComparator(input [7:0]a,
                          input [7:0]b,
                          output eq,
                          output gt,
                          output lt);
    // Create temp outputs to get lt/gt/eq for 4 MSB & LSB
    wire lt_1, lt_2;
    wire gt_1, gt_2;
    wire eq_1, eq_2;
    wire andlt_out, andgt_out;

    // Call 4Bit comparator modules, one for each 4 MSBs/LSBs
    FourBitComparator BC_1( a[7:4], b[7:4], eq_1, gt_1, lt_1);
    FourBitComparator BC_2( a[3:0], b[3:0], eq_2, gt_2, lt_2);

    // Check to make sure that the 4 LSBs match their corresponding output.
    // So if the first 4 MSBs are found to be less than, check to make sure
    // the 4 LSBs are also less than. Otherwise we can have a less than and
    // greater than signal at the same time.
    and andlt2(andlt_out, lt_2, eq_1);
    and andgt2(andgt_out, gt_2, eq_1);

    // Get lt/gt/eq final outputs
    or or1(lt, lt_1, andlt2);
    or or2(gt, gt_1, andgt2);
    and and_eq(eq, eq_1, eq_2);
endmodule

module EightBitCompTB;
    // Variables
    // Numbers to compare
    reg [7:0] a, b;
    // Outputs
    wire eq, gt, lt;

    // Call comaparator
    EightBitComparator BC_1(a, b, eq, gt, lt);

    // Test inputs
    initial begin
        $monitor("%d a=%b, b=%b, eq=%b, gt=%b, lt=%b",
                 $time,
                 a, b, eq, gt, lt);
        #10
        a = 15;
        b = 15;
        #10
        a = 255;
        b = 0;
        #10
        a = 50;
        b = 75;
        #10
        a = 5;
        b = 5;
    end
endmodule
