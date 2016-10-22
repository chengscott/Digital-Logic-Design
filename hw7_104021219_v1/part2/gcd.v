module GCD (
  input wire CLK,
  input wire RST_N,
  input wire [7:0] A,
  input wire [7:0] B,
  input wire START,
  output reg [7:0] Y,
  output reg DONE,
  output reg ERROR
);

  reg found, swap;
  reg [7:0] reg_a, reg_b, data_a, data_b;
  reg [7:0] diff;
  reg error_next;
  reg [1:0] state, state_next;

  parameter [1:0] IDLE = 2'b00;
  parameter [1:0] CALC = 2'b01;
  parameter [1:0] FINISH = 2'b10;

  always @(posedge CLK or negedge RST_N) begin
    if (RST_N == 1'b0) begin
      data_a <= 7'b0;
      data_b <= 7'b0;
      found <= 1'b0;
      ERROR <= 1'b0;
      DONE <= 1'b0;
      Y <= 7'b0;
      error_next <= 1'b0;
      state <= IDLE;
    end else begin
      state <= state_next;
      ERROR <= error_next;
    end
  end

  always @(posedge CLK) begin
    if (found) Y = data_a;
    reg_a = START ? A : diff;
    reg_b = START ? B : data_b;
    swap = reg_b > reg_a;
    data_a = swap ? reg_b : reg_a;
    data_b = swap ? reg_a : reg_b;
    diff = data_a - data_b;
    found = (state == CALC) && ((reg_a == reg_b) || (A == B)) && (error_next == 0);
  end

  always @* begin
    DONE = 1'b0;
    state_next = IDLE;
    error_next = 1'b0;

    case (state)
      IDLE: begin
        if (START) begin
          state_next = CALC;
          error_next = (A == 0 || B == 0);
          reg_a = A;
          reg_b = B;
        end
      end
      CALC: begin
        state_next = ((found || ERROR) ? FINISH : CALC);
        error_next = ERROR;
      end
      FINISH: begin
        DONE = 1'b1;
        state_next = IDLE;
        error_next = 1'b0;
      end
    endcase
  end

endmodule
