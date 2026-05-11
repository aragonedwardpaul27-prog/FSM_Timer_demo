/*================================================
		           FSM_Timer_demo
==================================================
Descripion:
	
Design Engineer:
	Edward Paul M. Aragon ☻ 

Date:
	11 May 2026
-------------------------------------------------*/
module FSM_Timer_demo (out, state, timer, t, ovr, clk, rst_n);
 //ports
 input			t;
 input			ovr;
 input 			clk; 		//50mhz clock
 input 			rst_n;
 output reg 	out;
 output reg 	[3:0] 	timer;
 output reg 	[3:0] 	state;

 //state assignment
 localparam [1:0] S0 = 2'b00;
 localparam [1:0] S1 = 2'b01;
 localparam [1:0] S2 = 2'b10;
 localparam [1:0] S3 = 2'b11;
 
 reg [1:0] nxt;
 reg [1:0] pre;
 
 // input block
 always @ (t, ovr, pre) begin //check input and present state
	case (pre) // if present state is:
	S0: 		nxt =  (t==2) ? S1:S0;
	S1: 		nxt =  (t==3) ? S2:S1;
	S2: 		nxt =  (t==2) ? S0:S2;
	S3: 		nxt =  (ovr==1) ? S3:S0;
	default: nxt = S0;
	
	endcase
 end
 // sequential block
 always @ (posedge clk, negedge rst_n) begin
	pre <= nxt;
	if(pre == S0) begin
		if (t==2) begin //check timer
			nxt<=S1;
			t<=0;
		end
		
		else t<= t+1;
	end
	
	if(pre == S1) begin
		if (t==3) begin //check timer
			nxt<=S2;
			t<=0;
		end
		
		else t<= t+1;
	end
	
	if(pre == S2) begin
		if (t==2) begin //check timer
			nxt<=S0;
			t<=0;
		end
		
		else t<= t+1;
	end
	
	if(pre == S3) begin
		if (ovr) begin //check timer
			nxt<=S3;
			t<=0;
		end
		
		else 
			nxt <= pre;
		end
 endmodule
 