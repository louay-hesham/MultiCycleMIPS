module alu(input  logic [31:0] a, b,
	input  logic [2:0]  f,
	output logic [31:0] y,
	output logic zero); 

	always_comb
	begin
		case(f)
			0: y = a & b;
			1: y = a | b;
			2: y = a + b;
			3: y = 31'bz;
			4: y = a & ~b;
			5: y = a | ~b;
			6: y = a - b;
			7: begin
				logic [31:0] s;
				s = a - b;
				if (s[31] === 1) y = 1;
				else y = 0;
			   end
			default: y = 31'bz;
		endcase
		zero = (y === 0);
	end
endmodule 
