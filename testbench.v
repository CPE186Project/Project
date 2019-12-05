module test();
	reg clk,reset_n,timeout,we;
	reg [11:0] seq;
	reg [1:0] ack_nak;
	reg [63:0] din;
	wire ready;
	wire [63:0] dout;
	integer i;
	replay_buffer r1(.*);
	initial
		begin
			reset_n=1;clk=0;timeout=0;we=1;
			#2 reset_n=0;
			#4 reset_n=1;
			if(ready)
			begin
				for(i=0;i<4;i=i+1)
				begin
					#2 ack_nak=0;
					we=1;
					timeout=0;
					if(i==2)
					timeout=1;// time check in between wr
					seq=i;
					din=i;
				end
				for(i=0;i<4;i=i+1)
				begin
					#2 ack_nak=1;
					we=0;
					timeout=0;// timeout cant ccur when ack is recieved
					seq=i;
				end
			end
			else
			timeout=1;
			#10000 $finish;
		end
		initial
		forever
		#2 clk=~clk;
		initial
		$monitor(" reset_n=%b timeout=%b we=%b seq=%b ack_nak%b din=%h ready%b dout%h",reset_n,timeout,we,seq,ack_nak,din,ready,dout);
  
		initial
		begin
			$dumpfile("dump.vcd");
			$dumpvars(1);
		end
endmodule