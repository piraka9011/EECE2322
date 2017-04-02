module PcRegister(input clock,
                  input clear,
                  input take_branch,
                  input[7:0] in,
                  output reg[7:0] out);
  // The initial value for the PC register is 0x400000;
  always @(posedge clear, negedge clock)
    if (clear)
      out = 32'h00400000;
    else
      if (take_branch)
        out = out + in[0];
      else
        out = in;
endmodule
