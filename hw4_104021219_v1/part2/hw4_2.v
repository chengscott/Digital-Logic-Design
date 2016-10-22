// Digital Logic Design - HW4 module
`timescale 1ns/10ps

module hw4_2(x, y, cin, sum, cout);
	input [3:0] x;
	input [3:0] y;
	input cin;
	output [3:0] sum;
	output cout;
	// c is for carry
	wire [3:0] c;

	f_adder adder0(
		.in1(x[0]),
		.in2(y[0]),
		.cin(cin),
		.sum(sum[0]),
		.cout(c[1])
	);
	f_adder adder1(
		.in1(x[1]),
		.in2(y[1]),
		.cin(c[1]),
		.sum(sum[1]),
		.cout(c[2])
	);
	f_adder adder2(
		.in1(x[2]),
		.in2(y[2]),
		.cin(c[2]),
		.sum(sum[2]),
		.cout(c[3])
	);
	f_adder adder3(
		.in1(x[3]),
		.in2(y[3]),
		.cin(c[3]),
		.sum(sum[3]),
		.cout(cout)
	);

endmodule
