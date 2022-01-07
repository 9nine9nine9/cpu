module tb_stack64x36();
  reg  push;
  reg  [35:0] D;
  reg  drop;
  wire [35:0] top, next;

  stack64x36 dut(.push(push), .D(D), .drop(drop), .top(top), .next(next));

  initial begin
    $display("\t\ttime\tpush\t\tD\tdrop\t\ttop\t\tnext");
    $monitor("%d\t%b\t%d\t%b\t%d\t%d", $time, push, D, drop, top, next);
  end

  initial begin
    //$dumpfile("output.vcd");
    //$dumpvars(0,"tb_stack64x36");
    push <= 0;
    drop <= 0;
    D <= 16;
    #10
    push <= 1;
    #1
    push <=0;
    D <= 137;
    #10
    push <= 1;
    #1
    push <= 0;
    D <= 3;
    #10
    push <= 1;
    #1
    push <= 0;
    #10;
    drop <= 1;
    #1;
    drop <= 0;
    #10 $finish;
  end
endmodule
