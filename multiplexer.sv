module mux2 	#(parameter WIDTH=8) 
		(input logic [WIDTH-1:0] d0, d1,
		input logic s,
		output logic [WIDTH-1:0] y);

	always_comb
		case(s)
			1'b0: assign y = d0;
			1'b1: assign y = d1;
			default: assign y = 0;
		endcase
endmodule
