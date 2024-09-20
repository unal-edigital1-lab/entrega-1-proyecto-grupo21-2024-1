	module BCDtoSSeg (BCD, SSeg);

  input [3:0] BCD;
  output reg [6:0] SSeg;
always @ ( * ) begin
  case (BCD)
   4'd0: SSeg = 7'b0000001; // "0"  
	4'd1: SSeg = 7'b1001111; // "1"""i" 
	4'd2: SSeg = 7'b0010010; // "2" 
	4'd3: SSeg = 7'b0000110; // "3" 
	4'd4: SSeg = 7'b1001100; // "4" 
	4'd5: SSeg = 7'b0100100; // "5""S"
	4'd6: SSeg = 7'b0100000; // "6""G" 
	4'd7: SSeg = 7'b0001111; // "7" 
	4'd8: SSeg = 7'b0000000; // "8"  
	4'd9: SSeg = 7'b0000100; // "9" 
   4'ha: SSeg = 7'b0001000; // "A"
   4'hb: SSeg = 7'b1100000; // "b"
   4'hc: SSeg = 7'b0110001; // "C"
   4'hd: SSeg = 7'b1000010; // "d"
   4'he: SSeg = 7'b0110000; // "E"
   4'hf: SSeg = 7'b0111000; // "F"
//	7'b1001000; // "H"
//	7'b0111000; // "J"
//	7'b1110001; // "L"
//	7'b1101010; // "n"
//	7'b0101010; // "ñ"
//	7'b1100010; // "o"
//	7'b0011000; // "P"
//	7'b1000001; // "U"
//	7'b1000100; // "Y"
	
    default:
    SSeg = 0;
  endcase
end

endmodule
