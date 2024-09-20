module tamagotchitop(
	input clk,               // Reloj del sistema
	input rst,               // Señal de reinicio
	input test,
	
	input btn_comer_inc,     // Botón para incrementar el valor del registro actual
	input btn_curar_dec,     // Botón para decrementar el valor del registro actual
	input btn_next,          // Botón para avanzar al siguiente registro
	input btn_back,          // Botón para retroceder al registro anterior
	
	input sns_IR,
	input sns_FR,
	inout sns_temp,
	
	input sns_active,
	
// Pruebas display
	output [0:6] sseg,
	output [7:0] an
	
// Pantalla ILI
//	output spi_mosi,
//	output spi_cs,
//	output spi_sck,
//	output spi_dc
);
	
// Señales de los registros
	wire [3:0] wState;
	
	wire wTemp;
	wire w_IR;
	wire w_FR;
	wire wTest;
//	wire [5:0] wDias;

// Pantalla ILI
//	wire [2:0] wSalud;
//	wire [2:0] wAnimo;
//	wire [2:0] wComida;
//	wire [2:0] wEnergia;
	
//	Pruebas display
	wire [3:0] wStat_name;
	wire [5:0] wStat_value;	
	
	test_module test_top(
	.clk(clk),
	.test(test),
	.test_enable(wTest)
	);
	
	Sensores sensores (
		.clk(clk),
		.test_enable(wTest),
		.sns_active(sns_active),
		.dht11(sns_temp),
		.temp_out(wTemp),
		.IR(sns_IR),
		.prox_out(w_IR),
		.FR(sns_FR),
		.luz_out(w_FR)
	);
	
	 // Instancia de BancodeRegistros
	BancoRegistro registros (
		.clk(clk),
		.rst(rst),
		.test(wTest),
		
		.btn_back(btn_back),
		.btn_next(btn_next),
		.btn_comer_inc(btn_comer_inc),
		.btn_curar_dec(btn_curar_dec),
		
		.sns_prox(w_IR),
		.sns_temp(wTemp),
		.sns_luz(w_FR),
		
//		.datOutEnergia(wEnergia),
//		.datOutComida(wComida),
//		.datOutAnimo(wAnimo),
//		.datOutSalud(wSalud),
		
		.stat_name(wStat_name),
		.stat_value(wStat_value),
		.state(wState),
//		.dias(wDias)
	);

//	ili9341_top ili9163(
//		.clk(clk),
//		.rst(rst),
//		.state(wState),
//		.salud(wSalud),
//		.animo(wAnimo),
//		.comida(wComida),
//		.energia(wEnergia),
//		.jugar(w_IR),
//		.comer(btn_comer_inc),
//		.curar(btn_curar_dec),
//		.dormir(w_FR),
//		.spi_mosi(spi_mosi),
//		.spi_cs(spi_cs),
//		.spi_sck(spi_sck),
//		.spi_dc(spi_dc)
//	);
	
	
   display displayh(
		.clk(clk),
		.sseg(sseg),
		.an(an),
		.rst(rst),
		.led(led),
		
//		.numE(wEnergia),
//		.numC(wComida),
//		.numA(wAnimo),
//		.numS(wSalud),
		.stat_name(wStat_name),
		.stat_value(wStat_value),
		.state(wState)
				
//		.dias(wDias),
		
	);
	
endmodule

//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------


//module tamagotchitop(
//	input clk,               // Reloj del sistema
//	input rst,               // Señal de reinicio
//	input test,
//	
//	input btn_comer_inc,     // Botón para incrementar el valor del registro actual
//	input btn_curar_dec,     // Botón para decrementar el valor del registro actual
//	input btn_next,          // Botón para avanzar al siguiente registro
//	input btn_back,          // Botón para retroceder al registro anterior
//	
//	input sns_IR,
//	input sns_FR,
//	inout sns_temp,
//	
//	input sns_active,
//	
//// Pruebas display
//	output [0:6] sseg,
//	output [7:0] an
//	
//// Pantalla ILI
////	output spi_mosi,
////	output spi_cs,
////	output spi_sck,
////	output spi_dc
//);
//
////-----------------------------------------------------------------------------------------------------
//	parameter frec_fpga = 50000000;
//	parameter segundos = 5;
//	parameter ciclos_segs = frec_fpga * segundos;  // Total de ciclos en 5 segundos
//
//	reg [$clog2(ciclos_segs)-1:0] counter;  // Contador para los ciclos
//	reg test_enable;
//	reg test_active;  // Señal para detectar si se activa o desactiva test_enable
//
//	initial begin
//		 counter = 0;
//		 test_enable <= 1'b0;
//		 test_active <= 1'b0;
//	end
//
//// Test y rst por separado (funciona)
//
//always @(posedge clk) begin
////    if (rst==0) begin
////        counter <= 0;
////        test_enable <= 1'b0;
////        test_active <= 1'b0;
////    end else begin
//        if (test==0) begin
//            if (counter >= ciclos_segs) begin
//                counter <= 0;  // Reiniciar el contador después de 3 segundos
//                test_active <= ~test_active;  // Cambiar el estado de test_active
//                test_enable <= test_active;  // Actualizar el valor de test_enable
//            end else begin
//                counter <= counter + 1;  // Incrementar el contador si test sigue activo
//            end
//        end else begin
//            counter <= 0;  // Reiniciar el contador si test se desactiva
////        end
//    end
//end
//	 
//// Señales de los registros
//
//// Pantalla ILI
////	wire [2:0] wSalud;
////	wire [2:0] wAnimo;
////	wire [2:0] wComida;
////	wire [2:0] wEnergia;
//	
////	Pruebas display
//	wire [3:0] wStat_name;
//	wire [5:0] wStat_value;
//	
//	wire [3:0] wState;
//	
//	wire wTemp;
//	wire w_IR;
//	wire w_FR;
//	//wire [5:0] wDias;
//	
//	Sensores sensores (
//		.clk(clk),
//		.sns_active(sns_active),
//		.dht11(sns_temp),
//		.temp_out(wTemp),
//		.IR(sns_IR),
//		.prox_out(w_IR),
//		.FR(sns_FR),
//		.luz_out(w_FR)
//	);
//	
//	 // Instancia de BancodeRegistros
//	BancoRegistro registros (
//		.clk(clk),
//		.rst(rst),
//		.test(test_enable),
//		
//		.btn_back(btn_back),
//		.btn_next(btn_next),
//		.btn_comer_inc(btn_comer_inc),
//		.btn_curar_dec(btn_curar_dec),
//		
//		.sns_prox(w_IR),
//		.sns_temp(wTemp),
//		.sns_luz(w_FR),
//		
////		.datOutEnergia(wEnergia),
////		.datOutComida(wComida),
////		.datOutAnimo(wAnimo),
////		.datOutSalud(wSalud),
//		
//		.stat_name(wStat_name),
//		.stat_value(wStat_value),
//		.state(wState),
////		.dias(wDias)
//	);
//
////	ili9341_top ili9163(
////		.clk(clk),
////		.rst(rst),
////		.state(wState),
////		.salud(wSalud),
////		.animo(wAnimo),
////		.comida(wComida),
////		.energia(wEnergia),
////		.jugar(w_IR),
////		.comer(btn_comer_inc),
////		.curar(btn_curar_dec),
////		.dormir(w_FR),
////		.spi_mosi(spi_mosi),
////		.spi_cs(spi_cs),
////		.spi_sck(spi_sck),
////		.spi_dc(spi_dc)
////	);
//	
//	
//   display displayh(
//		.clk(clk),
//		.sseg(sseg),
//		.an(an),
//		.rst(rst),
//		.led(led),
//		
////		.numE(wEnergia),
////		.numC(wComida),
////		.numA(wAnimo),
////		.numS(wSalud),
//		.stat_name(wStat_name),
//		.stat_value(wStat_value),
//		.state(wState)
//				
////		.dias(wDias),
//		
//	);
//	
//endmodule