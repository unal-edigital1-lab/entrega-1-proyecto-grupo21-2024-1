`timescale 1ns / 1ps

module display(
//	 input [2:0] numE,
//	 input [2:0] numC,
//	 input [2:0] numA,
//	 input [2:0] numS,
	 
	 input [3:0] stat_name,
	 input [5:0] stat_value,
	 input [3:0] state,
//	 input [5:0] dias,
	 
    input clk,
	 input rst,
	 
	 output [0:6] sseg,
    output reg [7:0] an,
	 
	 output led
    );

	reg [7:0]bcd=0;
	BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg));

	reg [26:0] cfreq=0;
	wire enable;

	// Divisor de frecuecia
	assign enable = cfreq[16];
	assign led = enable;

	always @(posedge clk) begin
	  
		if(rst==0) begin
		
			cfreq <= 0;
		
		end else begin
		
			cfreq <=cfreq+1;
		
		end
	
	end

	reg [2:0] count =0;

	always @(posedge enable) begin
		if(rst==0) begin
		
			count<= 0;
			an<=9'b111111111; 
		
		end else begin 
		
			count<= count+1;
			an<=9'b111111111; 
		
			case (count) 

				3'h0: begin bcd <= (stat_value % 10); an<=9'b111111110; end
				3'h1: begin bcd <= ((stat_value / 10) % 10); an<=9'b111111101; end
				3'h2: begin bcd <= (stat_name); an<=9'b111110111; end

				3'h3: begin bcd <= state[0]; an<=9'b111101111; end
				3'h4: begin bcd <= state[1]; an<=9'b111011111; end 
				3'h5: begin bcd <= state[2]; an<=9'b110111111; end
				3'h6: begin bcd <= state[3]; an<=9'b101111111; end
				
//				2'h0: begin bcd <= (numE); an<=9'b111111110; end
//				2'h1: begin bcd <= (4'he); an<=9'b111111101; end 
//				2'h2: begin bcd <= (numC); an<=9'b111111011; end 
//				2'h3: begin bcd <= (4'hc); an<=9'b111110111; end //Display que muestra B(11)
//				
//				3'h4: begin bcd <= (numA); an<=9'b111101111; end
//				3'h5: begin bcd <= (4'ha); an<=9'b111011111; end 
//				3'h6: begin bcd <= (numS); an<=9'b110111111; end 
//				3'h7: begin bcd <= (4'd5); an<=9'b101111111; end //Display que muestra A(10)

			endcase
		end
	end
endmodule


//----------------------------------------------------------------------------------------------------------------------------


//`timescale 1ns / 1ps
//module display(
//	 
//	 input [6:0] stat_name,
//	 input [5:0] stat_value,
//	 
//    input clk,
//	 input rst,
//	 
//	 output [0:6] sseg,
//    output reg [7:0] an,
//	 
//	 output led
//    );
//
//
//	reg [7:0]bcd=0;
//
//	BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg));
//
//	reg [26:0] cfreq=0;
//	wire enable;
//
//	// Divisor de frecuecia
//	assign enable = cfreq[16];
//	assign led =enable;
//	
//	always @(posedge clk) begin
//		if(rst==0) begin
//		
//			cfreq <= 0;
//		
//		end else begin
//			
//			cfreq <=cfreq+1;
//		
//		end
//	end
//
//	reg [1:0] count =0;
//
//	always @(posedge enable) begin
//
//		if(rst==0) begin
//
//			count<= 0;
//			an<=9'b111111111; 
//
//		end else begin 
//
//			count<= count+1;
//			an<=9'b111111111; 
//
//			case (count) 
//
//				2'h0: begin bcd <= (stat_value % 10); an<=9'b111111110; end
//				2'h1: begin bcd <= ((stat_value / 10) % 10); an<=9'b111111101; end
//				2'h2: begin bcd <= (stat_name); an<=9'b111101111; end
//
//			endcase
//
//		end
//	end
//
//endmodule