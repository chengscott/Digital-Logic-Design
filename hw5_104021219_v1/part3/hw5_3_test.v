// Digital Login Design - HW5 testbench

`timescale 1ns/100ps

module hw5_3_test;
	
	reg [15:0] in;
	reg [3:0] pri;
	wire [3:0] out;
	wire zero;
	hw5_3 hw(.in(in), .pri(pri), .out(out), .zero(zero));
	// dump to fsdb
	initial begin
		$fsdbDumpfile("hw5_3.fsdb");
		$fsdbDumpvars;
	end
	// test cases
	initial begin
		in = 16'b0000_0000_0000_0000; pri = 1; #20
		in = 16'b0000_0000_0000_0000; pri = 11; #20
        in = 16'b0000_0001_1010_0001; pri = 8; #20
        in = 16'b1000_0001_0000_0000; pri = 9; #20
        in = 16'b0100_0000_0000_0000; pri = 10; #20
		in = 16'b1000_0000_0000_0000; pri = 14; #20
        in = 16'b1001_0010_0110_0100; pri = 2; #20
        in = 16'b1000_0100_0101_0001; pri = 3; #20
        in = 16'b0010_0101_1100_0000; pri = 4; #20
        in = 16'b0000_1010_0100_0000; pri = 5; #20
        in = 16'b0000_0000_1000_0000; pri = 6;
	end
	// print vars
	initial begin
		$monitor("in=%b, pri=%d; out=%d, zero=%b", in, pri, out, zero);
	end
	
endmodule
