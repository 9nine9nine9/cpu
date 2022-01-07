`timescale 1ns/1ps
module fulladder_tb();
  reg a, b, cin;
  wire sum, cout;

  fulladder dup(
	.a(a),
	.b(b),
	.cin(cin),
	.sum(sum),
	.cout(cout));

  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0, fulladder_tb);
    $display("\t\ttime\ta\tb\tcin\tsum\tcout");
    $monitor("%d\t%b\t%b\t%b\t%b\t%b", $time, a, b, cin, sum, cout);
  end

  initial begin
    a <= 0;
    b <= 0;
    cin <= 0;
    #10;
    a <= 1;
    #10;
    a <= 0;
    b <= 1;
    #10;
    a <= 1;
    #10;

    a <= 0;
    b <= 0;
    cin <= 1;
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
