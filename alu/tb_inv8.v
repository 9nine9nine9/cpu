`timescale 1ns/1ps
module inv8_tb();
  reg [7:0] a;
  reg i;
  wire [7:0] q;

  inv8 dup(
	.a(a),
	.i(i),
	.q(q));

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0, inv8_tb);
    $display("\t\ttime\ta\ti\tq");
    $monitor("%d\t%d\t%b\t%d", $time, a, i, q);
  end

  initial begin
    a <= $urandom_range(0, 255);
    i <= $urandom_range(0, 1);;
    #10;
    a <= $urandom_range(0, 255);
    i <= $urandom_range(0, 1);
    #10;
    a <= $urandom_range(0, 255);
    i <= $urandom_range(0, 1);
    #10;
    a <= $urandom_range(0, 255);
    i <= $urandom_range(0, 1);
    #10 $finish;
  end
endmodule
