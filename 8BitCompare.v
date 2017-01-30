module 4BitComparator (a, b, eq, gt, lt);
    input[3:0] a, bl;
    output eq, gt, lt;

    assign eq = (a==b);
    assign gt = (a > b);
    assign lt = (a < b);

endmodule

module 8BitComparator(input [7:0]a,
                      input [7:0]b,
                      output eq,
                      output gt,
                      output lt);
    4BitComparator BC_1(.a([3:0]a ), .b([3:0]b ), .eq(eq ), .gt(gt ), .lt(lt ));
    4BitComparator BC_2(.a([7:4]a ), .b([7:4]b ), .eq(eq ), .gt(gt ), .lt(lt ));
endmodule

module 8BitCompTB;

    // Variables
    reg [7:0] a, b;
    wire eq, gt, lt;

    // Call comaparator
    8BitComparator BC_1(a, b, eq, gt, lt);

    // Test inputs
    initial begin
        $monitor("%d a=%b, b=%b, eq=%b, gt=%b, lt=%b",
                 $time,
                 a, b, eq, gt, lt);
        #10 a = 15;
            b = 15;
        #10 a = 255;
            b = 0;
        #10 a = 74;
            b = 135;
    end

endmodule
