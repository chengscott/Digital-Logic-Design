`timescale 1ns/100ps
module elevator4 #(
  parameter cyc = 10,
  parameter delay = 2,
  parameter Floor_cyc = 12,
  parameter Door_cyc = 5
);

reg CLK;
always #(cyc/2) CLK = ~CLK;
// ctrls
reg RST_N;
reg emergency = 1'b0;
reg open = 1'b0;
reg close = 1'b0;
reg door_hold = 1'b0;
// 4-story elevator
reg [3:0] f;
reg [2:0] u, d;
wire [1:0] Floor, Direction;
wire [3:0] fled;
wire [2:0] uled, dled;
elevator_controller #(
  .N(4),
  .M(2),
  .Floor_cyc(Floor_cyc),
  .Door_cyc(Door_cyc)
) elevator (
  .CLK(CLK),
  .RST_N(RST_N),
  .Emergency(emergency),
  .Open(open),
  .Close(close),
  .Door_hold(door_hold),
  .F(f),
  .U(u),
  .D(d),
  .Floor(Floor),
  .Direction(Direction),
  .Door_open(door_open),
  .F_led(fled),
  .U_led(uled),
  .D_led(dled)
);
reg [2:0] floor;
always @(Floor) floor = Floor + 1'b1;

initial begin
  $fsdbDumpfile("elevator4.fsdb");
  $fsdbDumpvars;
  //  emergency, open, close, door_hold
  $monitor($time, " Direction:%2b Floor:%d Door:%b\n\t\t\t   IN : F4321 | u321 d432\n\t\t\t         %4b |  %3b  %3b\n\t\t\t   LED: F4321 | u321 d432\n\t\t\t         %4b |  %3b  %3b",
      Direction, floor, door_open,
      f, u, d,
      fled, uled, dled
  );
end

initial begin
  CLK = 1;
  RST_N = 1'b1;
  f = 4'b0;
  u = 3'b0;
  d = 3'b0;
  #(cyc + delay) RST_N = 1'b0;
  #(cyc*4) RST_N = 1'b1;
  #(cyc);

  $display("\n\n\
\t\t\t------------------------------------------\n\
\t\t\tWelcome to Digital Logic Design elevator!!\n\
\t\t\t                        By chengscott 2016\n\
\t\t\t------------------------------------------\n\n");

  $display("\t\t\tDay 1: a 4-storey building with elevator\n");

  $display("\tScenario #1\n");
  #(cyc + delay) u = 3'b010;
  $display("\tAB press UP at 2F");
  #(cyc) u = 3'b0;
  #(Floor_cyc*cyc); // 1F -> 2F
  #(cyc);
  #(cyc) f = 4'b1000;
  $display("\tA press 4F in elevator");
  #(cyc) f = 4'b0100;
  $display("\tB press 3F in elevator");
  #(cyc) f = 4'b0;
  #((Door_cyc - 4)*cyc); // 2F door
  #(Floor_cyc*cyc); // 2F -> 3F
  #(Door_cyc*cyc); // 3F door
  #(Floor_cyc*cyc); // 3F -> 4F
  #(Door_cyc*cyc); // 4F door
  #(cyc) d = 3'b010;
  $display("\tMeanwhile, CD press DOWN at 3F");
  #(cyc*2) d = 3'b0;
  #((Door_cyc - 4)*cyc);
  #(Floor_cyc*cyc); // 4F -> 3F
  #(cyc) f = 4'b0010;
  $display("\tC press 2F in elevator");
  #(cyc) f = 4'b0011;
  $display("\tD press 1F in elevator simultaneuously");
  #(cyc) f = 4'b0010;
  #(cyc*2) f = 4'b0;
  #((Door_cyc - 5)*cyc);
  #(Floor_cyc*cyc);
  #(Door_cyc*cyc);
  #(Floor_cyc*cyc);
  #(Door_cyc*cyc);
  #(Floor_cyc*cyc);
  #(Door_cyc*cyc);

  $display("\tScenario #1 ends\n");

  #(cyc)
  RST_N = 1'b1;
  f = 4'b0;
  u = 3'b0;
  d = 3'b0;
  #(cyc + delay) RST_N = 1'b0;
  #(cyc*4) RST_N = 1'b1;
  #(cyc);
  $display("\tScenario #2\n");
  #(cyc) u = 3'b100;
  #(cyc) u = 0;
  $display("\tA press UP at 3F");
  #(Floor_cyc*2*cyc);
  #(Door_cyc*cyc) open = 1;
  $display("\tA press Open for 11 cycles");
  #(cyc*11) open = 0;
  #(cyc) close = 1;
  $display("\tAfter 1 cycle, A press Close");
  #(Floor_cyc*cyc/2) emergency = 1;
  $display("\tThe final project elevator is on fire, so A press Emergency");
  #(cyc) emergency = 0;
  #(Floor_cyc*cyc);
  #(Door_cyc*cyc);

  $display("\tScenario #2 ends\n");

  $display("\n\t\t\tDLD elevator say goodbye!!\n");

  #(Floor_cyc*cyc*10);
  $finish;
end

endmodule
