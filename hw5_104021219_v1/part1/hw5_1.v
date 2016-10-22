// Digital Login Design - HW5 module

`timescale 1ns/10ps

module hw5_1(in, out);
	input	[5:0]	in;
	output	[63:0]	out;
	
	wire [7:0] out1;
	wire [7:0] out2;
	// two 3:8 decoders pre-decoding
	decoder de1(.in(in[2:0]), .out(out1));
	decoder de2(.in(in[5:3]), .out(out2));
	// assmeble output bitwisely
	wire [63:0] out = {8{out1}} &
		{
			{8{out2[7]}},
			{8{out2[6]}},
			{8{out2[5]}},
			{8{out2[4]}},
			{8{out2[3]}},
			{8{out2[2]}},
			{8{out2[1]}},
			{8{out2[0]}}
		};

endmodule
