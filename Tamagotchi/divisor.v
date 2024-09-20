module divisor(
   input           clk_in,     // reloj entrante de 50MHz
	input  [31:0]   freq_out,   												
   output reg      clk_out      // reloj salida
);

	parameter frecuencia = 50000000 ;

	reg [31:0] max_count; 															
	reg [22:0] count; // contador de flancos

	initial begin
		count = 0;
		clk_out = 0;
	end

	always @(posedge clk_in) begin												

		if (freq_out > 0) begin
			max_count <= (frecuencia / (2 * freq_out)) - 1;
		end

		if (count == max_count) begin
			clk_out <= ~clk_out;  // Invertir el reloj de salida
			count <= 0;
		end else begin
			count <= count + 1;
		end

	end

endmodule