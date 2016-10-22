// Digital Login Design - HW5 testbench

`timescale 1ns/10ps

module hw5_1_test;

	reg [5:0] count;
	wire [63:0] out;
	hw5_1 hw(count[5:0], out);
	// dump to fsdb
	initial begin
		$fsdbDumpfile("hw5_1.fsdb");
		$fsdbDumpvars;
	end
	// test cases
	initial begin
		count = 0;
		repeat (64) begin
			#100
			$display("in = %d, out = %b", count, out);
			count = count + 1;
		end
	end
	
endmodule
