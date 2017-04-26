module mips(	input logic clk, reset,
		output logic [31:0] pc,
		input logic [31:0]instr, 
		output logic memwrite, 
		output logic [31:0] aluout, writedata, dataadr, 
		input logic [31:0] readdata);

	logic IorD, IRwrite, memtoreg, pcEn, regwrite, regdst;
	logic [2:0] alucontrol;
	logic [1:0] pcsrc, alusrcB;
	logic alusrcA, zero;

	controller c(	clk, reset, instr[31:26], instr[5:0], zero, 
			IorD, IRwrite, memwrite, memtoreg,
			pcEn, regwrite, regdst,
			alucontrol, pcsrc,
			alusrcB, alusrcA);

	datapath dp(	clk, reset,
			pcEn, IorD, memwrite, IRwrite,
			readdata,
			regdst, memtoreg, regwrite,
			alusrcA, 
			alusrcB, pcsrc,
			alucontrol,
			zero,
			pc, aluout, writedata, dataadr);

endmodule

