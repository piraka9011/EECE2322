module FourBitComparator (input [3:0]a, 
                          input [3:0]b, 
                          output eq, 
                          output gt, 
                          output lt);
    assign eq = a == b;
    assign gt = a > b;
    assign lt = a < b;

endmodule

module EightBitComparator(input [7:0]a,
                          input [7:0]b,
                          output eq,
                          output gt,
                          output lt);
    wire [3:0]a1;
    wire [3:0]a2;
    wire [3:0]b1;
    wire [3:0]b2;
    assign a1 = {a[3:0]};
    assign a2 = {a[7:4]};
    assign b1 = {b[3:0]};
    assign b2 = {b[7:4]};
    wire lt_1, lt_2;
    wire gt_1, gt_2;
    wire eq_1, eq_2;
    FourBitComparator BC_2( a2, b2, eq_1, gt_1, lt_1);
    FourBitComparator BC_1( a1, b1, eq_2, gt_2, lt_2);
    or or1(lt, lt_1, lt_2);
    or or2(gt, gt_1, gt_2);
    or or3(eq, eq_1, eq_2);
endmodule

module EightBitCompTB;

    // Variables
    reg [7:0] a, b;
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
