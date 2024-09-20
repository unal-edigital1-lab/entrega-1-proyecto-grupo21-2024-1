module test_module #(
	parameter frec_fpga = 50000000,
	parameter segundos = 5
)
(	input clk,
	input test,
	
	output reg test_enable
);

	parameter ciclos_segs = frec_fpga * segundos;

	reg [$clog2(ciclos_segs)-1:0] counter;  // Contador para los ciclos
	reg test_active;
	
	initial begin
		counter = 0;
		test_enable <= 1'b0;
		test_active <= 1'b0;
	end
	
	always @(posedge clk) begin
		
		if (test==0) begin
			
			if (counter >= ciclos_segs) begin
				counter <= 0;  // Reiniciar el contador después de 3 segundos
				test_active <= ~test_active;  // Cambiar el estado de test_active
				test_enable <= test_active;  // Actualizar el valor de test_enable
			end else begin
				counter <= counter + 1;  // Incrementar el contador si test sigue activo
			end
		
		end else begin
			counter <= 0;  // Reiniciar el contador si test se desactiva
		end
	end
endmodule