// N floors, M = [lg N] for encoding
// Floor_cyc, Door,cyc < 2^Cyc_width
module elevator_controller #(
  parameter N = 4,
  parameter M = 2,
  parameter Floor_cyc = 12,
  parameter Door_cyc = 5,
  parameter Cyc_width = 4
) (
  input wire CLK,
  input wire RST_N,
  input wire Emergency,
  input wire Open,
  input wire Close,
  input wire Door_hold,
  input wire [N - 1:0] F,
  input wire [N - 2:0] U,
  input wire [N - 2:0] D,
  output reg [M - 1:0] Floor,
  output reg [1:0] Direction,
  output reg Door_open,
  output reg [N - 1:0] F_led,
  output reg [N - 2:0] U_led,
  output reg [N - 2:0] D_led
);
// I/O
reg DH;
reg [N - 1:0] n_dec_floor;
reg direction_pre = 1'b1;
// next state
reg [M - 1:0] floor_next;
reg [1:0] direction_next;
reg door_open_next;
reg [N - 1:0] F_led_next;
reg [N - 2:0] U_led_next;
reg [N - 2:0] D_led_next;
// floor counter
reg fcnt_load;
reg fcnt_enable;
wire [Cyc_width - 1:0] fcnt_count;
Down_counter #(Cyc_width) floor_counter(
  .Load(fcnt_load),
  .Preset(Floor_cyc),
  .Enable(fcnt_enable),
  .CLK(CLK),
  .RST_N(RST_N),
  .count(fcnt_count),
  .Done(fcnt_done)
);
// door counter
reg dcnt_load;
reg dcnt_enable;
wire [Cyc_width - 1:0] dcnt_count;
Down_counter #(Cyc_width) door_counter(
  .Load(dcnt_load),
  .Preset(Door_cyc),
  .Enable(dcnt_enable),
  .CLK(CLK),
  .RST_N(RST_N),
  .count(dcnt_count),
  .Done(dcnt_done)
);
// next direction priority encoder
wire [M - 1:0] Fud_floor;
priority_encoder #(N, M) nextdir_arb(
  .in(F_led | {1'b0, U_led} | {D_led, 1'b0}),
  .pri(Floor),
  .direction(direction_pre),
  .out(Fud_floor),
  .zero(Fud_zero)
);

always @(posedge CLK or negedge RST_N) begin
  if (~RST_N) begin
    // reset
    Floor = 0;
    Direction = 2'b0;
    Door_open = 1'b0;
    F_led = 0;
    U_led = 0;
    D_led = 0;
    DH = 1'b0;
    n_dec_floor = ~1;
    direction_pre = 1'b1;
    floor_next = 1;
    direction_next = 2'b0;
    door_open_next = 1'b0;
    F_led_next = 0;
    U_led_next = 0;
    D_led_next = 0;
    fcnt_load = 1'b0;
    fcnt_enable = 1'b0;
    dcnt_load = 1'b0;
    dcnt_enable = 1'b0;
  end else begin
    // next state
    Floor = floor_next;
    Direction = direction_next;
    Door_open = door_open_next;
    F_led = F_led_next;
    U_led = U_led_next;
    D_led = D_led_next;
  end
end

always @* begin
  DH = Door_hold ? ~DH : DH;
  n_dec_floor = ~(1 << Floor);
  floor_next = Floor;
  direction_next = Direction;
  door_open_next = 0;
  F_led_next = F_led | F;
  U_led_next = U_led | U;
  D_led_next = D_led | D;
  fcnt_enable = 1'b1;
  dcnt_enable = 1'b1;

  case (Direction)
    2'b00: begin
      if (Open || DH || Emergency) begin
        dcnt_load = 1'b1;
        door_open_next = 1'b1;
      end else if (~Fud_zero && Fud_floor == Floor) begin
        dcnt_load = 1'b1;
        direction_pre = Floor < N - 1 && U_led[Floor];
      end else if (dcnt_done || Close) begin
        fcnt_load = ~Fud_zero;
        direction_next = Fud_zero ? 2'b00 : Fud_floor < Floor ? 2'b01 : 2'b10;
      end else begin
        dcnt_load = 1'b0;
        door_open_next = 1'b1;
      end
      F_led_next = F_led_next & n_dec_floor;
      if (direction_pre == 1'b1) U_led_next = U_led_next & n_dec_floor[N - 2:0];
      else D_led_next = D_led_next & n_dec_floor[N - 1:1];
    end
    2'b10: begin
      direction_pre = 1'b1;
      if (fcnt_done) begin
        // predefined cushion
        floor_next = Floor + 1;
        if (F_led[floor_next] ||
               (floor_next < N - 1 && U_led[floor_next]) ||
               (floor_next == Fud_floor)) begin // {1'b0, U_led}[floor_next]
          direction_next = 2'b00;
          dcnt_load = 1'b1;
        end else begin
          fcnt_load = 1'b1;
        end
      end else begin
        fcnt_load = 1'b0;
      end
    end
    2'b01: begin
      direction_pre = 1'b0;
      if (fcnt_done) begin
        // predefined cushion
        floor_next = Floor - 1;
        if (F_led[floor_next] ||
               (floor_next > 0 && D_led[floor_next - 1]) ||
               (floor_next == Fud_floor)) begin // {D_led, 1'b0}[floor_next]
          direction_next = 2'b00;
          dcnt_load = 1'b1;
        end else begin
          fcnt_load = 1'b1;
        end
      end else begin
        fcnt_load = 1'b0;
      end
    end
  endcase
end

endmodule
