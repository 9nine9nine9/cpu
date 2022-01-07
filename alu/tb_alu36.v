`timescale 1ns/1ps
module tb_alu36();
  reg [35:0] a, b;
  reg sub;
  wire [35:0] sum;
  wire sign, ovf, zero;

  alu36 dup(
	.a(a),
	.b(b),
	.sub(sub),
	.sum(sum),
	.sign(sign),
	.ovf(ovf),
	.zero(zero));

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0, tb_alu36);
    $display("\t\ttime\t\ta\t\tb\tsub\t\tsum\tsign\tovf\tzero");
    $monitor("%d\t%d\t%d\t%b\t%d\t%b\t%b\t%b", $time, a, b, sub, sum, sign, ovf, zero);
  end

  integer seed=36;
  initial begin
    a <= $urandom(seed)*16 + $urandom(seed)%16;	// Random 36bit int (Max by default is 32bit)
    b <= $urandom(seed)*16 + $urandom(seed)%16;
    sub <= 0;
    #10;
    a <= $urandom(seed)*16 + $urandom(seed)%16;
    b <= $urandom(seed)*16 + $urandom(seed)%16;
    sub <= 0;
    #10;
    a <= $urandom(seed)*16 + $urandom(seed)%16;
    b <= $urandom(seed)*16 + $urandom(seed)%16;
    #10;
    a <= $urandom(seed)*16 + $urandom(seed)%16;
    b <= $urandom(seed)*16 + $urandom(seed)%16;
    sub <= 1;
    #10;
    a <= $urandom(seed)*16 + $urandom(seed)%16;
    b <= $urandom(seed)*16 + $urandom(seed)%16;
    #10;
    a <= 49;
    b <= 49;
    #10 $finish;
  end
endmodule
