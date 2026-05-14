module bcd_7seg(leds,bcd);
//ports and nets

input [3:0] bcd;
output reg [0:6] leds;

always@(bcd) begin
case (bcd)
4'd0: leds = 7'b1111110;
4'd1: leds = 7'b0110000;
4'd2: leds = 7'b1101101;
4'd3: leds = 7'b1111001;
4'd4: leds = 7'b0110011;
default : leds = 7'b0000001;

endcase
end
endmodule