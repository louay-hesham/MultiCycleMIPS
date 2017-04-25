module maindec(	input logic clk,
		input logic [5:0] op,
		output logic IorD, IRwrite, memwrite, memtoreg,
		output logic branch, pcwrite, regwrite, regdst,
		output logic alusrcA,
		output logic [1:0] alusrcB, aluop, pcsrc);

	logic [2:0] state;
	initial	state = 3b'000;

	always_comb
		case(state)
			3'b000:
			begin
				state = 3'b001;
				assign IorD = 0;
				assign alusrcA = 0;
				assign alusrcB = 2'b01;
				assign aluop = 2'b00;
				assign pcsrc = 2'b00;
				assign IRwrite = 1;
				assign pcwrite = 1;
			end
			3'b001:
			begin

			end;
			3'b010:
			3'b011:
			3'b100:
		endcase
endmodule
