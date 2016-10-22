`timescale 1ns/100ps
module stimulus;
  reg go, ws, clk, rst_n;
  wire ds0, rd0;
  wire ds1, rd1;

  parameter cyc = 10;
  parameter delay = 2;

  // Keep track of any errors
  reg error = 0;
  integer error_count = 0;

  // Cell reference to the Moore model
  fsm_k_moore2 fsm0 (
    .ds(ds0),
    .rd(rd0),
    .go(go),
    .ws(ws),
    .clk(clk),
    .rst_n(rst_n)
  );

  // Cell reference to your Mealy model
  fsm_k_mealy fsm1 (
    .ds(ds1),
    .rd(rd1),
    .go(go),
    .ws(ws),
    .clk(clk),
    .rst_n(rst_n)
  );

  // Generate clock scheme with the period of 'cyc'
  always #(cyc/2) clk = ~clk;

  // Compare the two output pairs cycle by cycle, at each positive clock edge
  // HW Q: What will error and error_count do?
  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
      error_count = 0;
    end else begin
      error = 0;
      if ((ds0 !== ds1) || (rd0 !== rd1)) begin
        error = 1;
        error_count = error_count + 1;
      end
    end
  end

  initial begin
    // Initial assignment of input signals
    clk = 0;
    rst_n = 1;
    go = 0;
    ws = 0;

    // Reset
    #(delay);
    #(cyc/2);
    #(cyc*2) rst_n = 0;
    #(cyc*2) rst_n = 1;

    // Test patterns
    // HW Q: Are these patterns enough to verify the FSM?
    //       If not, add your own patterns.
    #(cyc);
    #(cyc);
    #(cyc) go = 1; ws = 1;
    #(cyc*3);
    #(cyc); ws = 0;
    #(cyc); go = 0;
    #(cyc*2);
    #(cyc); go = 1;
    #(cyc); go = 0; ws = 1;
    #(cyc*5);

    // Display the comparison result
    if (error_count == 0) begin
      $display("\n<<<< Passed! >>>>");
      $display("The output signals of the two FSMs are matched cycle by cycle!\n");
    end else begin
      $display("\n<<<< Failed! >>>>");
      if (error_count == 1) begin
        $display("There is 1 error.\n");
      end else begin
        $display("There are %4d errors.\n", error_count);
      end
    end

    $finish;
  end

  // Dumping the waveform
  initial begin
    $fsdbDumpfile("hw7_1.fsdb");
    $fsdbDumpvars;
  end

endmodule
