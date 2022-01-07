`timescale 1ns/1ps
module rca8_tb();
  reg [7:0] a, b;
  reg cin;
  wire [7:0] sum;
  wire cout;

  rca8 dup(
	.a(a),
	.b(b),
	.cin(cin),
	.sum(sum),
	.cout(cout));

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0, rca8_tb);
    $display("\t\ttime\ta\tb\tcin\tsum\tcout");
    $monitor("%d\t%d\t%d\t%b\t%d\t%b", $time, a, b, cin, sum, cout);
  end

  initial begin
    a <= $urandom_range(0,255);
    b <= $urandom_range(0,255);
    cin <= 0;
    #10;
    a <= $urandom_range(0,255);
    b <= $urandom_range(0,255);
    #10;
    a <= $urandom_range(0,255);
    b <= $urandom_range(0,255);
    cin <= 1;
    #10;
    a <= $urandom_range(0,255);
    b <= $urandom_range(0,255);
    #10 $finish;
  end
endmodule
