module stimulus;
  parameter cyc = 10;
  parameter delay = 2;

  reg clk, rst_n, start;
  reg [7:0] a, b;
  wire done, error;
  wire [7:0] y;

  GCD gcd01(
    .CLK(clk),
    .RST_N(rst_n),
    .A(a),
    .B(b),
    .START(start),
    .Y(y),
    .DONE(done),
    .ERROR(error)
  );

  always #(cyc/2) clk = ~clk;

  initial begin
    $fsdbDumpfile("gcd.fsdb");
    $fsdbDumpvars;
    $monitor($time,
        " CLK=%b RST_N=%b START=%b A=%3d B=%3d | DONE=%b Y=%3d ERROR=%b",
        clk, rst_n, start, a, b, done, y, error);
  end

  initial begin
    clk = 1;
    rst_n = 1;

    #(cyc);
    #(delay) rst_n = 0;
    #(cyc*4) rst_n = 1;
    #(cyc*2);

    #(cyc) start = 0;

    // 1st pattern	21, 6	
    #(cyc)	//delay at reset
      start = 1;
      a = 8'd21;
      b = 8'd6;
    #(cyc)
      start = 0;

    @(posedge done);

    // 2nd pattern 75, 60
    #(cyc + delay)
      start = 1;
      a = 8'd75;
      b = 8'd60;
    #(cyc) 
      start = 0;
    @(posedge done);

    // 3rd pattern	0, 75
    #(cyc + delay) 
      start = 1;
      a = 8'd0;
      b = 8'd75;
    #(cyc)
      start = 0;
    @(posedge done);
		
    // 4th pattern	0, 0
    #(cyc + delay) 
      start = 1;
      a = 8'd0;
      b = 8'd0;
    #(cyc)
      start = 0;
    @(posedge done);

    // 5th pattern  34, 119
    #(cyc + delay)
      start = 1;
      a = 8'd34;
      b = 8'd119;
    #(cyc)
      start = 0;
    @(posedge done);

    // 6th patern 127, 3
    #(cyc + delay)
      start = 1;
      a = 8'd127;
      b = 8'd3;
    #(cyc)
      start = 0;
    @(posedge done)

    // 7th patern 126, 63
    #(cyc + delay)
      start = 1;
      a = 8'd126;
      b = 8'd63;
    #(cyc)
      start = 0;
    @(posedge done)

    // 8th patern 1, 1
    #(cyc + delay)
      start = 1;
      a = 8'd1;
      b = 8'd1;
    #(cyc)
      start = 0;
    @(posedge done)

    // 9th patern 123, 0
    #(cyc + delay)
      start = 1;
      a = 8'd123;
      b = 8'd0;
    #(cyc)
      start = 0;
    @(posedge done)

    #(cyc*8);
    $finish;
		
  end
endmodule
