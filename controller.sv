module controller(	input logic clk,
			input logic [5:0] op, funct,
			input logic zero,
			output logic memtoreg, memwrite,
			output logic pcEn, pcsrc, alusrcA,
			output logic [1:0]  alusrcB,
			output logic regdst, regwrite,
			output logic IRwrite, IorD,
			output logic [2:0] alucontrol);

	logic [1:0] aluop;
	logic branch, pcwrite;
	maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, bne, signOrZero, aluop);
	aludec ad(funct, aluop, alucontrol);
	assign pcEn = (branch & zero) | pcwrite;
endmodule