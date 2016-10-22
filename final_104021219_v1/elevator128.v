`timescale 1ns/100ps
module elevator128 #(
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
// 128-story elevator
reg [127:0] f;
reg [126:0] u, d;
wire [6:0] Floor;
wire [1:0] Direction;
wire [127:0] fled;
wire [126:0] uled, dled;
elevator_controller #(
  .N(128),
  .M(7),
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
reg [7:0] floor;
always @(Floor) floor = Floor + 1'b1;

initial begin
  $fsdbDumpfile("elevator128.fsdb");
  $fsdbDumpvars;
  //  emergency, open, close, door_hold
  $monitor($time, " Direction:%2b Floor:%d Door:%b\n\t\t\t   IN : F128-1\n\t    %128b\n\t\t\t        u127-1\n\t    %127b\n\t\t\t        d128-2\n\t     %127b\n\t\t\t   LED: F128-1\n\t    %128b\n\t\t\t        u127-1\n\t    %127b\n\t\t\t        d128-2\n\t    %127b\n",
      Direction, floor, door_open,
      f, u, d,
      fled, uled, dled
  );
end

initial begin
  CLK = 1;
  RST_N = 1'b1;
  f = 0;
  u = 0;
  d = 0;
  #(cyc + delay) RST_N = 1'b0;
  #(cyc*4) RST_N = 1'b1;
  #(cyc);

  $display("\n\n\
\t\t\t------------------------------------------\n\
\t\t\tWelcome to Digital Logic Design elevator!!\n\
\t\t\t                        By chengscott 2016\n\
\t\t\t------------------------------------------\n\n");

  $display("\t\t\tDay 2: cthuang take elevator at Taipei \"128\" to give free meal for the class\n");

  #(cyc + delay) u = 1 << 6;
  $display("\tcthuang press UP at 7F");
  #(cyc) u = 0;
  #(Floor_cyc*7*cyc);
  #(cyc) f = 1 << 84;
  $display("\tHe press 85F in elevator");
  #(cyc) f = 0;
  #(Door_cyc*cyc);
  #(Floor_cyc*85*cyc);
  #(Door_cyc*cyc);
  $display("\tThis demonstrate the module is also work for skyscraper!!");

  $display("\n\t\t\tDLD elevator say goodbye!!\n");

  #(Floor_cyc*cyc*10);
  $finish;
end

endmodule
