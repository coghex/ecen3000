module lab5 (reset, hs, clk, bitin, bitout, gnd, led);
  input reset, hs, clk, bitin, gnd;
  output bitout, led;
				
  reg            resetted;
  reg                read;
  reg                   i;
  reg                   j;
  reg         [16:0] data;
  reg                send;

  always @(posedge clk) begin
    if (reset == 1) begin
      resetted = 1;
      read = 0;
      send = 0;
    end
    else if (resetted == 1) begin
      read = 1;
      resetted = 0;
      i = 0;
    end
    if (read == 1) begin
      if (handshake == 1) begin
        data[i] = bitin;
        led = bitin;
        i++;
      end
      if (handshake == 0) begin
        read = 0;
        send = 1;
      end
    end

    if (send == 1) begin
      for (j=0;j<i;j++) begin
        bitout = data[j];
      end
    end

  end
endmodule
