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
//		  input [3:0] cambios,	
		  
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
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	 
	 reg state_hambriento;
	 reg state_enfermo;
	 reg state_triste;
	 reg state_cansado;
	 reg state_muerto;
	 reg anim_comer;
	 reg anim_dormir;
	 reg anim_jugar;
	 reg anim_curar;
	 reg anim_temp;
	 reg anim_test;
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    initial begin
        current_pixel <= 'b0;
        $readmemh("C:/Users/usuario/Documents/GitHub/entrega-1-proyecto-grupo21-2024-1/Pantalla/Prueba_2/Toad_corregido.txt", pixel_data_mem);
        pixel_counter <= 'b0;
        transmission_done <= 'b0;
		  state_hambriento <= 1'b1;
		  state_enfermo <= 1'b1;
		  state_triste <= 1'b1;
		  state_cansado <= 1'b1;
		  state_muerto <= 1'b1;
		  anim_comer <= 1'b1; 
		  anim_jugar <= 1'b1;
		  anim_temp <= 1'b1;
		  anim_test <= 1'b1;
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
//-----------ANIMACIONES DE LOS ESTADOS---------------------------------------------------------------------------

// HAMBRIENTO
if (state_hambriento == 0) begin
    if ((pixel_counter >= 7372) && (pixel_counter <= 7377)) begin // Ojo 1
        current_pixel <= 16'hff14; // Color piel
        if (pixel_counter == 7372) current_pixel <= 16'h0000; // Negro
        else if (pixel_counter == 7377) current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 7500) && (pixel_counter <= 7505)) begin
        current_pixel <= 16'hff14; // Color piel
        if (pixel_counter == 7501) current_pixel <= 16'h0000; // Negro
        else if (pixel_counter == 7504) current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 7628) && (pixel_counter <= 7633)) begin
        current_pixel <= 16'hff14; // Color piel
        if (pixel_counter == 7630) current_pixel <= 16'h0000; // Negro
        else if (pixel_counter == 7631) current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 8780) && (pixel_counter <= 8785)) begin
        current_pixel <= 16'hff14; // Color piel
        if (pixel_counter == 8782) current_pixel <= 16'h0000; // Negro
        else if (pixel_counter == 8783) current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 8908) && (pixel_counter <= 8913)) begin
        current_pixel <= 16'hff14; // Color piel
        if (pixel_counter == 8909) current_pixel <= 16'h0000; // Negro
        else if (pixel_counter == 8912) current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 9036) && (pixel_counter <= 9041)) begin
        current_pixel <= 16'hff14; // Color piel
        if (pixel_counter == 9036) current_pixel <= 16'h0000; // Negro
        else if (pixel_counter == 9041) current_pixel <= 16'h0000; // Negro
    end
end else if (state_hambriento) begin
    if ((pixel_counter >= 7372) && (pixel_counter <= 7377)) begin
        current_pixel <= 16'hff14; // Color piel
        if ((pixel_counter >= 7373) && (pixel_counter <= 7376)) current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 7500) && (pixel_counter <= 7505)) begin
        current_pixel <= 16'hff14; // Color piel
        current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 7628) && (pixel_counter <= 7633)) begin
        current_pixel <= 16'hff14; // Color piel
        if ((pixel_counter >= 7629) && (pixel_counter <= 7632)) current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 8780) && (pixel_counter <= 8785)) begin
        current_pixel <= 16'hff14; // Color piel
        if ((pixel_counter >= 8781) && (pixel_counter <= 8784)) current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 8908) && (pixel_counter <= 8913)) begin
        current_pixel <= 16'hff14; // Color piel
        current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 9036) && (pixel_counter <= 9041)) begin
        current_pixel <= 16'hff14; // Color piel
        if ((pixel_counter >= 9037) && (pixel_counter <= 9040)) current_pixel <= 16'h0000; // Negro
    end
end

// ENFERMO
if (state_enfermo) begin
    if ((pixel_counter >= 6866) && (pixel_counter <= 6869)) current_pixel <= 16'hfe32; // Color amarillo
    else if ((pixel_counter >= 6994) && (pixel_counter <= 6997)) current_pixel <= 16'hfe32; // Color amarillo
    else if ((pixel_counter >= 7122) && (pixel_counter <= 7125)) current_pixel <= 16'hfe32; // Color amarillo
    else if ((pixel_counter >= 9298) && (pixel_counter <= 9301)) current_pixel <= 16'hfe32; // Color amarillo
    else if ((pixel_counter >= 9426) && (pixel_counter <= 9429)) current_pixel <= 16'hfe32; // Color amarillo
    else if ((pixel_counter >= 9554) && (pixel_counter <= 9557)) current_pixel <= 16'hfe32; // Color amarillo
end else if (state_enfermo == 0) begin
    if ((pixel_counter >= 6866) && (pixel_counter <= 6869)) current_pixel <= 16'h4dac; // Color verde
    else if ((pixel_counter >= 6994) && (pixel_counter <= 6997)) current_pixel <= 16'h4dac; // Color verde
    else if ((pixel_counter >= 7122) && (pixel_counter <= 7125)) current_pixel <= 16'h4dac; // Color verde
    else if ((pixel_counter >= 9298) && (pixel_counter <= 9301)) current_pixel <= 16'h4dac; // Color verde
    else if ((pixel_counter >= 9426) && (pixel_counter <= 9429)) current_pixel <= 16'h4dac; // Color verde
    else if ((pixel_counter >= 9554) && (pixel_counter <= 9557)) current_pixel <= 16'h4dac; // Color verde
end

// TRISTE
if (state_triste) begin
    if (pixel_counter == 7510) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 7639) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 7768) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 7896) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8024) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8152) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8280) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8408) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8536) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8664) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8791) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8918) current_pixel <= 16'h0000; // Negro
end else if (state_triste == 0) begin
    if (pixel_counter == 7512) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 7639) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 7766) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 7894) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8022) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8150) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8278) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8406) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8534) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8662) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8791) current_pixel <= 16'h0000; // Negro
    else if (pixel_counter == 8920) current_pixel <= 16'h0000; // Negro
end

// CANSADO
if (state_cansado) begin
    if ((pixel_counter >= 5687) && (pixel_counter <= 5689)) current_pixel <= 16'hffff; // Color blanco
    else if ((pixel_counter >= 5813) && (pixel_counter <= 5818)) current_pixel <= 16'hffff; // Color blanco
    else if ((pixel_counter >= 5941) && (pixel_counter <= 5946)) current_pixel <= 16'hffff; // Color blanco
    else if ((pixel_counter >= 6071) && (pixel_counter <= 6073)) current_pixel <= 16'hffff; // Color blanco
end else if (state_cansado == 0) begin
    if ((pixel_counter >= 5689) && (pixel_counter <= 5691)) current_pixel <= 16'h0000; // Negro
    else if ((pixel_counter >= 5815) && (pixel_counter <= 5820)) current_pixel <= 16'h0000; // Negro
    else if ((pixel_counter >= 5943) && (pixel_counter <= 5948)) current_pixel <= 16'h0000; // Negro
    else if ((pixel_counter >= 6073) && (pixel_counter <= 6075)) current_pixel <= 16'h0000; // Negro
end

// MUERTO
if (state_muerto == 0) begin
    if ((pixel_counter >= 7372) && (pixel_counter <= 7377)) begin  // Ojo 1
        current_pixel <= 16'hff14;  // Color piel
        if ((pixel_counter == 7374) || (pixel_counter == 7375)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 7500) && (pixel_counter <= 7505)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 7500) || (pixel_counter == 7501)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 7628) && (pixel_counter <= 7633)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 7630) || (pixel_counter == 7631)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8780) && (pixel_counter <= 8785)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 8782) || (pixel_counter == 8783)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8908) && (pixel_counter <= 8913)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 8908) || (pixel_counter == 8909)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 9036) && (pixel_counter <= 9041)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 9038) || (pixel_counter == 9039)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 7510) && (pixel_counter <= 7512)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 7511) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 7638) && (pixel_counter <= 7640)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 7639) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 7766) && (pixel_counter <= 7768)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 7767) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 7894) && (pixel_counter <= 7896)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 7895) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8022) && (pixel_counter <= 8024)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 8023) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8150) && (pixel_counter <= 8152)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 8151) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8278) && (pixel_counter <= 8280)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 8279) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8406) && (pixel_counter <= 8408)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 8407) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8534) && (pixel_counter <= 8536)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 8535) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8662) && (pixel_counter <= 8664)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 8663) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8790) && (pixel_counter <= 8792)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 8791) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8918) && (pixel_counter <= 8920)) begin
        current_pixel <= 16'hff14;
        if (pixel_counter == 8919) begin
            current_pixel <= 16'h0000; // Negro
        end
    end
end

// -----------ANIMACIONES DE LAS ACCIONES---------------------------------------------------------------------------

// COMER
if (anim_comer) begin
    // Primer bloque de condiciones
    if ((pixel_counter >= 7510) && (pixel_counter <= 7513)) begin
        if (pixel_counter == 7512 || pixel_counter == 7513) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 7638) && (pixel_counter <= 7641)) begin
        if (pixel_counter == 7639 || pixel_counter == 7641) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 7766) && (pixel_counter <= 7769)) begin
        if (pixel_counter == 7766 || pixel_counter == 7769) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 7894) && (pixel_counter <= 7897)) begin
        if (pixel_counter == 7894 || pixel_counter == 7897) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 8022) && (pixel_counter <= 8025)) begin
        if (pixel_counter == 8022 || pixel_counter == 8025) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 8150) && (pixel_counter <= 8153)) begin
        if (pixel_counter == 8150 || pixel_counter == 8153) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 8278) && (pixel_counter <= 8281)) begin
        if (pixel_counter == 8278 || pixel_counter == 8281) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 8406) && (pixel_counter <= 8409)) begin
        if (pixel_counter == 8406 || pixel_counter == 8409) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 8534) && (pixel_counter <= 8537)) begin
        if (pixel_counter == 8534 || pixel_counter == 8537) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 8662) && (pixel_counter <= 8665)) begin
        if (pixel_counter == 8662 || pixel_counter == 8665) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 8790) && (pixel_counter <= 8793)) begin
        if (pixel_counter == 8791 || pixel_counter == 8793) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end else if ((pixel_counter >= 8918) && (pixel_counter <= 8921)) begin
        if (pixel_counter == 8918 || pixel_counter == 8921) begin
            current_pixel <= 16'h91e4; // Negro
        end else begin
            current_pixel <= 16'hff14; // Otro color
        end
    end
end

// DORMIR
if (anim_dormir) begin
    if ((pixel_counter >= 7372) && (pixel_counter <= 7377)) begin
        current_pixel <= 16'hff14;  // Pone color piel
        if ((pixel_counter == 7374) || (pixel_counter == 7375)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 7500) && (pixel_counter <= 7505)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 7500) || (pixel_counter == 7501)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 7628) && (pixel_counter <= 7633)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 7630) || (pixel_counter == 7631)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8780) && (pixel_counter <= 8785)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 8782) || (pixel_counter == 8783)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 8908) && (pixel_counter <= 8913)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 8908) || (pixel_counter == 8909)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 9036) && (pixel_counter <= 9041)) begin
        current_pixel <= 16'hff14;
        if ((pixel_counter == 9038) || (pixel_counter == 9039)) begin
            current_pixel <= 16'h0000; // Negro
        end 
    end else if ((pixel_counter >= 9917) && (pixel_counter <= 9921)) begin
        current_pixel <= 16'hffff;
        if ((pixel_counter == 9921)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 10045) && (pixel_counter <= 10049)) begin
        current_pixel <= 16'hffff;
        if ((pixel_counter == 10048) || (pixel_counter == 10049)) begin
            current_pixel <= 16'h0000; // Negro
        end 
    end else if ((pixel_counter >= 10301) && (pixel_counter <= 10305)) begin
        current_pixel <= 16'hffff;
        if ((pixel_counter == 10301) || (pixel_counter == 10303)) begin
            current_pixel <= 16'h0000; // Negro
        end  
    end else if ((pixel_counter >= 10429) && (pixel_counter <= 10433)) begin
        current_pixel <= 16'hffff;
        if ((pixel_counter == 10429) || (pixel_counter == 10431)) begin
            current_pixel <= 16'h0000; // Negro
        end  
    end else if ((pixel_counter >= 10557) && (pixel_counter <= 10561)) begin
        current_pixel <= 16'hffff;
        if ((pixel_counter == 10557) || (pixel_counter == 10559)) begin
            current_pixel <= 16'h0000; // Negro
        end  
    end
end

// JUGAR
if (anim_jugar) begin
    if ((pixel_counter >= 5071) && (pixel_counter <= 5075)) begin
        current_pixel <= 16'h45bc;  // Pone color piel
        if ((pixel_counter == 5072) || (pixel_counter == 5074)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 5199) && (pixel_counter <= 5203)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 5199) || (pixel_counter == 5203)) begin
            current_pixel <= 16'h0000; // Negro
        end else if ((pixel_counter == 5200) || (pixel_counter == 5202)) begin
            current_pixel <= 16'hffff;
        end
    end else if ((pixel_counter >= 5327) && (pixel_counter <= 5331)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 5327) || (pixel_counter == 5331)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 5455) && (pixel_counter <= 5459)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 5455) || (pixel_counter == 5459)) begin
            current_pixel <= 16'h0000; // Negro
        end else if ((pixel_counter == 5456) || (pixel_counter == 5458)) begin
            current_pixel <= 16'h578d;
        end
    end else if ((pixel_counter >= 5583) && (pixel_counter <= 5587)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 5584) || (pixel_counter == 5587)) begin
            current_pixel <= 16'h0000; // Negro
        end  
    end
end

// CURAR
if (anim_curar) begin
    if ((pixel_counter >= 7905) && (pixel_counter <= 7910)) begin
        current_pixel <= 16'h45bc;  // Pone color piel
        if ((pixel_counter == 7907) || (pixel_counter == 7908)) begin
            current_pixel <= 16'h4e8c; // Negro
        end
    end else if ((pixel_counter >= 8033) && (pixel_counter <= 8038)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 8035) || (pixel_counter == 8036)) begin
            current_pixel <= 16'h4e8c; // Negro
        end
    end else if ((pixel_counter >= 8161) && (pixel_counter <= 8166)) begin
        current_pixel <= 16'h4e8c; // Negro
    end else if ((pixel_counter >= 8289) && (pixel_counter <= 8294)) begin
        current_pixel <= 16'h4e8c; // Negro
    end else if ((pixel_counter >= 8417) && (pixel_counter <= 8422)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 8419) || (pixel_counter == 8420)) begin
            current_pixel <= 16'h4e8c; // Negro
        end
    end else if ((pixel_counter >= 8545) && (pixel_counter <= 8550)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 8547) || (pixel_counter == 8548)) begin
            current_pixel <= 16'h4e8c; // Negro
        end
    end
end

// TEMPERATURA
if (anim_temp) begin
    if ((pixel_counter >= 535) && (pixel_counter <= 539)) begin
        current_pixel <= 16'h45bc;  // Pone color piel
        if ((pixel_counter == 536) || (pixel_counter == 538)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 663) && (pixel_counter <= 667)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 663) || (pixel_counter == 667)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 791) && (pixel_counter <= 795)) begin
        current_pixel <= 16'h45bc;
        if ((pixel_counter == 791) || (pixel_counter == 795)) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 1047) && (pixel_counter <= 1051)) begin
        current_pixel <= 16'h45bc;
        if (pixel_counter == 1047) begin
            current_pixel <= 16'h0000; // Negro
        end  
    end
end

// TEST
if (anim_test) begin
    if ((pixel_counter >= 15255) && (pixel_counter <= 15259)) begin
        current_pixel <= 16'h45bc;  // Pone color piel
        if (pixel_counter == 15255) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 15383) && (pixel_counter <= 15387)) begin
        current_pixel <= 16'h45bc;
        if (pixel_counter == 15383) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 15511) && (pixel_counter <= 15515)) begin
        current_pixel <= 16'h0000; // Negro
    end else if ((pixel_counter >= 15639) && (pixel_counter <= 15643)) begin
        current_pixel <= 16'h45bc;
        if (pixel_counter == 15639) begin
            current_pixel <= 16'h0000; // Negro
        end
    end else if ((pixel_counter >= 15767) && (pixel_counter <= 15771)) begin
        current_pixel <= 16'h45bc;
        if (pixel_counter == 15767) begin
            current_pixel <= 16'h0000; // Negro
        end
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