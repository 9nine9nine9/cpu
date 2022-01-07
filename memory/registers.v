module dtype(D, clk, Q, Qi);
  input  D, clk;
  output reg Q;
  output Qi;

  assign Qi = ~Q;

  always @(posedge clk)
  begin
    Q <= D;
  end
endmodule

module reg8(set, D, Q);
  input  set;
  input  [7:0] D;
  output [7:0] Q;

  reg [7:0] data;

  assign Q = data;

  always @(posedge set) begin
    data <= D;
  end
endmodule

module reg6(set, D, Q, inc, dec);
  input  set;
  input  [5:0] D;
  output [5:0] Q;
  input  inc, dec;

  reg [5:0] data;

  assign Q = data;

  always @(posedge set) begin
    data <= D;
  end

  always @(posedge inc) begin	// There must be a better way to do this
    data++;
  end

  always @(posedge dec) begin
    data--;
  end
endmodule

module reg36(set, D, Q, inc, dec);
  input  set;
  input  [35:0] D;
  output [35:0] Q;
  input  inc, dec;

  reg [35:0] data = 0;

  assign Q = data;

  always @(posedge set) begin
    data <= D;
  end

  always @(posedge inc) begin	// There must be a better way to do this
    data++;
  end

  always @(posedge dec) begin
    data--;
  end
endmodule

module stack64x36(push, D, drop, top, next);
  input  push;		// Push D if high
  input  [35:0] D;
  input  drop;		// Drops an element from the stack (like pop)
  output [35:0] top, next;	// Always output, stored in registers by control unit

  reg [35:0] stack [0:63];	// 64 elements in the stack (2^6)
  reg [5:0] sp;			// Stack pointer

  assign top  = stack[sp];
  assign next = stack[sp-1];

  always @(posedge push) begin
    stack[sp] = D;
    sp++;
  end

  always @(posedge drop) begin
    sp--;
  end
endmodule
