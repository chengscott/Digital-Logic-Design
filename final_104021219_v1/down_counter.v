module Down_counter #(parameter data_width = 4) (
  output reg [data_width - 1:0] count,
  output reg Done,
  input wire Load,
  input wire [data_width - 1:0] Preset,
  input wire Enable,
  input wire CLK,
  input wire RST_N
);

always @(posedge CLK or negedge RST_N) begin
  if (RST_N == 1'b0) begin
    count = 0;
  end else if (Load == 1'b1) begin
    count = Preset;
  end else if (Enable == 1'b1) begin
    if (count != 0) begin
      count = count - 1;
    end 
  end
end

always @* begin
  Done = (count == 0) ? 1'b1 : 1'b0;
end

endmodule
