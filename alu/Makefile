halfadder:
	iverilog -o output alu.v tb_halfadder.v
	vvp output

fulladder:
	iverilog -o output alu.v tb_fulladder.v
	vvp output

rca8:
	iverilog -o output alu.v tb_rca8.v
	vvp output

alu8:
	iverilog -o output alu.v tb_alu8.v
	vvp output

alu36:
	iverilog -o output alu.v tb_alu36.v
	vvp output

sim:
	sleep 0.25
	gtkwave output.vcd

clean:
	rm -rf *.vcd output
