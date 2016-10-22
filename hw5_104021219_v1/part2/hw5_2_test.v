// Digital Login Design - HW5 testbench

`timescale 1ns/100ps

module hw5_2_test;
	
	reg [7:0] in;
	reg [2:0] pri;
	wire [2:0] out;
	wire zero;
	hw5_2 hw(.in(in), .pri(pri), .out(out), .zero(zero));
	// dump to fsdb
	initial begin
		$fsdbDumpfile("hw5_2.fsdb");
		$fsdbDumpvars;
	end
	// test cases
	initial begin
		in = 8'b00000000; pri = 3; #20
        in = 8'b01110000; pri = 4; #20
        in = 8'b10010110; pri = 5; #20
        in = 8'b10000000; pri = 6; #20
        in = 8'b10110001; pri = 2; #20
        in = 8'b10000100; pri = 8;
	end
	// print vars
	initial begin
		$monitor("in=%b, pri=%d; out=%d, zero=%b", in, pri, out, zero);
	end
	
endmodule
