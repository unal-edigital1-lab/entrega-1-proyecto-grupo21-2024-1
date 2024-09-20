module Fotoresistencia(
	input clk,
	input wire test_enable,
	input wire FR,
	output reg luz_out = 0
);

	wire clk2;

	divisor div_FR(
		 .clk_in(clk),
		 .freq_out(14'd10000),
		 .clk_out(clk2)
	);

	always @(posedge clk2) begin

		if (test_enable == 0) begin  
			if (FR == 0) begin
				luz_out <= 1;
			end else begin
				luz_out <= 0;
			end
		end
		
	end

endmodule