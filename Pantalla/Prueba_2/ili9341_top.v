//`include "ili9341_controller.v"
//`include "freq_divider.v"


module ili9341_top #(parameter RESOLUTION = 128*128, parameter PIXEL_SIZE = 16)(
//        input clk, //125MHz
//        input rst,
//        output spi_mosi,
//        output spi_cs,
//        output spi_sck,
//        output spi_dc

        input clk, //125MHz
        input rst,
		  input test,
		  
//		  input [3:0] state,
		  input salud,
		  input animo,
		  input comida,
		  input energia,
		  
		  input jugar,
		  input comer,
		  input curar,
		  input dormir,
		  input calor,
        
		  output spi_mosi,
        output spi_cs,
        output spi_sck,
        output spi_dc
    );

    wire clk_out;
    wire clk_input_data;
	 //reg [PIXEL_SIZE-1:0] AMARILLO;
    reg [PIXEL_SIZE-1:0] current_pixel;
    reg [PIXEL_SIZE-1:0] pixel_data_mem [0:RESOLUTION-1];

    reg [$clog2(RESOLUTION)-1:0] pixel_counter;
    reg transmission_done;
	 
	 reg state_hambriento;
	 reg state_enfermo;
	 reg state_triste;
	 reg state_cansado;

    initial begin
        current_pixel <= 'b0;
        $readmemh("C:/Users/nicol/Documents/Quartus/Pantalla/Prueba_2/toad_base_s.txt", pixel_data_mem);
        pixel_counter <= 'b0;
        transmission_done <= 'b0;
		  state_hambriento <= 1'b1;
		  state_enfermo <= 1'b1;
		  state_triste <= 1'b1;
		  state_cansado <= 1'b1;
    end

    freq_divider #(4) freq_divider20MHz (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );  

    always @(posedge clk_input_data) begin
        if (rst==0) begin
            pixel_counter <= 'b0;
            current_pixel <= 'b0;
            transmission_done <= 'b0; 
        end else if (!transmission_done) begin
            current_pixel <= pixel_data_mem[pixel_counter];
//---------------------------------------------------------------------------------------------------------------------------
				if(state_hambriento) begin
                
					 if((pixel_counter >= 7372) && (pixel_counter <= 7377)) begin 	//Primera columna, ojo 1
							current_pixel <= 16'hff14;											//Pone color piel
							if (pixel_counter == 7372)  begin								//Pone pixeles negros para dibujar el ojo
								 current_pixel <= 16'h0000; // Negro
							end else if ((pixel_counter == 7377)) begin
								 current_pixel <= 16'h0000; // Negro
							end
							 
					 end else if((pixel_counter >= 7500) && (pixel_counter <= 7505)) begin
							current_pixel <= 16'hff14;
							if (pixel_counter == 7501)  begin
								 current_pixel <= 16'h0000; // Negro
							end else if ((pixel_counter == 7504)) begin
								 current_pixel <= 16'h0000; // Negro
							end
							 
					 end else if((pixel_counter >= 7628) && (pixel_counter <= 7633)) begin
							current_pixel <= 16'hff14;
							if (pixel_counter == 7630)  begin
								 current_pixel <= 16'h0000; // Negro
							end else if ((pixel_counter == 7631)) begin
								 current_pixel <= 16'h0000; // Negro
							end
							 
					 end else if((pixel_counter >= 8780) && (pixel_counter <= 8785)) begin
							current_pixel <= 16'hff14;
							if (pixel_counter == 8782)  begin
								  current_pixel <= 16'h0000; // Negro
							 end else if ((pixel_counter == 8783)) begin
								  current_pixel <= 16'h0000; // Negro
							 end
					 end else if((pixel_counter >= 8908) && (pixel_counter <= 8913)) begin
							current_pixel <= 16'hff14;
							if (pixel_counter == 8909)  begin
								 current_pixel <= 16'h0000; // Negro
							end else if ((pixel_counter == 8912)) begin
								 current_pixel <= 16'h0000; // Negro
							end
							 
					 end else if((pixel_counter >= 9036) && (pixel_counter <= 9041)) begin
							current_pixel <= 16'hff14;
							if (pixel_counter == 9036)  begin
								 current_pixel <= 16'h0000; // Negro
							end else if ((pixel_counter == 9041)) begin
								 current_pixel <= 16'h0000; // Negro
							end
					 end
					 
            end else if (state_hambriento == 0) begin 
					 
					 if((pixel_counter >= 7372) && (pixel_counter <= 7377)) begin 	
							current_pixel <= 16'hff14;											
							if ((pixel_counter >= 7373) && (pixel_counter <= 7376))  begin
								 current_pixel <= 16'h0000; // Negro
							end
							
					 end else if((pixel_counter >= 7500) && (pixel_counter <= 7505)) begin
							current_pixel <= 16'hff14;
							current_pixel <= 16'h0000;
							
					 end else if((pixel_counter >= 7628) && (pixel_counter <= 7633)) begin
							current_pixel <= 16'hff14;
							if ((pixel_counter >= 7629) && (pixel_counter <= 7632))  begin
								 current_pixel <= 16'h0000; // Negro
							end 
					 end else if((pixel_counter >= 8780) && (pixel_counter <= 8785)) begin 	
							current_pixel <= 16'hff14;											
							if ((pixel_counter >= 8781) && (pixel_counter <= 8784))  begin
								 current_pixel <= 16'h0000; // Negro
							end
							
					 end else if((pixel_counter >= 8908) && (pixel_counter <= 8913)) begin
							current_pixel <= 16'hff14;
							current_pixel <= 16'h0000;
							
					 end else if((pixel_counter >= 9036) && (pixel_counter <= 9041)) begin
							current_pixel <= 16'hff14;
							if ((pixel_counter >= 9037) && (pixel_counter <= 9040))  begin
								 current_pixel <= 16'h0000; // Negro
							end 
					 end 
				end
				
				if(state_enfermo) begin
					if ((pixel_counter >= 6866) && (pixel_counter <= 6869))  begin
                    current_pixel <= 16'h4dac; // Negro
                end else if ((pixel_counter >= 6994) && (pixel_counter <= 6997)) begin
                    current_pixel <= 16'h4dac; // Negro
                end else if ((pixel_counter >= 7122) && (pixel_counter <= 7125)) begin
                    current_pixel <= 16'h4dac; // Negro
                end else if ((pixel_counter >= 9298) && (pixel_counter <= 9301)) begin
                    current_pixel <= 16'h4dac; // Negro
                end else if ((pixel_counter >= 9426) && (pixel_counter <= 9429)) begin
                    current_pixel <= 16'h4dac; // Negro
                end else if ((pixel_counter >= 9554) && (pixel_counter <= 9557)) begin
                    current_pixel <= 16'h4dac; // Negro
                end 
				end
				
				if(state_triste) begin
					if (pixel_counter == 7512)  begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 7639)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 7766)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 7894)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 8022)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 8150)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 8278)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 8406)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 8534)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 8662)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 8791)) begin
                    current_pixel <= 16'h0000; // Negro
                end else if ((pixel_counter == 8920)) begin
                    current_pixel <= 16'h0000; // Negro
                end
				end
				
				if(state_cansado) begin
					if ((pixel_counter >= 5687) && (pixel_counter <= 5689))  begin
                    current_pixel <= 16'h3ef8; // Negro
                end else if ((pixel_counter >= 5813) && (pixel_counter <= 5818)) begin
                    current_pixel <= 16'h3ef8; // Negro
                end else if ((pixel_counter >= 5941) && (pixel_counter <= 5946)) begin
                    current_pixel <= 16'h3ef8; // Negro
                end else if ((pixel_counter >= 6071) && (pixel_counter <= 6073)) begin
                    current_pixel <= 16'h3ef8; // Negro
                end

				end
//---------------------------------------------------------------------------------------------------------------------------            		
            pixel_counter <= pixel_counter + 'b1;
            if (pixel_counter == RESOLUTION-1) begin
                transmission_done <= 'b1; 
            end
        end
    end

    ili9341_controller ili9341(
		.clk(clk_out), 
		.rst(rst),
        .frame_done(transmission_done), 
        .input_data(current_pixel),
        .spi_mosi(spi_mosi),
		.spi_sck(spi_sck), 
        .spi_cs(spi_cs), 
        .spi_dc(spi_dc),
        .data_clk(clk_input_data)
    );

endmodule