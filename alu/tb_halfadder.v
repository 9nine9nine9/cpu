`timescale 1ns/1ps
module halfadder_tb();
  reg a, b;
  wire sum, c;

  halfadder dup(
	.a(a),
	.b(b),
	.sum(sum),
	.c(c));

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0, halfadder_tb);
    $display("\t\ttime\ta\tb\tsum\tc");
    $monitor("%d\t%b\t%b\t%b\t%b", $time, a, b, sum, c);
  end

  initial begin
    a <= 0;
    b <= 0;
    #10;
    a <= 1;
    #10;
    a <= 0;
    b <= 1;
    #10;
    a <= 1;
    #10 $finish;
  end
endmodule
