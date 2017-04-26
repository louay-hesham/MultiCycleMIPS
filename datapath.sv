module datapath (	input logic clk, reset,
			input logic pcEn, IorD, memwrite, IRwrite,
			input logic [31:0] readdata,
			input logic regdst, memtoreg, regwrite,
			input logic alusrcA,
			input logic [1:0] alusrcB, pcsrc,
			input logic [2:0] alucontrol,
			output logic zero.
			output logic [31:0] pc, aluout, writedata);

	logic [31:0] pcnext, aluresult, pcjump;

	//next pc logic
	assign pcjump = {pc[31:28], readdata[25:0], 2'b00};
	flopr #(32)	pcreg(clk, reset, pcnext, pc);
	mux4 #(32)	pcmux(aluresult, aluout, pcjump, 32'bz, pcsrc, pc);

	
endmodule
