dtype:
	iverilog -o output registers.v tb_dtype.v
	vvp output

reg8:
	iverilog -o output registers.v tb_reg8.v
	vvp output

reg6:
	iverilog -o output registers.v tb_reg6.v
	vvp output

reg36:
	iverilog -o output registers.v tb_reg36.v
	vvp output

stack:
	iverilog -o output registers.v tb_stack.v
	vvp output

sim:
	sleep 0.25
	gtkwave output.vcd

clean:
	rm -rf *.vcd output
