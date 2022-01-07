module tb_reg8();
  reg set;
  reg [7:0] D;
  wire [7:0] Q;

  reg8 dut(.set(set), .D(D), .Q(Q));

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0,tb_reg8);
    set <= 0;
    D <= 137;
    #100;
    set <= 1;
    #100;
    D <= 101;
    #100;
    D <= 56;
    #100;
    D <= 15;
    #100;
    set <= 0;
    #100;
    D <= 27;
    #100;
    set <= 1;
    #100 $finish;
  end
endmodule
