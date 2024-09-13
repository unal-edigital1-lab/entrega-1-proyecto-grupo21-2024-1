//`include "divisor.v"

module contadorFR#(parameter MAX_COUNT = 10000000)(
    input clk,
    input wire rst,
	input wire FR,
	output reg Salida_contadorFR = 1
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
		 Salida_contadorFR <= 0;
	end else if (FR == 0) begin
		 counter <= counter + 1;
		 Salida_contadorFR <= 0;
	end else begin
		 Salida_contadorFR <= 1;
		 counter <= 0;
	end
	
	
	
end


endmodule