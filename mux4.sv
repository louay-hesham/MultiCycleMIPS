module mux4 	#(parameter WIDTH=8) 
		(input logic [WIDTH-1:0] d0, d1, d2, d3,
		input logic [1:0] s,
		output logic [WIDTH-1:0] y);
	logic [WIDTH-1:0] y0, y1;
	mux2 #(32)	m0( d0, d1, s[0], y0);
	mux2 #(32)	m1( d2, d3, s[0], y1);
	mux2 #(32)	m2( y0, y1, s[1], y);
endmodule
