// Digital Login Design - HW5 module

module hw5_3(in, pri, out, zero);
	input	[15:0]	in;
	input	[3:0]	pri;
	output 	[3:0]	out;
    output          zero;

	reg [5:0] pripri;
	wire [2:0] out1;
	wire [2:0] out2;
	reg [3:0] out;
	wire zero1, zero2;
	wire zero = zero1 & zero2;
	hw5_2 enc0(.in(in[7:0]), .pri(pripri[2:0]), .out(out1), .zero(zero1));	
	hw5_2 enc1(.in(in[15:8]), .pri(pripri[5:3]), .out(out2), .zero(zero2));
	always@* begin
		if (zero == 1'b1) out = 4'b0;
		else if (pri[3] == 1'b0) begin
			pripri = {3'b111, pri[2:0]};
			if (zero1 == 1'b0 && out1 <= pri) out = {1'b0, out1};
			else if (zero2 == 1'b0) out = {1'b1, out2};
			else out = {1'b0, out1};
		end else begin
			pripri = {pri[2:0], 3'b111};
			if (zero2 == 1'b0 && out2 <= pri) out = {1'b1, out2};
			else if (zero1 == 1'b0) out = {1'b0, out1};
			else out = {1'b1, out2};
		end
	end

endmodule
