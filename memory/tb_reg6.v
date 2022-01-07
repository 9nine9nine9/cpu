module tb_reg6();
  reg set;
  reg [5:0] D;
  wire [5:0] Q;
  reg inc, dec;

  reg6 dut(.set(set), .D(D), .Q(Q), .inc(inc), .dec(dec));

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0,tb_reg6);
    set <= 0;
    inc <= 0;
    dec <= 0;
    D <= 61;
    #100;
    set <= 1;
    #100;
    D <= 27;
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
    #100
    set <=0;
    #100
    inc <= 1;
    #100
    inc <= 0;
    dec <= 1;
    #100 $finish;
  end
endmodule
