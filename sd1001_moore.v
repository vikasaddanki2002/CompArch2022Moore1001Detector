module sd1001_moore(input clk,
                   input  reset,
                   input  din,
                   output reg[1:0] dout);
	parameter  	S0 = 4'b0000, 		// "Zero" State
				   S1 = 4'b0001, 		// "One" State
					S2 = 4'b0010, 		// "OneZero" State
					S3 = 4'b0100, 		// "OnceZeroZero" State
					S4 = 4'b1001;		// "OneZeroZeroOne" State
					
  reg [4:0] state;

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      dout <= 1'b0;
      state <= S0;
    end
    else begin
      case(state)
        S0: begin
          dout <=1'b0;
          if(din == 1)
            state <= S1;
        end
        
        S1: begin
          dout <= 1'b0;
          if(din == 0)
            state <= S2;
        end
        
        S2: begin
          dout <= 1'b0;
          if(din == 0)
            state <= S3;
          else
            state <= S1;
        end
        
        S3: begin
          dout <= 1'b0;
          if(din == 1)
            state <= S4;
          else
            state <= S0;
        end
        
        S4: begin
          dout <= 1'b1;
          if(din == 1)
            state <= S1;
          else
            state <= S0;
        end
		        endcase
    end
  end
endmodule