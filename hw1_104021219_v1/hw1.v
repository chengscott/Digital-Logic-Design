// Digital Login Design - HW1 module

`timescale 1ns/10ps

module hw1(x, y, out);
	input x;
	input y;
	output out;
	wire out;
	assign out = (x | y) & ~(x & y); // XOR logic
endmodule // hw1
