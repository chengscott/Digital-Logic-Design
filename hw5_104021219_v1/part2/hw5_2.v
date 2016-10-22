// Digital Login Design - HW5 module

module hw5_2(in, pri, out, zero);
	input	[7:0]	in;
	input	[2:0]	pri;
	output 	[2:0]	out;
	output 	    	zero;

	wire [15:0] inin = {in, in};
	reg [2:0] out;
	reg zero;
	integer i;
	always@* begin
		out = 3'b0;
		for (i = 1; i <= 8; i = i + 1) begin
			if (inin[pri + i] == 1) out = pri + i;
		end
		// indicate whether input is zero
		zero = (in == 8'b0 ? 1'b1 : 1'b0);
	end
	
endmodule
