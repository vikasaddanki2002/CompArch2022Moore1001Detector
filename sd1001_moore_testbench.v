module sd1001_moore_testbench();
  reg  clk;
  reg  reset;
  reg  in;
  wire out;
  
  reg [1:0] l_dly;
  reg tb_in;
  integer loop = 20;
  integer i;
  
  always #10 clk = ~clk;
  
  sd1001_moore u0 (clk, reset, in, out);
  
  initial begin
    clk <= 0;
    reset <= 0;
    in <= 0;
    
    repeat (5) @ (posedge clk);
    reset <= 0; //makes so clock isn't staying at 1 continously 
	 
    for (i = 0 ; i < loop; i = i + 1) 
	 begin
      l_dly = $random;
      repeat (l_dly) @ (posedge clk);
      tb_in = $random;
      in <= tb_in;
		
    end

    #100 $finish;
  end
  
  always @ (posedge clk) begin
    $strobe ("T=%0t in=%0b out=%0b", $time, in, out);
  end
endmodule
