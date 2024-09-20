module Infrarojo(
	input clk,
	input wire test_enable,
	input wire IR,
	output reg prox_out = 0
);

	wire clk2;

	divisor div_IR(
		 .clk_in(clk),
		 .freq_out(14'd10000),
		 .clk_out(clk2)
	);

	always @(posedge clk2) begin
		
		if (test_enable == 0) begin  // Ejecutar solo si test_enable es 0
			if (IR == 0) begin
				prox_out <= 1;
			end else begin
				prox_out <= 0;
			end
		end
		
	end

endmodule	