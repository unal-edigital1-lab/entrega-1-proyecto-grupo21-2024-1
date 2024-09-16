module divisor(
   input           clkd,     // reloj entrante de 50MHz
   output reg      clk2      // reloj salida
);

parameter frecuencia = 50000000 ;
parameter freq_out = 10000;
parameter max_count = frecuencia/(2*freq_out);

reg [22:0] count; // contador de flancos

initial begin
    count = 0;
    clk2 = 0;
end

always @(posedge clkd) begin
    if (count == (max_count))begin
        clk2= ~clk2;
        count = 0;
    end
    else begin
        count = count+1;
    end
end

endmodule