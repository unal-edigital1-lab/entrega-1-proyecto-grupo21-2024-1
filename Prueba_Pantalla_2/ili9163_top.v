//`include "ili9163_controller.v"
//`include "freq_divider.v"

module ili9163_top #(parameter RESOLUTION = 128*128, parameter PIXEL_SIZE = 16)(
        input wire clk, // Reloj de entrada de 50MHz
        input wire rst, // Señal de reinicio
        output wire spi_mosi, // Línea MOSI del bus SPI
        output wire spi_cs,   // Línea de Chip Select SPI
        output wire spi_sck,  // Línea de reloj (sck) SPI
        output wire spi_dc    // Línea de control de datos/comandos SPI
    );

    // Señal de reloj para el controlador de la pantalla (dividida)
    wire clk_out;
    // Señal de reloj utilizada para la transmisión de datos de píxeles
    wire clk_input_data;

    // Registro para el píxel actual que se va a enviar
		reg [PIXEL_SIZE-1:0] AMARILLO;
	 
    reg [PIXEL_SIZE-1:0] current_pixel;
    // Memoria que almacena los datos de todos los píxeles a enviar
    reg [PIXEL_SIZE-1:0] pixel_data_mem[0:RESOLUTION-1];

    // Contador para llevar la cuenta de los píxeles transmitidos
    reg [$clog2(RESOLUTION)-1:0] pixel_counter;
    // Señal que indica si la transmisión ha terminado
    reg transmission_done;

    // Bloque inicial para cargar valores y la memoria de píxeles
    
	 //initial begin
        //current_pixel <= 'b0; // Inicializar el píxel actual a 0
        // Cargar los datos de píxeles desde un archivo hexadecimal en la memoria
        //$readmemh("C:/Users/usuario/Documents/Prueba_pantalla_2/Red_Prueba.txt", pixel_data_mem);
        //pixel_counter <= 'b0; // Inicializar el contador de píxeles a 0
        //transmission_done <= 'b0; // Inicializar la señal de transmisión completa a 0
    //end

    // Instancia de un divisor de frecuencia para generar clk_out (20MHz)
    freq_divider #(2) freq_divider20MHz (
        .clk(clk),  // Conectar el reloj de 50MHz
        .rst(rst),  // Conectar la señal de reinicio
        .clk_out(clk_out)  // Generar un reloj dividido (12MHz)
    );  

    // Bloque always para manejar la transmisión de los datos de píxeles
    always @(posedge clk_input_data or posedge rst) begin
        if (rst) begin
            // Si el sistema está en reset, reiniciar los contadores y registros
				AMARILLO= 'h07FF;
            pixel_counter <= 'b0; // Reiniciar el contador de píxeles
            current_pixel <= 'b0; // Reiniciar el píxel actual
            transmission_done <= 'b0; // Reiniciar la señal de transmisión completa
        end else if (!transmission_done) begin
            // Si no se ha completado la transmisión, cargar el siguiente píxel
            current_pixel <= AMARILLO;//pixel_data_mem[pixel_counter]; // Cargar el píxel actual 
            pixel_counter <= pixel_counter + 'b1; // Incrementar el contador de píxeles
            if (pixel_counter == RESOLUTION-1) begin
                // Si se han transmitido todos los píxeles, marcar la transmisión como completada
                transmission_done <= 'b1; 
            end
        end
    end

    // Instancia del controlador de la pantalla ILI9163
    ili9163_controller ili9163(
			     .clk(clk_out),  // Conectar el reloj de 12MHz
              .rst(rst),  // Conectar la señal de reinicio
		.frame_done(transmission_done),  // Indicar si la transmisión ha terminado
		.input_data(current_pixel),  // Enviar el píxel actual al controlador
		.spi_mosi(spi_mosi),  // Conectar la línea MOSI del SPI
				  .spi_sck(spi_sck),  // Conectar la línea de reloj (sck) SPI
		.spi_cs(spi_cs),  // Conectar la línea de selección de chip SPI
		.spi_dc(spi_dc),  // Conectar la línea de control de datos/comandos SPI
		.data_clk(clk_input_data)  // Recibir la señal de reloj para la transmisión de datos
    );

endmodule
