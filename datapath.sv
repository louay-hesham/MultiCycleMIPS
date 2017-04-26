module datapath (	input logic clk, reset,
			input logic pcEn, IorD, memwrite, IRwrite,
			input logic [31:0] readdata,
			input logic regdst, memtoreg, regwrite,
			input logic alusrcA,
			input logic [1:0] alusrcB, pcsrc,
			input logic [2:0] alucontrol,
			output logic zero.
			output logic [31:0] pc, aluout, writedata, dataadr);

	logic [31:0] pcnext, aluresult, pcjump, instr, data;
	logic [31:0] rd1, rd2, regA, regB;
	logic [31:0] srcA, srcB;
	logic [31:0] signimm, signimmsh;

	//next pc logic
	assign pcjump = {pc[31:28], readdata[25:0], 2'b00};
	flopr #(32)	pcreg(clk, reset, pcnext, pc);
	mux4 #(32)	pcmux(aluresult, aluout, pcjump, 32'bz, pcsrc, pc);

	// instruction or data mux
	mux2 #(32)	dataadrmux(pc, aluout, IorD, dataadr);

	
	flopr #(32)	instreg(clk, reset, readdata, instr);
	flopr #(32)	datareg(clk, reset, readdata, data);

	//register file logic
	regfile 	rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, rd1, rd2); 
	mux2 #(5) 	wrmux(instr[20:16], instr[15:11], regdst, writereg);
	mux2 #(32) 	resmux(aluout, data, memtoreg, result);

	flopr #(32)	regAff(clk, reset, rd1, regA);
	flopr #(32)	regBff(clk, reset, rd2, regB);

	//alu source A logic
	mux2 #(32) 	alusrcAmux(pc, regA, alusrcA, srcA);

	//alu source B logic
	signext 	se(instr[15:0], signimm);
	sl2 		immsh(signimm, signimmsh);
	mux4 #(32)	alusrcBmux(regB, 32'b100, signimm, signimmsh, alusrcB, srcB);

	//alu logic
	alu 		alu(srca, srcb, alucontrol, aluresult, zero);
	flopr #(32)	aluresultreg(clk, reset, aluresult, aluout);
	
endmodule
