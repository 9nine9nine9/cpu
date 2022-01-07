module cpu(clk)
  input clk;

  /* REGISTERS */
  reg [35:0] ig;	// Instruction Group -- holds the current group of instructions
  reg [5 :0] ci;	// Current Instruction -- taken from ig.
  reg [35:0] top;	// Top two items on the stack
  reg [35:0] next;
  reg [5 :0] pc;	// Main Program Counter -- points to next group of instructions from ROM
  reg [3 :0] gc;	// Group Counter -- points to next instruction in ig (caps at 5, so higher vals unused)
  reg [2 :0] upc;	// Micro-Instruction Counter (8 total values)
  reg [5 :0] dsp;	// Data stack pointer -- these stacks grow upwards!!
  reg [5 :0] rsp;	// Return stack pointer
  reg [35:0] lr;	// Loop register - used for conditional loops

  reg [35:0] temp;	// Temp register for dup etc

  /* FLAGS */
  reg hlt = 0;		// Stop execution if high.
  reg ovf = 0;		// High if result of last ALU op overflowed
  reg zero = 0;		// High if result of last ALU op was zero
  reg ngv = 0;		// High if result of last ALU op was negative
  reg stkovf = 0;	// High if stack overflowed. Brings hlt high as well
  reg stkunf = 0;	// High if stack underflowed. Brings hlt high as well

  /* MEMORY/STACKS */
  reg [35:0] ram [0:63]	// RAM for general use/variables etc
  reg [35:0] rom [0:63]	// Program ROM
  reg [35:0] ds  [0:63]	// Data stack (holds literals)
  reg [35:0] rs  [0:63]	// Return stack (holds return addresses - although the user can push to and from ds)

  initial begin
    pc  <= 0;		// Point program counters to the beginning of memory
    gc  <= 0;
    upc <= 0;
    ds  <= 0;
    rs  <= 0;
  end

  assign hlt = stkovf | stkunf	// Over/underflowing the stack causes execution to halt
  assign ci = ig[gc];
  assign top = ds[dsp];
  assign next = ds[dsp-1];

  task automatic push;
    input [35:0] data;
    begin
      dsp++;
      ds[dsp] = data;
    end
  endtask

  task automatic drop;
    begin
      ds[dsp] = data;
      dsp--;
    end
  endtask

  task automatic rpush;
    input [35:0] data;
    begin
      rsp++;
      rs[rsp] = data;
    end
  endtask

  task automatic rdrop;
    begin
      rs[rsp] = data;
      rsp--;
    end
  endtask

  task automatic jump;	// Could cut out the stack and call with argument
    begin
      pc = top [5:0];

      drop();
      upc = 0;
    end
  endtask

  always @(clk) begin
  if hlt;
  else begin
    case (upc)
      0: ig <= rom[pc];	// Fetch
	 gc = 0;
      1: pc++;

      2, 3, 4, 5, 6, 7: case (ci)
	  6'b000001:	// Push
	    push(rom[pc]);
	    pc++;
	    upc = 0;

	  6'b000010:	// >r
	    rpush(pop());
	    gc++;

	  6'b000011:	// r>
	    push(rpop());
	    gc++;

	  6'b000100:	// dup
	    temp = pop();
	    push(temp);
	    push(temp);
	    gc++;

	  6'b001000:	// add
	    // setup alu!

	  6'b001001:	// sub
	    // setup alu!

	  6'b110000:	// j
            jump();

	  6'b110001:	// jz
	    if (zero) begin
	      zero = 0;
	      jump();
	    end

	  6'b110010:	// jo
	    if (ovf) begin
	      ovf = 0;
	      jump();
	    end

	  6'b110010:	// jn
	    if (ngv) begin
	      ngv = 0;
	      jump();
	    end

	  6'b110100:	// c
	    rpush(pc);
	    jump();

	  6'b110101:	// cz
	    if (zero)
	      zero = 0;
	      rpush(pc);
	      jump();
	    end

	  6'b110101:	// co
	    if (ovf)
	      ovf = 0;
	      rpush(pc);
	      jump();
	    end

	  6'b110101:	// cn
	    if (ngv)
	      ngv = 0;
	      rpush(pc);
	      jump();
	    end

	  6'b111110:	// ret
	    rpop();
	    jump();

	  default: gc++;	// Default to nop
	endcase

      default: $display("Invalid state for upc: %d\n", upc);
    endcase

    upc++;
    if (gc == 6) begin
      upc = 0;
    end
  end
  end
endmodule
