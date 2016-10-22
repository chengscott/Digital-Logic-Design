// Digital Logic Design - HW4 testbench
`timescale 1ns/10ps

module hw4_2_test;
reg [3:0] x;
reg [3:0] y;
reg cin;
wire [3:0] sum;
wire cout;

hw4_2 hw(
	.x(x),
	.y(y),
	.cin(cin),
	.sum(sum),
	.cout(cout)
);
// dump to fsdb
initial begin
	$fsdbDumpfile("hw4_part2.fsdb");
	$fsdbDumpvars;
end
// test cases
initial begin
	// initial value
	x = 4'b0000;
	y = 4'b0000;
	cin = 0;
	// wait for global reset if any
	#100
	// test cases
	x = 4'b0000; y = 4'b0000; cin = 0; #20;
	x = 4'b0000; y = 4'b1111; cin = 0; #20;
	x = 4'b1111; y = 4'b0000; cin = 0; #20;
	x = 4'b1010; y = 4'b1010; cin = 0; #20;
	x = 4'b0101; y = 4'b0101; cin = 1; #20;
	x = 4'b0000; y = 4'b1111; cin = 1; #20;
	x = 4'b1111; y = 4'b0000; cin = 1; #20;
	x = 4'b1111; y = 4'b1111; cin = 1; #20;
end
// print results
initial begin
	$monitor($time, " x=%b, y=%b, cin=%b, cout=%b, sum=%b",
		x, y, cin, cout, sum);
end

endmodule
