/*** FEATURES:
 * Addition
 * Subtraction
 * Negation (if a == 0)
 *** TODO:
 * Shifting
 * Multiplication
 */

module halfadder(a, b, sum, c);
  input  a, b;
  output sum, c;

  assign sum = a ^ b;
  assign c   = a & b;
endmodule

module fulladder(a, b, cin, sum, cout);
  input  a, b, cin;
  output sum, cout;
  wire x, y, z;

  halfadder ha1(.a(a),   .b(b), .sum(x),   .c(y));
  halfadder ha2(.a(cin), .b(x), .sum(sum), .c(z));

  assign cout = y|z;
endmodule

module rca8(a, b, cin, sum, cout);
  input  [7:0] a, b;
  input  cin;
  output [7:0] sum;
  output cout;

  wire [7:0] c;

  fulladder a1(a[0], b[0], cin,  sum[0], c[0]);
  fulladder a2(a[1], b[1], c[0], sum[1], c[1]);
  fulladder a3(a[2], b[2], c[1], sum[2], c[2]);
  fulladder a4(a[3], b[3], c[2], sum[3], c[3]);
  fulladder a5(a[4], b[4], c[3], sum[4], c[4]);
  fulladder a6(a[5], b[5], c[4], sum[5], c[5]);
  fulladder a7(a[6], b[6], c[5], sum[6], c[6]);
  fulladder a8(a[7], b[7], c[6], sum[7], c[7]);
  assign cout = c[7] ^ c[6];
endmodule

module alu8(a, b, sub, sum, ovf, zero);
  input  [7:0] a, b;
  input  sub;
  output [7:0] sum;
  output ovf, zero;

  wire [7:0] x;
  assign x = sub ? ~b : b;

  rca8 add(.a(a), .b(x), .cin(sub), .sum(sum), .cout(ovf));
  assign zero = (sum == 0) ? 1 : 0;
endmodule

module rca6(a, b, cin, sum, cout, ovf);
  input  [5:0] a, b;
  input  cin;
  output [5:0] sum;
  output cout, ovf;

  wire [5:0] c;

  fulladder a1(a[0], b[0], cin,  sum[0], c[0]);
  fulladder a2(a[1], b[1], c[0], sum[1], c[1]);
  fulladder a3(a[2], b[2], c[1], sum[2], c[2]);
  fulladder a4(a[3], b[3], c[2], sum[3], c[3]);
  fulladder a5(a[4], b[4], c[3], sum[4], c[4]);
  fulladder a6(a[5], b[5], c[4], sum[5], c[5]);
  assign cout = c[5];
  assign ovf = c[4] ^ c[5];
endmodule

module csa6blk(a, b, cin, sum, cout, ovf);
  input  [5:0] a, b;
  input  cin;
  output [5:0] sum;
  output cout, ovf;

  wire [5:0] add0, add1;
  wire c0, c1, ovf0, ovf2;
  rca6 rca0(a, b, 1'b0, add0, c0, ovf0);
  rca6 rca1(a, b, 1'b1, add1, c1, ovf1);

  assign sum  = (cin == 0) ? add0 : add1;
  assign cout = (cin == 0) ? c0   : c1;
  assign ovf  = (cin == 0) ? ovf0 : ovf1;
endmodule

module csa6x6(a, b, cin, sum, ovf);	// Carry-select adder (6 blocks of csa6blk)
  input  [35:0] a, b;
  input  cin;
  output [35:0] sum;
  output ovf;

  wire [5:0] c;
  rca6    a1(a[5:0],   b[5:0],   cin,  sum[5:0],   c[0], );	// First can be just rca as there's no previous adder
  csa6blk a2(a[11:6],  b[11:6],  c[0], sum[11:6],  c[1], );	// Last arg blank to ignore the overflow values from intermediary adders
  csa6blk a3(a[17:12], b[17:12], c[1], sum[17:12], c[2], );
  csa6blk a4(a[23:18], b[23:18], c[2], sum[23:18], c[3], );
  csa6blk a5(a[29:24], b[29:24], c[3], sum[29:24], c[4], );
  csa6blk a6(a[35:30], b[35:30], c[4], sum[35:30], c[5], ovf);
endmodule

module alu36(a, b, sub, sum, sign, ovf, zero);
  input  [35:0] a, b;
  input  sub;
  output [35:0] sum;
  output ovf, zero;

  wire [35:0] x;
  assign x = sub ? ~b : b;

  csa6x6 add(.a(a), .b(x), .cin(sub), .sum(sum), .ovf(ovf));
  assign sign = sum[35];
  assign zero = (sum == 0) ? 1'b1 : 1'b0;
endmodule
