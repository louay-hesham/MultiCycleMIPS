module controller(	input logic clk, reset,
			input logic [5:0] op, funct,
			input logic zero,
			output logic IorD, IRwrite, memwrite, memtoreg,
			output logic pcEn, regwrite, regdst,
			output logic [2:0] alucontrol,
			output logic [1:0] pcsrc, alusrcB,
			output logic alusrcA);

	logic [1:0] aluop;
	logic branch, pcwrite;

	maindec md(	clk, reset, op,
			IorD, IRwrite, memwrite, memtoreg,
			branch, pcwrite, regwrite, regdst,
			alusrcA, alusrcB, aluop, pcsrc);

	aludec ad(funct, aluop, alucontrol);

	assign pcEn = (branch & zero) | pcwrite;
endmodule
