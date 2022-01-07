module tb_dtype();
  reg D;
  reg clk;
  wire Q;
  wire Qi;

  dtype dut(.D(D), .clk(clk), .Q(Q), .Qi(Qi));

  initial begin
    clk = 0;
      forever #10 clk = ~clk;
  end

  initial begin
    $display("\t\ttime\tclk\tD\tQ\tQi");
    $monitor("%d\t%b\t%b\t%b\t%b", $time, clk, D, Q, Qi);
  end

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0,tb_dtype);
    D <= 0;
    #100;
    D <= 1;
    #100;
    D <= 0;
    #100;
    D <= 1;
    #100;
    D <= 0;
    #100;
    D <= 1;
    #100;
    D <= 0;
    #100;
    D <= 1;
    #100 $finish;
  end
endmodule
