//`include "display_controller.v"
//`include "divisor.v"

module dht#(
    parameter MAX_COUNT = 10000000
)(
    input wire clk,                // Reloj del sistema (50 MHz)
    input wire rst,                // Reset del sistema
    inout wire dht11,              // Línea de datos del sensor DHT11
    output reg valid_data,         // Indicador de datos válidos
    output reg led,
    //--------------------------- 7 segmentos----------------------
    output wire [6:0] seg,        // Conectar a los pines del display de 7 segmentos
    output [7:0] an
);

    // Registros internos
    reg [31:0] timer;              // Temporizador para generar pulsos de tiempo
    reg [3:0] state;               // Estado del FSM
    reg [39:0] data;               // Datos leídos del sensor
    reg dht11_out;                 // Señal de salida para el pin bidireccional
    reg dht11_dir;                 // Dirección del pin (0: entrada, 1: salida)
    reg [5:0] bit_index;           // Índice del bit a leer
    reg [15:0] humidity;           // Humedad leída
    reg [15:0] temperature;        // Temperatura leída
    reg [7:0] aju_h;               // Ajuste humedad
    reg [7:0] aju_t;               // Ajuste temperatura
    reg [$clog2(MAX_COUNT)-1:0] counter; // Contador

    // Asignación bidireccional
    assign dht11 = dht11_dir ? dht11_out : 1'bz; // Multiplexor

    // Definición de estados
    localparam ENABLE = 4'd0,
               START_SIGNAL = 4'd1,
               WAIT_RESPONSE_HIGH = 4'd2,
               WAIT_RESPONSE_LOW = 4'd3,
               READ_DATA = 4'd4,
               WAIT = 4'd5,
               PROCESS_DATA = 4'd6;

    // Temporización para generar la señal de inicio
    localparam T_MEDIDA = 25000000;   // Cantidad de ciclos por reloj para el tiempo de medida
    localparam T_START = 900000;      // 18 ms con reloj de 50 MHz
    localparam T_WAIT = 2000;         // 40 µs con reloj de 50 MHz
    localparam T_RESPONSE = 8000;     // 80 µs con reloj de 50 MHz

    // Inicialización de señales
    initial begin
        state = ENABLE;
        timer = 0;
        humidity[3:0] = 4'b1011;   // 1 
        humidity[7:4] = 4'b1010;   // 2
        // humidity[11:8] = 5'b11111; // 3
        // humidity[15:12] = 5'b11111; // 4
        temperature[3:0] = 4'b1011; // 1 
        temperature[7:4] = 4'b1011; // 2
        // temperature[11:8] = 5'b11111; // 3
        // temperature[15:12] = 5'b11111; // 4
        //aju_t = 8'b00011000; //24°
        led = 1;
        counter = 0;
    end


    divisor aat(
        .clkd(clk),
        .clk2(clk2)
    );

   // Contador para el ajuste de temperatura
    always @(posedge clk2) begin
        if (rst) begin
            counter <= 0;
        end else if (aju_t >= 8'b00010110) begin //22
            counter <= counter + 1;
				led=0;		
        end else begin
				led = 1;
		  end
		  
		if(counter >= 50000)begin
			led = 0;
		end
    end 

    // Máquina de estados
    always @(posedge clk or posedge rst) begin    
        if (rst) begin
            state <= ENABLE;
            timer <= 0;
            dht11_out <= 1;
            dht11_dir <= 0;
            bit_index <= 0;
        end else begin
            case (state)
                ENABLE: begin
                    if (timer < T_MEDIDA) begin
                        timer <= timer + 1;
                    end else begin
                        timer <= 0;
                        dht11_dir <= 0; // Pin en modo entrada
                        state <= START_SIGNAL;
                    end
                end
                START_SIGNAL: begin
                    if (timer < T_START) begin // Contador de los primeros 18ms
                        timer <= timer + 1;
                        dht11_dir <= 1; // Pin en modo salida
                        dht11_out <= 0; // Mantener la línea baja
                    end else begin
                        timer <= 0;
                        dht11_out <= 1; // Mantener la línea baja
                        state <= WAIT_RESPONSE_LOW;
                    end
                end
                WAIT_RESPONSE_HIGH: begin
                    if (timer < T_WAIT) begin
                        timer <= timer + 1;
                        dht11_dir <= 1; // Pin en modo salida para enviar durante 40 µs
                    end else if (!dht11) begin
                        timer <= 0;
                        state <= WAIT_RESPONSE_HIGH;
                    end
                end
                WAIT_RESPONSE_LOW: begin
                    if (timer < T_RESPONSE) begin
                        timer <= timer + 1;
                        dht11_out <= 1;
                        dht11_dir <= 0;
                    end else if (dht11) begin
                        timer <= 0;
                        state <= READ_DATA;
                    end
                end
                READ_DATA: begin
                    if (bit_index < 40) begin
                        if (timer < 3900) begin
                            timer <= timer + 1;
                        end else begin
                            data = data << 1;
                            if (dht11) begin
                                data[0] = 1;
                                state <= WAIT;
                            end else begin
                                data[0] = 0;
                            end
                            bit_index <= bit_index + 1;
                            timer <= 0;
                        end
                    end else begin
                        bit_index <= 0;
                        state <= PROCESS_DATA;
                    end
                end
                WAIT: begin
                    if (timer < 2100) begin
                        timer <= timer + 1;
                    end else begin
                        timer <= 0;
                        state <= READ_DATA;
                    end
                end
                PROCESS_DATA: begin
                    valid_data <= 1;
                    aju_h = data[39:32] - 8'b00101000;
                    aju_t = data[23:16] - 8'b00000111;
                    //aju_t = 8'b00011000;
                    humidity[15:12] = (aju_h / 10) % 10; // 1
                    humidity[11:8] = aju_h % 10; // 2
                    humidity[7:4] = 4'b1100; // 3
                    humidity[3:0] = 4'b1010; // 4 
                    temperature[15:12] = (aju_t / 10) % 10; // 1
                    temperature[11:8] = aju_t % 10; // 2
                    temperature[7:4] = 4'b1010; // 3
                    temperature[3:0] = 4'b1101; // 4 
                    timer <= 0;
                    state <= ENABLE;
                    
                    /*if (aju_t >= 8'b00010110) begin
                        led = 0;
                    end else begin
                        led = 1;
                        counter <= 0;
                    end*/
                end
            endcase
        end
    end

    // Instanciación del controlador de display
    display_controller display_ctrl (
        .clk(clk),
        .value1(humidity),
        .value2(temperature),
        .an(an),
        .seg(seg)
    );
endmodule
