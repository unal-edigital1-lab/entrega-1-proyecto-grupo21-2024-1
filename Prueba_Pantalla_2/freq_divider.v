module freq_divider #(parameter DIVIDER = 1)(
    input wire clk,       // Señal de reloj de entrada
    input wire rst,       // Señal de reinicio
    output reg clk_out    // Señal de reloj de salida dividida
);

    // Contador para llevar la cuenta de los ciclos del reloj de entrada
    reg [$clog2(DIVIDER)-1:0] counter; 

    // Bloque siempre ejecutado en cada flanco positivo del reloj de entrada
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Si rst es 0, reiniciar el contador y la señal de salida
            counter <= 'b0;     // Reiniciar el contador
            clk_out <= 'b0;     // Reiniciar la señal de reloj de salida
        end else begin
            if (counter == (DIVIDER - 1)) begin
                // Si el contador ha alcanzado el valor de división
                clk_out <= ~clk_out;   // Alternar el estado de la señal de reloj de salida
                counter <= 'b0;        // Reiniciar el contador
            end else begin
                // Si el contador no ha alcanzado el valor de división
                counter <= counter + 'b1;  // Incrementar el contador
            end
        end
    end
endmodule
