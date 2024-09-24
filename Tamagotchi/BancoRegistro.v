module BancoRegistro #(
	parameter SECONDS_IN_MINUTE = 60,
	parameter MINUTES_TO_INCREMENT_DAYS = 2,
	parameter TAU = 50
)
(	input clk,
	input rst,
	input test,

	input btn_back,
	input btn_next,
	input btn_comer_inc,     		   
	input btn_curar_dec,
	
	input sns_prox,
	input sns_temp,
	input sns_luz,	 
	
// Pruebas display
	output reg [3:0] stat_name, 		
	output reg [5:0] stat_value, 

	output reg [3:0] state,

	output [2:0] datOutSalud,
	output [2:0] datOutAnimo,
	output [2:0] datOutComida,
	output [2:0] datOutEnergia,
	output [5:0] datOutdias
);

	reg [2:0] SALUD;     			 
	reg [2:0] ANIMO;      
	reg [2:0] COMIDA;     
	reg [2:0] ENERGIA;
	reg [3:0] STATE;					
	reg [5:0] DIAS;
	reg [3:0] reg_stat;   			
	reg [31:0] second_counter;		
	reg [31:0] minute_counter;
	reg [31:0] tau_counter;  	
	
	reg time_enable;
	reg back_enable;
	reg next_enable;
	reg comer_enable;
	reg curar_enable;
	reg luz_enable;
	reg prox_enable;
	reg temp_enable;
	

	initial begin
		SALUD   = 3'd5;
		ANIMO   = 3'd5;
		COMIDA  = 3'd5;
		ENERGIA = 3'd5;
		DIAS    = 6'd0;
		STATE   = 4'b1111;
		reg_stat = 4'd0;
		second_counter = 32'd0;
		minute_counter = 32'd0;
		tau_counter = 32'd0;

		time_enable <= 1'b1;
		back_enable <= 1'b1;
		next_enable <= 1'b1;
		comer_enable <= 1'b1;
		curar_enable <= 1'b1;
		luz_enable <= 1'b1;
		prox_enable <= 1'b1;
		temp_enable <= 1'b1;

	end

	wire wDiv_btn;

	divisor div_btn(
		.clk_in(clk),
		.freq_out(3'd5),
		.clk_out(wDiv_btn)
	);

	always @(posedge (wDiv_btn)) begin
	
		if (rst == 0) begin

			SALUD   	 <= 3'd5;
			ANIMO   	 <= 3'd5;
			COMIDA  	 <= 3'd5;
			ENERGIA 	 <= 3'd5;
			DIAS	 	 <= 6'd0;
			STATE		 <= 4'd15;
			second_counter <= 32'd0;
			minute_counter <= 32'd0;
			tau_counter <= 32'd0;
			
			time_enable <= 1'd1;
			back_enable <= 1'b1;
			next_enable <= 1'b1;
			comer_enable <= 1'b1;
			curar_enable <= 1'b1;
			luz_enable <= 1'b1;
			prox_enable <= 1'b1;
			temp_enable <= 1'b1;

		end else begin
		
			if (STATE == 4'b0000) begin
				SALUD			<= 3'd0;
				ANIMO			<= 3'd0;
				COMIDA		<= 3'd0;
				ENERGIA		<= 3'd0;
				DIAS			<= 6'd0;
				time_enable <= 1'd0;
				
				comer_enable <= 1'b0;
				curar_enable <= 1'b0;
				back_enable  <= 1'b0;
				next_enable  <= 1'b0;
				luz_enable   <= 1'b0;
				prox_enable  <= 1'b0;
				temp_enable  <= 1'b0;
			end
		
			if (SALUD < 3'd2 && STATE[3] == 1'b1) begin
				STATE <= {1'b0, STATE[2:0]}; 
			end else if (SALUD >= 3'd2 && STATE[3] == 1'b0) begin
				STATE <= {1'b1, STATE[2:0]};
			end
			
			if (ANIMO < 3'd2 && STATE[2] == 1'b1) begin
				STATE <= {STATE[3], 1'b0, STATE[1:0]}; 
			end else if (ANIMO >= 3'd2 && STATE[2] == 1'b0) begin
				STATE <= {STATE[3], 1'b1, STATE[1:0]};
			end
			
			if (COMIDA < 3'd2 && STATE[1] == 1'b1) begin
				STATE <= {STATE[3:2], 1'b0, STATE[0]}; 
			end else if (COMIDA >= 3'd2 && STATE[1] == 1'b0) begin
				STATE <= {STATE[3:2], 1'b1, STATE[0]};
			end
			
			if (ENERGIA < 3'd2 && STATE[0] == 1'b1) begin
				STATE <= {STATE[3:1],1'b0}; 
			end else if (ENERGIA >= 3'd2 && STATE[0] == 1'b0) begin
				STATE <= {STATE[3:1], 1'b1};
			end

			if (time_enable) begin
					
					if (second_counter < wDiv_btn * (150)) begin // 5*(tiempo_cambio) = multiplicador; 5 => 60s_divisor/12s_reales
						
						second_counter <= second_counter + 1;
					
					end else begin
					
						second_counter <= 32'd0;      // Reiniciar el contador de segundos
						minute_counter <= minute_counter + 1;  // Incrementar los minutos

						if (second_counter >= MINUTES_TO_INCREMENT_DAYS) begin
	//					if (minute_counter >= MINUTES_TO_INCREMENT_DAYS) begin
							minute_counter <= 32'd0;  
							DIAS <= DIAS + 1;         

							if (DIAS >= 6'd32) begin

								SALUD			<= 3'd0;
								ANIMO			<= 3'd0;
								COMIDA		<= 3'd0;
								ENERGIA		<= 3'd0;
								DIAS			<= 6'd0;
								STATE			<= 4'd0;
							
							end
						end
					end
					
					if (tau_counter < TAU) begin
						tau_counter <= tau_counter + 1;
					end else begin
						tau_counter <= 32'd0;
						
						SALUD   <= (SALUD > 3'd0) ? SALUD - 1 : SALUD;
						ANIMO   <= (ANIMO > 3'd0) ? ANIMO - 1 : ANIMO;
						COMIDA  <= (COMIDA > 3'd0) ? COMIDA - 1 : COMIDA;
						ENERGIA <= (ENERGIA > 3'd0) ? ENERGIA - 1 : ENERGIA;
					end
				end

				if (btn_next == 0 && next_enable) begin
					if (test == 1)begin
						reg_stat <= (reg_stat < 4'd9) ? reg_stat + 1 : 4'd0;
					end
				end

				if (btn_back == 0 && back_enable) begin
					if (test == 1) begin
						reg_stat <= (reg_stat > 4'd0) ? reg_stat - 1 : 4'd9;
					end
				end
				


				if (btn_comer_inc == 0 && comer_enable) begin
					if (test == 1)begin
						case (reg_stat)														
							
							4'd0: SALUD   <= (SALUD < 3'd5)   ? SALUD + 1   : SALUD;			
							4'd1: ANIMO   <= (ANIMO < 3'd5)   ? ANIMO + 1   : ANIMO;			
							4'd2: COMIDA  <= (COMIDA < 3'd5)  ? COMIDA + 1  : COMIDA;		
							4'd3: ENERGIA <= (ENERGIA < 3'd5) ? ENERGIA + 1 : ENERGIA;	
							4'd4: begin
										DIAS    <= (DIAS < 6'd32)   ? DIAS + 1 : 6'd0;
										SALUD   <= (DIAS >= 6'd32)  ? 4'd0     : SALUD;
										ANIMO   <= (DIAS >= 6'd32)  ? 4'd0     : ANIMO;
										COMIDA  <= (DIAS >= 6'd32)  ? 4'd0     : COMIDA;
										ENERGIA <= (DIAS >= 6'd32)  ? 4'd0     : ENERGIA;
										STATE   <= (DIAS >= 6'd32)  ? 4'd0     : STATE;
									end
							4'd5: STATE   <= (STATE < 4'd15)  ? STATE + 1   : STATE;
						
						endcase
						
					end else if (test == 0) begin
						
						SALUD <= (SALUD < 3'd5)  ? SALUD + 1 : SALUD;
						ANIMO <= (ANIMO < 3'd5)  ? ANIMO + 1 : ANIMO;
						COMIDA <= (COMIDA < 3'd5)  ? COMIDA + 1: COMIDA;
						ENERGIA <= (ENERGIA > 3'd0) ? ENERGIA + 1 : ENERGIA;
						
					end	
	
				end

				if (btn_curar_dec == 0 && curar_enable) begin
					if(test ==1)begin
						case (reg_stat)	
						
							4'd0: if (SALUD > 3'd0) SALUD <= SALUD - 1;			
							4'd1: if (ANIMO > 3'd0) ANIMO <= ANIMO - 1;			
							4'd2: if (COMIDA > 3'd0) COMIDA <= COMIDA - 1;		
							4'd3: if (ENERGIA > 3'd0) ENERGIA <= ENERGIA - 1;	
							4'd4: if (DIAS > 6'd0) DIAS <= DIAS - 1;
							4'd5: if (STATE > 4'd0) STATE <= STATE - 1;	
					
						endcase
					
					end else if (test == 0) begin
						
							SALUD <= (SALUD < 3'd5) ? SALUD + 1 : SALUD;
							ANIMO <= (ANIMO < 3'd5) ? ANIMO + 1 : ANIMO;
							
					end
						
				end
					
				if (sns_prox == 1 && prox_enable) begin	
					 COMIDA <= (COMIDA > 3'd0) ? COMIDA - 1 : COMIDA;
					 ANIMO <= (ANIMO < 3'd5) ? ANIMO + 1 : ANIMO;
					 ENERGIA <= (ENERGIA > 3'd0) ? ENERGIA - 1 : ENERGIA;
				end 
				
				if (sns_temp == 0 && temp_enable) begin
					SALUD <= (SALUD > 3'd0) ? SALUD - 1 : SALUD;
					ANIMO <= (ANIMO > 3'd0) ? ANIMO - 1 : ANIMO; 
				end 
				
				if (sns_luz == 0 && luz_enable) begin
					SALUD <= (SALUD < 3'd5) ? SALUD + 1 : SALUD;
					ANIMO <= (ANIMO < 3'd5) ? ANIMO + 1 : ANIMO;
					COMIDA <= (COMIDA > 3'd0) ? COMIDA - 1 : COMIDA;
					ENERGIA <= (ENERGIA > 3'd0) ? ENERGIA + 1 : ENERGIA;				  
				end 

				case (reg_stat)

					4'd0: begin
						stat_name <= 4'd5;     
						stat_value <= SALUD;
						state <= STATE;
					end

					4'd1: begin
						stat_name <= 4'ha;     
						stat_value <= ANIMO;
						state <= STATE;   
					end

					4'd2: begin
						stat_name <= 4'hc;     
						stat_value <= COMIDA;
						state <= STATE;  
					end

					4'd3: begin
						stat_name <= 4'he;     
						stat_value <= ENERGIA;
						state <= STATE; 
					end

					4'd4: begin
						stat_name <= 4'hd;     
						stat_value <= DIAS[5:0];
						state <= STATE; 
					end
					
					4'd5: begin
						stat_name <= 4'hf;     
						stat_value <= STATE;
						state <= STATE; 
					end
					
					4'd6: begin
						stat_name <= 4'h1;     
						stat_value <= sns_temp;
						state <= STATE; 			
					end
					4'd7: begin
						stat_name <= 4'h2;     
						stat_value <= sns_luz;
						state <= STATE; 
					end
					4'd8: begin
						stat_name <= 4'h3;     
						stat_value <= sns_prox;
						state <= STATE; 
					end
					4'd9: begin
						stat_name <= 4'h4;     
						stat_value <= test;
						state <= STATE; 
					end

				endcase
				
		end
		
	end
	
endmodule


//---------------------------------------------------------------------------------------------------------------------------	
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------


//module BancoRegistro #(
//	parameter SECONDS_IN_MINUTE = 60,
//	parameter MINUTES_TO_INCREMENT_DAYS = 2
//)
//(	input clk,
//	input rst,
//	input test,
//
//	input btn_back,
//	input btn_next,
//	input btn_comer_inc,     		   
//	input btn_curar_dec,
//	
//	input sns_prox,
//	input sns_temp,
//	input sns_luz,	 
//	
//// Pruebas display
//	output reg [3:0] stat_name, 		
//	output reg [5:0] stat_value, 
//
//	output reg [3:0] state,
//
//	output [2:0] datOutSalud,
//	output [2:0] datOutAnimo,
//	output [2:0] datOutComida,
//	output [2:0] datOutEnergia,
//	output [5:0] datOutdias
//);
//
//	reg [2:0] SALUD;     			 
//	reg [2:0] ANIMO;      
//	reg [2:0] COMIDA;     
//	reg [2:0] ENERGIA;
//	reg [3:0] STATE;					
//	reg [5:0] DIAS;
//	reg [3:0] reg_stat;   			
//	reg [31:0] second_counter;		
//	reg [31:0] minute_counter;  	
//	reg time_enable;
//	
//
//	initial begin
//		SALUD   = 3'd5;
//		ANIMO   = 3'd5;
//		COMIDA  = 3'd5;
//		ENERGIA = 3'd5;
//		DIAS    = 6'd0;
//		STATE   = 4'b1111;
//		reg_stat = 4'd0;
//		second_counter = 32'd0;
//		minute_counter = 32'd0;
//		time_enable <= 1'b0;
//
//	end
//
//	wire wDiv_btn;
//
//	divisor div_BR(
//		.clk_in(clk),
//		.freq_out(3'd5),
//		.clk_out(wDiv_btn)
//	);
//
//	always @(posedge (wDiv_btn)) begin
//	
//		if (rst == 0) begin
//
//			SALUD   	 <= 3'd5;
//			ANIMO   	 <= 3'd5;
//			COMIDA  	 <= 3'd5;
//			ENERGIA 	 <= 3'd5;
//			DIAS	 	 <= 6'd0;
//			STATE		 <= 4'd15;
//			second_counter = 32'd0;
//			minute_counter = 32'd0;
//			time_enable <= 1'd0;
//
//		end else begin
//		
//		if (SALUD < 3'd2 && STATE[3] == 1'b1) begin
//			STATE <= {1'b0, STATE[2:0]}; 
//		end else if (SALUD >= 3'd2 && STATE[3] == 1'b0) begin
//			STATE <= {1'b1, STATE[2:0]};
//		end
//		
//		if (ANIMO < 3'd2 && STATE[2] == 1'b1) begin
//			STATE <= {STATE[3], 1'b0, STATE[1:0]}; 
//		end else if (ANIMO >= 3'd2 && STATE[2] == 1'b0) begin
//			STATE <= {STATE[3], 1'b1, STATE[1:0]};
//		end
//		
//		if (COMIDA < 3'd2 && STATE[1] == 1'b1) begin
//			STATE <= {STATE[3:2], 1'b0, STATE[0]}; 
//		end else if (COMIDA >= 3'd2 && STATE[1] == 1'b0) begin
//			STATE <= {STATE[3:2], 1'b1, STATE[0]};
//		end
//		
//		if (ENERGIA < 3'd2 && STATE[0] == 1'b1) begin
//			STATE <= {STATE[3:1],1'b0}; 
//		end else if (ENERGIA >= 3'd2 && STATE[0] == 1'b0) begin
//			STATE <= {STATE[3:1], 1'b1};
//		end
//
//		if (time_enable) begin
//				
//				if (second_counter < wDiv_btn * (10)) begin // 5*(tiempo_cambio) = multiplicador; 5 => 60s_divisor/12s_reales
//					
//					second_counter <= second_counter + 1;
//				
//				end else begin
//				
//					second_counter <= 32'd0;      // Reiniciar el contador de segundos
//					minute_counter <= minute_counter + 1;  // Incrementar los minutos
//
//					if (second_counter >= MINUTES_TO_INCREMENT_DAYS) begin
////					if (minute_counter >= MINUTES_TO_INCREMENT_DAYS) begin
//						minute_counter <= 32'd0;  
//						DIAS <= DIAS + 1;         
//
//						if (DIAS >= 6'd32) begin
//
//							SALUD			<= 3'd0;
//							ANIMO			<= 3'd0;
//							COMIDA		<= 3'd0;
//							ENERGIA		<= 3'd0;
//							DIAS			<= 6'd0;
//							STATE			<= 4'd0;
//							time_enable <= 1'd0;
//						
//						end
//					end
//				end
//			end
//
//			if (btn_next == 0) begin
//				reg_stat <= (reg_stat < 4'd8) ? reg_stat + 1 : 4'd0;
//			end
//
//			if (btn_back == 0) begin
//				reg_stat <= (reg_stat > 4'd0) ? reg_stat - 1 : 4'd8;
//			end
//			
//
//
//			if (btn_comer_inc == 0) begin
//				
//				case (reg_stat)														
//					
//					4'd0: SALUD   <= (SALUD < 3'd5)   ? SALUD + 1   : SALUD;			
//					4'd1: ANIMO   <= (ANIMO < 3'd5)   ? ANIMO + 1   : ANIMO;			
//					4'd2: COMIDA  <= (COMIDA < 3'd5)  ? COMIDA + 1  : COMIDA;		
//					4'd3: ENERGIA <= (ENERGIA < 3'd5) ? ENERGIA + 1 : ENERGIA;	
//					4'd4: begin
//								DIAS    <= (DIAS < 6'd32)   ? DIAS + 1 : 6'd0;
//								SALUD   <= (DIAS >= 6'd32)  ? 4'd0     : SALUD;
//								ANIMO   <= (DIAS >= 6'd32)  ? 4'd0     : ANIMO;
//								COMIDA  <= (DIAS >= 6'd32)  ? 4'd0     : COMIDA;
//								ENERGIA <= (DIAS >= 6'd32)  ? 4'd0     : ENERGIA;
//								STATE   <= (DIAS >= 6'd32)  ? 4'd0     : STATE;
//							end
//					4'd5: STATE   <= (STATE < 4'd15)  ? STATE + 1   : STATE;
////					SALUD = (SALUD < 3'd5)  ? SALUD + 1 : SALUD;
////					ANIMO = (ANIMO < 3'd5)  ? ANIMO + 1 : ANIMO;
////					COMIDA = (COMIDA < 3'd5)  ? COMIDA + 1: COMIDA;	
//
//				endcase
//				
//			end
//
//			if (btn_curar_dec == 0) begin
//				
//				case (reg_stat)	
//				
//					4'd0: if (SALUD > 3'd0) SALUD <= SALUD - 1;			
//					4'd1: if (ANIMO > 3'd0) ANIMO <= ANIMO - 1;			
//					4'd2: if (COMIDA > 3'd0) COMIDA <= COMIDA - 1;		
//					4'd3: if (ENERGIA > 3'd0) ENERGIA <= ENERGIA - 1;	
//					4'd4: if (DIAS > 6'd0) DIAS <= DIAS - 1;
//					4'd5: if (STATE > 4'd0) STATE <= STATE - 1;	
//						
//
////					SALUD = (SALUD < 3'd5) ? SALUD + 1 : SALUD;
////					ANIMO = (ANIMO < 3'd5) ? ANIMO + 1 : ANIMO;
//			
//				endcase
//				
//			end
//				
////			if (sns_prox == 0) begin	
////				infra = 1'b1;
////			 COMIDA = (COMIDA > 3'd0) ? COMIDA - 1 : COMIDA;
////			 ANIMO = (ANIMO < 3'd5) ? ANIMO + 1 : ANIMO;
////			 ENERGIA = (ENERGIA > 3'd0) ? ENERGIA - 1 : ENERGIA;
////			end else begin 
////				infra = 1'b0;
////			end
//			
////			if (sns_temp == 0) begin
////				temp = 1'b1;
////			 SALUD = (SALUD > 3'd0) ? SALUD - 1 : SALUD;
////			 ANIMO = (ANIMO > 3'd0) ? ANIMO - 1 : ANIMO; 
////			end else begin
////				temp = 1'b0;
////			end
//			
////			if (sns_luz == 0) begin
////				luz = 1'b1;
////			  SALUD = (SALUD < 3'd5) ? SALUD + 1 : SALUD;
////			  ANIMO = (ANIMO < 3'd5) ? ANIMO + 1 : ANIMO;
////			  COMIDA = (COMIDA > 3'd0) ? COMIDA - 1 : COMIDA;
////			  ENERGIA = (ENERGIA > 3'd0) ? ENERGIA - 1 : ENERGIA;				  
////			end else begin 
////				luz = 1'b0;
////			end
//
//			case (reg_stat)
//
//				4'd0: begin
//					stat_name <= 4'd5;     
//					stat_value <= SALUD;
//					state <= STATE;
//				end
//
//				4'd1: begin
//					stat_name <= 4'ha;     
//					stat_value <= ANIMO;
//					state <= STATE;   
//				end
//
//				4'd2: begin
//					stat_name <= 4'hc;     
//					stat_value <= COMIDA;
//					state <= STATE;  
//				end
//
//				4'd3: begin
//					stat_name <= 4'he;     
//					stat_value <= ENERGIA;
//					state <= STATE; 
//				end
//
//				4'd4: begin
//					stat_name <= 4'hd;     
//					stat_value <= DIAS[5:0];
//					state <= STATE; 
//				end
//				
//				4'd5: begin
//					stat_name <= 4'hf;     
//					stat_value <= STATE;
//					state <= STATE; 
//				end
//				
//				4'd6: begin
//					stat_name <= 4'h1;     
//					stat_value <= sns_temp;
//					state <= STATE; 			
//				end
//				4'd7: begin
//					stat_name <= 4'h2;     
//					stat_value <= sns_luz;
//					state <= STATE; 
//				end
//				4'd8: begin
//					stat_name <= 4'h3;     
//					stat_value <= sns_prox;
//					state <= STATE; 
//				end
//
//			endcase
//			
//		end
//		
//	end
//	
//endmodule