module top(	input logic clk, reset, 
		output logic [31:0] writedata, dataadr,
		output logic memwrite);
	logic [31:0] pc, readdata;	
	// instantiate processor and memory
	mips mips(clk, reset, pc, memwrite, writedata, dataadr, readdata);
	mem memory(clk, memwrite, dataadr, writedata, readdata);
endmodule

