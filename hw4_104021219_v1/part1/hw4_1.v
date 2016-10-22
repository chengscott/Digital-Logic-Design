// Digital Logic Design - HW3 module
`timescale 1ns/10ps

module hw4_1(x, out);
input [3:0] x;
output out;
reg out;

always @* begin
	case (x)
		// multiple-of-3
		3, 6, 9: out = 1'b1;
		// input from 0~9
		0, 1, 2, 4, 5, 7, 8: out = 1'b0;
		// otherwise, don't care
		default: out = 1'bx;
	endcase
end

endmodule
