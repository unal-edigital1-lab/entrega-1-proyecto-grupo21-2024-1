`timescale 1ns / 1ps
//`include "dht.v"

module dht_TB;
    reg clk;
    reg rst;
	reg dir;           // Dirección de la señal (0: entrada, 1: salida)
    wire dht11_in;     // Valor de salida para la señal dht11
    reg dht11_out;     // Valor de entrada desde la señal dht11
	wire dht11;        // Señal bidireccional conectada al DUT
    wire [7:0] humidity;
    wire [7:0] temperature;
    wire valid_data;

    // Instancia del módulo dht11_interface
    dht uut (
        .clk(clk),
        .rst(rst),
        .dht11(dht11),
        .valid_data(valid_data)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end
	 
	 // Control de la señal bidireccional
    assign dht11 = dir ? dht11_out : 1'bz;
    assign dht11_in = dht11;
	 
    // Secuencia de pruebas
    initial begin
        //rst = 1;
		  //dir = 0;
        //#60;
        rst = 0;

        // Simulación de la señal de inicio para el sensor
        #18000/*000*/;
        //Aquí puedes agregar la lógica para iniciar la lectura del sensor
		  dir = 1;
        dht11_out = 0;
        #80;
        dht11_out = 1;
        #80;
        dir = 0;
		  
		  #10000000
        if (valid_data) begin
            $display("Humedad: %d %%", humidity);
            $display("Temperatura: %d °C", temperature);
        end else begin
            $display("No se recibieron datos válidos.");
        end
		  
		  

        $stop;
    end

    /*initial begin: TEST_CASE
        $dumpfile("dht_TB.vcd");
        $dumpvars(-1, uut);
        #12000000 $finish;
    end*/
endmodule