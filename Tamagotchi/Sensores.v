module Sensores (
	input wire clk,                // Reloj del sistema (50 MHz)
	input wire rst,                // Reset del sistema
	input test_enable,
	input sns_active, 
	
	inout wire dht11,              // Línea de datos del sensor DHT11
	output wire temp_out,

	input wire IR,
	output wire prox_out,
	
	input wire FR,
	output wire luz_out

);

//always @(posedge clk)begin
//	if (test_enable==1) begin
		
		dht temp(
			.clk(clk),
			.test_enable(test_enable),
			.sns_active(sns_active),
			.dht11(dht11),
			.temp_out(temp_out)
		);

		Infrarojo prox(
			.clk(clk),
			.test_enable(test_enable),
			.IR(IR),
			.prox_out(prox_out)
		);

		Fotoresistencia luz(
			.clk(clk),
			.test_enable(test_enable),
			.FR(FR),
			.luz_out(luz_out)
		);

//	end
//end


endmodule