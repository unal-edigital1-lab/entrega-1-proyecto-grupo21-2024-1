module top_level (
    input wire clk,
    input wire rst,
    inout wire i2c_sda,
    inout wire i2c_scl,
    output wire i2c_detected,
    input wire start_write,
    input wire [7:0] write_data,
    input wire start_read,
    output wire [7:0] read_data
);

Adafruit_I2CDevice_cpp (
    .clk(clk),
    .rst(rst),
    .i2c_sda(i2c_sda),
    .i2c_scl(i2c_scl),
    .i2c_detected(i2c_detected),
    .start_write(start_write),
    .write_data(write_data),
    .start_read(start_read),
    .read_data(read_data)
);

// Instancia el módulo Adafruit_I2CDevice
Adafruit_I2CDevice_h (
    .clk(clk),                   // Señal de reloj
    .rst(rst),                   // Señal de reset
    .start(start),               // Señal de inicio de comunicación
    .addr(addr),                 // Dirección del dispositivo I2C
    .i2c_sda(i2c_sda),           // Línea de datos I2C
    .i2c_scl(i2c_scl),           // Línea de reloj I2C
    .detected(detected),         // Señal que indica si se detectó el dispositivo
    .write_data(write_data),     // Datos a escribir por I2C
    .write_enable(write_enable), // Habilitador de escritura por I2C
    .read_data(read_data),       // Datos leídos por I2C
    .read_valid(read_valid),     // Señal que indica que los datos leídos son válidos
    .busy(busy)                  // Señal que indica que la interfaz I2C está ocupada
);

endmodule