`include "ili9163_top.v"
`timescale 1ns / 1ps

// Módulo de banco de pruebas para el módulo ili9163_top
module ili9163_TB ();
    reg clk;  // Señal de reloj
    reg rst;  // Señal de reinicio

    // Instancia del módulo bajo prueba (UUT)
    ili9163_top uut(
        .clk(clk),    // Conectar la señal de reloj al UUT
        .rst(rst)     // Conectar la señal de reset al UUT
    );

    // Bloque inicial para la configuración de señales
    initial begin
        clk = 0;     // Inicializar el reloj en 0
        rst = 0;     // Inicializar la señal de reset en 0
        #10 rst = 1; // Activar la señal de reinicio después de 10 ns
        #10 rst = 0; // Desactivar la señal de reinicio después de otros 10 ns
    end 

    // Generador de señal de reloj
    always #1 clk = ~clk;  // Alternar la señal de reloj cada 1 ns (creando un reloj de 500 MHz)

    // Bloque inicial para la simulación
    initial begin:TEST_CASE
        $dumpfile("ili9163.vcd");    // Especificar el archivo de salida para la forma de onda
        $dumpvars(-1, uut);          // Guardar todas las variables del UUT en el archivo de volcado
        #55000000 $finish;           // Finalizar la simulación después de 55 ms
    end

endmodule
