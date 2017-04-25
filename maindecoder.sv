module maindec(	input logic clk,
		input logic [5:0] op,
		output logic IorD, IRwrite, memwrite, memtoreg,
		output logic branch, pcwrite, regwrite, regdst,
		output logic alusrcA,
		output logic [1:0] alusrcB, aluop, pcsrc);

	logic [3:0] state;
	initial	state = 4'b0000;

	always @(posedge clk)
		case(state)
			4'b0000: //fetch
			begin
				state = 4'b0001;
				assign IorD = 0;
				assign alusrcA = 0;
				assign alusrcB = 2'b01;
				assign aluop = 2'b00;
				assign pcsrc = 2'b00;
				assign IRwrite = 1;
				assign pcwrite = 1;
			end
			4'b0001: //decode
			begin
				assign alusrcA = 0;
				assign alusrcB = 2'b11;
				assign aluop = 2'b00;
				case (op)
					6'b000000: state = 4'b0110; // RTYPE
					6'b100011: state = 4'b0010; // LW
					6'b101011: state = 4'b0010; // SW
					6'b000100: state = 4'b1000; // BEQ
					6'b001000: state = 4'b1001; // ADDI
					6'b000010: state = 4'b1011; // J
					default:   state = 4'bxxxx; // illegal op
				endcase
			end;
			
		endcase
endmodule
