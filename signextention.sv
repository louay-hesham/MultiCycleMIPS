module signext(	input logic [15:0] a,
		input logic signOrZero,
		output logic [31:0] y);
	assign y = signOrZero? {{16'b0},a} : {{16{a[15]}},a}; 
endmodule

