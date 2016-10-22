// Digital Logic Design - HW4 testbench
`timescale 1ns/10ps

module hw4_1_test;
reg [3:0] count;
wire out;

hw4_1 hw(
	.x(count), 
	.out(out)
);
// dump to fsdb
initial begin
	$fsdbDumpfile("hw4_1.fsdb");
	$fsdbDumpvars;
end
// test cases
initial begin
	count = 4'b0000;
	// wait for global reset if any
	#100
	// 4'b0000 ~ 4'b1111
	repeat (4'b1111) begin
		#20
		count = count + 4'b0001;
	end
end
// print vars
initial begin
	$monitor($time, " x=%b, out=%b", count, out);
end

endmodule
