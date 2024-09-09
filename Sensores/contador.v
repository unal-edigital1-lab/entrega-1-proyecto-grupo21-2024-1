//`include "divisor.v"

module contador#(parameter MAX_COUNT = 10000000)(
    input clk,
    input wire rst,
	input wire IR,
	output reg Salida_contador = 1
);

wire clk2;
reg [$clog2(MAX_COUNT)-1:0] counter;

divisor aat(
    .clkd(clk),
    .clk2(clk2)
);


initial begin
	counter = 0;
end

always @(posedge clk2) begin
	
	if (rst) begin
		 counter <= 0;
	end else if (counter >= 50000) begin
		 Salida_contador <= 0;
	end else if (IR == 0) begin
		 counter <= counter + 1;
		 Salida_contador <= 0;
	end else begin
		 Salida_contador <= 1;
		 counter <= 0;
	end
	
	
	
end

	
/*always @(posedge clk2) begin
	if (rst == 0)begin
		Salida_contador <= 1;
	end else if (counter >= 1000)begin
		Salida_contador <= 0;
	end else begin
		Salida_contador <= 1;
	end
	
	
end*/

endmodule