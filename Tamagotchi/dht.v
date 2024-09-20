module dht#(parameter MAX_COUNT = 10000000)
(
    input wire clk,                // Reloj del sistema (50 MHz)
	 input test_enable,
    input wire sns_active,                // Reset del sistema
    inout wire dht11,              // Línea de datos del sensor DHT11
    output reg valid_data,         // Indicador de datos válidos
    output reg temp_out
);

    // Registros internos
    reg [31:0] timer;              // Temporizador para generar pulsos de tiempo
    reg [3:0] state;               // Estado del FSM
    reg [39:0] data;               // Datos leídos del sensor
    reg dht11_out;                 // Señal de salida para el pin bidireccional
    reg dht11_dir;                 // Dirección del pin (0: entrada, 1: salida)
    reg [5:0] bit_index;           // Índice del bit a leer
//    reg [15:0] humidity;           // Humedad leída
    reg [15:0] temperature;        // Temperatura leída
//    reg [7:0] aju_h;               // Ajuste humedad
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
//        humidity[3:0] = 4'b1011;   // 1 
//        humidity[7:4] = 4'b1010;   // 2
        // humidity[11:8] = 5'b11111; // 3
        // humidity[15:12] = 5'b11111; // 4
        temperature[3:0] = 4'b1011; // 1 
        temperature[7:4] = 4'b1011; // 2
        // temperature[11:8] = 5'b11111; // 3
        // temperature[15:12] = 5'b11111; // 4
        //aju_t = 8'b00011000; //24°
        temp_out = 1;
        counter = 0;
    end


    divisor div_dht(
        .clk_in(clk),
		  .freq_out(14'd10000),
        .clk_out(clk2)
    );

   // Contador para el ajuste de temperatura
    always @(posedge clk2) begin
		if (test_enable==0) begin
			  
			  if (sns_active) begin
					counter <= 0;
			  end else if (aju_t >= 8'b00010110) begin //22
					counter <= counter + 1;
					temp_out=0;		
			  end else begin
					temp_out = 1;
			  end
			  
			if(counter >= 50000)begin
				temp_out = 0;
			end

      end
    end 

    // Máquina de estados
	always @(posedge clk or posedge sns_active) begin

		if (sns_active) begin
			state <= ENABLE;
			timer <= 0;
			dht11_out <= 1;
			dht11_dir <= 0;
			bit_index <= 0;
		end else begin

			case (state)

				ENABLE: begin
					if(test_enable==0)begin
						if (timer < T_MEDIDA) begin
							timer <= timer + 1;
						end else begin
							timer <= 0;
							dht11_dir <= 0; // Pin en modo entrada
							state <= START_SIGNAL;
						end
					end					
				end
				
				START_SIGNAL: begin
					if(test_enable==0)begin
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
				end
				
				WAIT_RESPONSE_HIGH: begin
					if(test_enable==0)begin
						if (timer < T_WAIT) begin
							timer <= timer + 1;
							dht11_dir <= 1; // Pin en modo salida para enviar durante 40 µs
						end else if (!dht11) begin
							timer <= 0;
							state <= WAIT_RESPONSE_HIGH;
						end
					end
				end

				WAIT_RESPONSE_LOW: begin
					if(test_enable==0)begin
						if (timer < T_RESPONSE) begin
							timer <= timer + 1;
							dht11_out <= 1;
							dht11_dir <= 0;
						end else if (dht11) begin
							timer <= 0;
							state <= READ_DATA;
						end
					end
				end

				READ_DATA: begin
					if(test_enable==0)begin
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
				end
				
				WAIT: begin
					if(test_enable==0)begin
						if (timer < 2100) begin
							timer <= timer + 1;
						end else begin
							timer <= 0;
							state <= READ_DATA;
						end
					end
				end

				PROCESS_DATA: begin
					if(test_enable==0)begin
						valid_data <= 1;
						aju_t = data[23:16] - 8'b00000111;
						temperature[15:12] = (aju_t / 10) % 10; // 1
						temperature[11:8] = aju_t % 10; // 2
						temperature[7:4] = 4'b1010; // 3
						temperature[3:0] = 4'b1101; // 4 
						timer <= 0;
						state <= ENABLE;
					end
				end
			endcase	
		end   
	end
endmodule
