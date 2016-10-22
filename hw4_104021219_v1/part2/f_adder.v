module f_adder(in1, in2, cin, sum, cout);
	input in1;
	input in2;
	input cin;
	output sum;
	output cout;
	reg sum, cout;

	always @* begin
		{cout, sum} = in1 + in2 + cin;
	end

endmodule
