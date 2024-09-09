module bcd_to_7seg (
    input [3:0] bcd,
    output reg [6:0] seg
);
    always @(*) begin
        case (bcd)
            4'd0: seg = 7'b1000000; // 0
            4'd1: seg = 7'b1111001; // 1
            4'd2: seg = 7'b0100100; // 2
            4'd3: seg = 7'b0110000; // 3
            4'd4: seg = 7'b0011001; // 4
            4'd5: seg = 7'b0010010; // 5
            4'd6: seg = 7'b0000010; // 6
            4'd7: seg = 7'b1111000; // 7
            4'd8: seg = 7'b0000000; // 8
            4'd9: seg = 7'b0010000; // 9
				4'd10: seg = 7'b0011100; // °
				4'd11: seg = 7'b0101111; // r
				4'd12: seg = 7'b0001001; // H
				4'd13: seg = 7'b1000110; // C
				4'd14: seg = 7'b0001110; // F
				4'd15: seg = 7'b0010000; // 0
            default: seg = 7'b1111111; // Apagar display
        endcase
    end
endmodule
