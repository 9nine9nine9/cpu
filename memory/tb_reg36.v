module tb_reg36();
  reg set;
  reg [35:0] D;
  wire [35:0] Q;
  reg inc, dec;

  reg36 dut(.set(set), .D(D), .Q(Q), .inc(inc), .dec(dec));

  integer seed = 36;
  initial begin
    $dumpfile("output.vcd");
    $dumpvars(0,tb_reg36);
    set <= 0;
    inc <= 0;
    dec <= 0;
    D <= $urandom(seed)*16 + $urandom(seed)%16;
    #100;
    set <= 1;
    #100;
    D <= $urandom(seed)*16 + $urandom(seed)%16;
    #100;
    D <= $urandom(seed)*16 + $urandom(seed)%16;
    #100;
    D <= $urandom(seed)*16 + $urandom(seed)%16;
    #100;
    set <= 0;
    #100;
    D <= $urandom(seed)*16 + $urandom(seed)%16;
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
