module priority_encoder #(
  parameter N = 8,
  parameter M = 3
) (
  output reg [M - 1:0] out,
  output reg zero,
  input wire [N - 1:0] in,
  input wire [M - 1:0] pri,
  input wire direction
);
wire [2*N - 1:0] inin = {in, in};
integer i;

always @* begin
	out = 0;
    if (direction == 1'b1) begin
      for (i = N - 1; i >= 0; i = i - 1) begin
        if (inin[pri + i] == 1'b1) out = pri + i;
      end
    end else begin
      for (i = 1; i <= N; i = i + 1) begin
        if (inin[pri + i] == 1'b1) out = pri + i;
      end
    end
	zero = (in == 0 ? 1'b1 : 1'b0);
end
	
endmodule
