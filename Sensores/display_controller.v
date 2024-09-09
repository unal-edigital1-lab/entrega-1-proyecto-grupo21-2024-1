//`include "bcd_to_7seg.v"

module display_controller (
    input clk,
    input [15:0] value1, // Primer valor de 4 dígitos
    input [15:0] value2, // Segundo valor de 4 dígitos
    output reg [7:0] an, // Anodos de los 8 displays
    output reg [6:0] seg // Segments a-g
);
    reg [3:0] digit;
    reg [2:0] sel;
	 reg [31:0] timer;

    wire [6:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7;

    // Convertir cada dígito a segmentos
    bcd_to_7seg bcd0 (.bcd(value1[3:0]), .seg(seg0));
    bcd_to_7seg bcd1 (.bcd(value1[7:4]), .seg(seg1));
    bcd_to_7seg bcd2 (.bcd(value1[11:8]), .seg(seg2));
    bcd_to_7seg bcd3 (.bcd(value1[15:12]), .seg(seg3));
    bcd_to_7seg bcd4 (.bcd(value2[3:0]), .seg(seg4));
    bcd_to_7seg bcd5 (.bcd(value2[7:4]), .seg(seg5));
    bcd_to_7seg bcd6 (.bcd(value2[11:8]), .seg(seg6));
    bcd_to_7seg bcd7 (.bcd(value2[15:12]), .seg(seg7));
	 
	 initial begin
		timer = 0; 
	 end

    // Multiplexor
    always @(posedge clk) begin
		  if (timer < 1200) begin
				timer <= timer + 1;
		  end else begin
				timer <= 0;
				sel <= sel + 1;
		  end
    end

    always @(*) begin
        case (sel)
            3'd0: begin an = 8'b11101111; seg = seg0; end
            3'd1: begin an = 8'b11011111; seg = seg1; end
            3'd2: begin an = 8'b10111111; seg = seg2; end
            3'd3: begin an = 8'b01111111; seg = seg3; end
            3'd4: begin an = 8'b11111110; seg = seg4; end
            3'd5: begin an = 8'b11111101; seg = seg5; end
            3'd6: begin an = 8'b11111011; seg = seg6; end
            3'd7: begin an = 8'b11110111; seg = seg7; end
            default: begin an = 8'b11111111; seg = 7'b1111111; end
        endcase
    end
endmodule
