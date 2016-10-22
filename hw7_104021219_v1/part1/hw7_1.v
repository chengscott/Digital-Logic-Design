// Your Mealy model of FSM k
module fsm_k_mealy (
  output reg ds,
  output reg rd,
  input wire go,
  input wire ws,
  input wire clk,
  input wire rst_n
);
  parameter [1:0] IDLE = 2'b00,
                  READ = 2'b01,
                  DLY = 2'b10,
                  DONE = 2'b11;
  reg [1:0] state, next;
  reg rd_next, ds_next;

  // Sequential part with positive clock edge triggered and
  // negative edge reset
  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
      state <= IDLE;
    end else begin
      state <= next;
      ds <= ds_next;
      rd <= rd_next;
    end
  end

  // Combinational part with state transition and output
  always @* begin
    // Default assignment
    next = IDLE;
    ds_next = 1'b0;
    rd_next = 1'b0;

    // Case for state transition and output assignment
    case (state)
      IDLE: begin
        if (go) rd_next = 1'b1;
		next = go ? READ : IDLE;
      end
      READ: begin
        rd_next = 1'b1;
        next = DLY;
      end
      DLY: begin
        if (ws) begin
			next = READ;
			rd_next = 1'b1;
        end else begin
			next = DONE;
			ds_next = 1'b1;
		end
      end
      DONE:
        next = IDLE;
    endcase
  end
endmodule

// Moore model of FSM k
module fsm_k_moore2 (
  output reg ds,
  output reg rd,
  input wire go,
  input wire ws,
  input wire clk,
  input wire rst_n
);
  // State encoding
  parameter [1:0] IDLE = 2'b00,
                  READ = 2'b01,
                  DLY = 2'b10,
                  DONE = 2'b11;

  // Registers of state and next state 
  reg [1:0] state, next;

  // Sequential part with positive clock edge triggered and
  // negative edge reset
  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
      state <= IDLE;
    end else begin
      state <= next;
    end
  end

  // Combinational part with state transition and output
  always @* begin
    // Default assignment
    next = IDLE;
    ds = 1'b0;
    rd = 1'b0;

    // Case for state transition and output assignment
    case (state)
      IDLE: begin
        if (go) next = READ;
        else next = IDLE;
      end
      READ: begin
        rd = 1'b1;
        next = DLY;
      end
      DLY: begin
        rd = 1'b1;
        if (ws) next = READ;
        else next = DONE;
      end
      DONE: begin
        ds = 1'b1;
        next = IDLE;
      end
    endcase
  end
endmodule
