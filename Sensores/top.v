module top (
	input wire clk,                // Reloj del sistema (50 MHz)
    input wire rst,                // Reset del sistema
    inout wire dht11,              // Línea de datos del sensor DHT11
    output wire valid_data,         // Indicador de datos válidos
    output wire led,
    //--------------------------- 7 segmentos----------------------
    //output wire [6:0] seg,        // Conectar a los pines del display de 7 segmentos
    //output [7:0] an,
	 
	 input wire IR,
	 output wire Salida_contador,
	 input wire FR,
	 output wire Salida_contadorFR

);

dht u1(
	.clk(clk),
	.rst(rst),
	.dht11(dht11),
	.valid_data(valid_data),
	.led(led)
);

contador u2(
	.clk(clk),
	.rst(rst),
	.IR(IR),
	.Salida_contador(Salida_contador)
);

contadorFR u3(
	.clk(clk),
	.rst(rst),
	.FR(FR),
	.Salida_contadorFR(Salida_contadorFR)
);

endmodule