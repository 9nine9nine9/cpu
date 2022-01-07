`timescale 1ns/1ps
module alu8_tb();
  reg [7:0] a, b;
  reg sub;
  wire [7:0] sum;
  wire cout;

  alu8 dup(
	.a(a),
	.b(b),
	.sub(sub),
	.sum(sum),
	.ovf(ovf));

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0, alu8_tb);
    $display("\t\ttime\ta\tb\tsub\tsum\tovf");
    $monitor("%d\t%d\t%d\t%b\t%d\t%b", $time, a, b, sub, sum, ovf);
  end

  initial begin
    a <= 123;
    b <= 8;
    sub <= 0;
    #10;
    a <= $urandom_range(0,255);
    b <= $urandom_range(0,255);
    sub <= 0;
    #10;
    a <= $urandom_range(0,255);
    b <= $urandom_range(0,255);
    #10;
    a <= $urandom_range(0,255);
    b <= $urandom_range(0,255);
    sub <= 1;
    #10;
    a <= $urandom_range(0,255);
    b <= $urandom_range(0,255);
    #10 $finish;
  end
endmodule
