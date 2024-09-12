module tamagotchitop(
	input clk,               // Reloj del sistema
	input rst,               // Señal de reinicio
	input test,
	input btn_comer_inc,     // Botón para incrementar el valor del registro actual
	input btn_curar_dec,     // Botón para decrementar el valor del registro actual
	input btn_next,          // Botón para avanzar al siguiente registro
	input btn_back,          // Botón para retroceder al registro anterior
	input sns_prox,
	input sns_temp,
	input sns_luz,

	output [0:6] sseg,
	output [7:0] an
);
	 
	// Señales de los registros
	//wire [2:0] wire_s;
	//wire [2:0] wire_a;
	//wire [2:0] wire_c;
	//wire [2:0] wire_e;
	
	wire [3:0] wState;
	wire [3:0] wStat_name;
	wire [5:0] wStat_value;
	//wire [5:0] wDias;
	 
	 // Instancia de BancodeRegistros
	BancoRegistro registros (
		.clk(clk),
		.rst(rst),
		.test(test),
		.btn_back(btn_back),
		.btn_next(btn_next),
		.btn_comer_inc(btn_comer_inc),
		.btn_curar_dec(btn_curar_dec),
		.sns_prox(sns_prox),
		.sns_temp(sns_temp),
		.sns_luz(sns_luz),
//		.datOutEnergia(wire_e),
//		.datOutComida(wire_c),
//		.datOutAnimo(wire_a),
//		.datOutSalud(wire_s)
		.stat_name(wStat_name),
		.stat_value(wStat_value),
		.state(wState),
//		.dias(wDias),
	);

   display displayh(
//		.numE(wire_e),
//		.numC(wire_c),
//		.numA(wire_a),
//		.numS(wire_s),
		.stat_name(wStat_name),
		.stat_value(wStat_value),
		.state(wState),
//		.dias(wDias),
		.clk(clk),
		.sseg(sseg),
		.an(an),
		.rst(rst),
		.led(led)
	);
	
endmodule


//---------------------------------------------------------------------------------------------------------------------------

//module tamagotchitop(
//	input clk,               // Reloj del sistema
//	input rst,               // Señal de reinicio
//	input test,
//	input btn_comer_inc,     // Botón para incrementar el valor del registro actual
//	input btn_curar_dec,     // Botón para decrementar el valor del registro actual
//	input btn_next,          // Botón para avanzar al siguiente registro
//	input btn_back,          // Botón para retroceder al registro anterior
//	input sns_prox,
//	input sns_temp,
//	input sns_luz,
//
//	output [0:6] sseg,
//	output [7:0] an
//);
//	 
//	// Señales de los registros
//	wire [7:0] wStat_name;
//	wire [5:0] wStat_value;
//	 
//	// Instancia de BancodeRegistros
//	BancoRegistro registros (
//		.clk(clk),
//		.rst(rst),
//		.test(test),
//		.btn_back(btn_back),
//		.btn_next(btn_next),
//		.btn_comer_inc(btn_comer_inc),
//		.btn_curar_dec(btn_curar_dec),
//		.sns_prox(sns_prox),
//		.sns_temp(sns_temp),
//		.sns_luz(sns_luz),
//		.stat_name(wStat_name),
//		.stat_value(wStat_value),
//	);
//
//	display displayh(
//		.stat_name(wStat_name),
//		.stat_value(wStat_value),
//		.clk(clk),
//		.sseg(sseg),
//		.an(an),
//		.rst(rst),
//		.led(led)
//	);
//	
//endmodule