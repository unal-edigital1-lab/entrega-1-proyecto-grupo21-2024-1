# Entrega Final del proyecto Tamagotchi

* Daniel Mauricio Pamplona Chaparro
* Hernán Felipe Bernal Arévalo
* Elton Nicolas Sanabria Osorio
* Cristian Camilo Lopez Bernal

## 1. Introducción

### Contexto y motivación:

Un Tamagotchi es una mascota virtual que vive dentro de un pequeño dispositivo electrónico. El usuario debe cuidar de esta mascota, alimentándola, jugando con ella, curándola si se enferma, etc.

Crear un Tamagotchi en un curso de electrónica digital es interesante por varias razones:

* Aplicación práctica de conceptos teóricos: Permite aplicar conocimientos sobre diseño de sistemas digitales, máquinas de estado, manejo de sensores y pantallas, y programación en Verilog.
* Desarrollo de habilidades: Fomenta el pensamiento lógico, la resolución de problemas y la creatividad al diseñar e implementar las diferentes funcionalidades del Tamagotchi.
* Proyecto divertido y motivador: Es un proyecto atractivo que combina la electrónica con el entretenimiento, lo que puede aumentar la motivación y el interés de los estudiantes.
* Demostración de capacidades: El resultado final es un dispositivo tangible que demuestra las habilidades adquiridas en el curso.

### Objetivos del proyecto:

* Desarrollar un sistema de Tamagotchi en FPGA que simule el cuidado de una mascota virtual.
* Incorporarar una lógica de estados para reflejar las diversas necesidades y condiciones de la mascota.
* Usar mecanismos de interacción a través de sensores y botones que permitan al usuario cuidar adecuadamente de la mascota.
* Un sistema de visualización grafica para representar el estado actual y las necesidades de la mascota virtual.

### Alcance del proyecto:

Definir qué funcionalidades incluiste en tu Tamagotchi y cuáles quedaron fuera del alcance.

## 2. Diseño General del Sistema

### Diagrama de Bloques:
![Imagen](/pictures/Tamagotchi_CajaNegra.png)
* MODULE_TEST: Se encarga de comparar si entamos en modo test, configura sus parametros y devuelve una señal de 1 bit.
* SENSORES: se encarga de instanciar los tres sensores a utilizar, maneja la logica interna pa cada uno y devuelve una salida de 1bit de acuerdo a los parametros establecidos en cada sensor. Este modulo cuenta con una cuarta señal bidireccional "dht11" correspondiente al sensor de temperatura, se encarga de enviar un impulso como señal de salida para activar la recepcion del entorno y posteriormente actua como señal de entrada para recibir los datos correspondientes.
* BANCO REGISTRO: Recibe todas las señales de los botones dispuestos al igual que las de los sensores, interpreta dichas señales, las almacena y devuelve los valores de las estadisticas de la mascota para poder visualizarlas junto con la interaccion que se tenga con la mascota.
* DISPLAY: Controla la logica para la visualizacion en el display 7 segmentos integrado en la tarjeta, se tiene como metodo de visulaizacion alternativo.
* ILI9361: Este modulo se encarga de recibir los valores de cada estadistica asi como las señales de interaccion para posteriormente mostrar las animaciones respectivas en la pantalla.

### Descripción de los Componentes:
### Sistema de Sensado

Para nuestro proyecto de Tamagotchi, se implementó 3 sensores, para que de esta forma el usuario llegue a tener interacción con el juego. 


* El sensor infrarrojo FC-51 es un dispositivo de proximidad que funciona mediante un transmisor que emite luz infrarroja (IR) y un receptor que detecta la energía reflejada por objetos cercanos. El sensor utiliza el comparador LM393 para proporcionar una lectura digital cuando se supera un rango predefinido. 

![Imagen](/pictures/fc-51.jpg)
![Imagen](/pictures/infrarrojo.png)

* El sensor LDR (Light Dependent Resistor) es un componente que permite medir la intensidad de luz en su entorno. Funciona como una resistencia variable cuya conductividad cambia según la cantidad de luz que incide sobre él.
![Imagen](/pictures/R.jpeg)
![Imagen](/pictures/luz.png)

Sera utilizado con el fin de simular los ciclos de día y noche, influyendo en las rutinas de actividad y descanso de la mascota.

* El sensor de temperatura DHT11 es un dispositivo diseñado para medir la temperatura y humedad. 

![Imagen](/pictures/temperatura.jpeg)
![Imagen](/pictures/temp.png)

### Sistema de Visualización

Realizaremos el uso del siguiente periférico como sistema de visualización, donde podremos representar visualmente nuestro Tamagotchi, además de los niveles de cada estado del mismo.

* La Pantalla TFT ILI9163 tiene tiene una resolucion 128x128 pxls. Se comunica mediante el protocolo SPI, lo que la hace compatible con microcontroladores como Arduino y PIC. Su tamaño es de 1.44 pulgadas, y su efecto visual es mucho mejor que otras pantallas pequeñas. Además, admite voltajes de entrada de 5V y 3.3V.
* Botones:
    Se implementaron pulsadores 4 como botones, los cuales se conectan a los pines de la fpga, para las siguientes funciones:
    * Pulsador 1: Permite al usuario alimentar a la mascota virtual en modo de juego normal e incrementar la estadisiticas de la mascota en modo test.
    * Pulsador 2: Permite al usuario dar medicina a la mascota virtual en modo normal y disminuri las estadisiticas de la mascota en modo test.
    * Pulsador 3: Permite navegar entre las estadisitcas de manera incremental.
    * Pulsador 4: Permite navegar entre las estadisitcas de manera decremental.
    Además, tenemos dos botones,los cuales seran usados directamente de nuestra FPGA.
    * Reset: Se utiliza un botón de reset para reiniciar todas las estadísticas de la mascota y volver a su estado inicial.
    * Test: Activa el modo de prueba al mantener pulsado por al menos 5 segundos, permitiendo al usuario navegar entre los diferentes estados del Tamagotchi con cada pulsación y permite cambiar el nivel de cada estado.
* Pantalla TFT: Especifica las características de la pantalla, su protocolo de comunicación (SPI) y cómo se controla desde la FPGA.
    La Pantalla TFT ILI9163 tiene tiene una resolucion 128x128 pxls. Se comunica mediante el protocolo SPI, lo que la hace compatible con microcontroladores como Arduino y PIC. Su tamaño es de 1.44 pulgadas, y su efecto visual es mucho mejor que otras pantallas pequeñas. Además, admite voltajes de entrada de 5V y 3.3V.
* FPGA: La FPGA utilizada en este proyecto es la Altera Cyclone IV EP4CE6E22C8N y es la que recibe y procesa las señales de los sensores (infrarrojo, temperatura, luz) y los botones (reset, test, interacciones), implementa la máquina de estados finita que define el comportamiento del Tamagotchi, controlando las transiciones entre sus diferentes estados y genera las señales necesarias para controlar la pantalla TFT, mostrando la interfaz gráfica y los indicadores del Tamagotchi.

### Arquitectura General:

#### Modulo Sensores

#### Sensor infrarojo (FC-51):

El sensor FC-51 cumple la función de detectar la proximidad o presencia cuando se activa, lo que permite interactuar con las mascotas. A través de esta interacción, se modifican las estadísticas y los estados de la mascota, reflejando cambios en su comportamiento o necesidades según el entorno.

#### Sensor fotoresistencia (LDR):

El sensor LDR cumple la función de detectar los niveles de luz ambiental, y cuando se activa, permite interactuar con las mascotas. A través de esta interacción, se varían las estadísticas y los estados de la mascota, ajustándose a las condiciones de iluminación del entorno.

#### Sensor de temperatura (DHT11):

El sensor DHT11 cumple la función de medir la temperatura y la humedad. Cuando se activa, permite interactuar con las mascotas, variando las estadísticas y los estados de la mascota según las condiciones climáticas detectadas.

Explicar cómo se organiza el sistema en términos de módulos HDL (ej: módulo sensor, módulo botón, módulo pantalla, máquina de estados).
    * Modulo sensores:
    * Modulo botones:
    * Modulo maquina de estados:
    * Modulo pantalla:

## 3. Máquina de Estados

### Diagrama de Estados:
Presentar un diagrama detallado de la máquina de estados, mostrando todos los estados posibles del Tamagotchi y las transiciones entre ellos.
### Descripción de los Estados:

* Hambriento:

    * Significado: La mascota virtual necesita ser alimentada. Si se ignora esta necesidad por mucho tiempo, puede enfermarse.
    * Representación en pantalla:
        * Le cambian los ojos por > <.
        * Expresión facial de la mascota mostrando tristeza o malestar.

* Triste/Ánimo bajo:

    * Significado: La mascota está contenta y satisfecha, indicando que sus necesidades básicas están cubiertas.
    * Representación en pantalla:
        * Boca con los extremos hacia abajo triste.
        * Expresión facial de la mascota mostrando tristeza o insatisfacción.

* Enfermo/Salud baja:

    * Significado: La mascota está enferma debido a la falta de cuidado o atención a sus necesidades. Requiere atención médica (botón "curar").
    * Representación en pantalla:
         * Mejillas verdes
         * Expresión facial de la mascota mostrando  malestar

* Cansado:

    * Significado: La mascota necesita descansar para recuperar energía. Esto puede ocurrir después de jugar mucho o durante la noche.
    * Representación en pantalla:
        * Gota de sudor en la frente
        * Expresión facial de la mascota cansada.

### Transiciones entre Estados:
Los estados de la mascota van a estar controlados por una señal "state" de 4 bits, estos bits representan, del mas significativo al menos significativo, la salud, el animo, la comida y la energia respectivamente. Así, state nos da la opción de representar los 6 estados basicos y la combinación entre ellos. La visualizacion de la combinación entre los estados será posible ya que cada estado se visualiza en una zona distina a los demas. Estas transiciones se desencadenan cuando alguna de las estadisticas de la mascota disminuyen por debajo de 2.

## 4. Implementación en HDL

### Descripción de los Módulos:

### Modulo sensores 

#### Sensor infrarojo (FC-51):

```verilog
always @(posedge clk2) begin
        if (test_enable == 0) begin
            if (IR == 0) begin
                prox_out <= 1;   
            end else begin
                prox_out <= 0; 
            end
        end
    end
```

La parte clave de este sensor es que actúa como un interruptor, donde test_enable funciona como un botón que permite al sensor infrarrojo leer datos de entrada siempre que su valor sea 0. Adicionalmente, si el sensor infrarrojo detecta alguna interacción, se activa al nivel 0 y produce una salida en prox_out, indicando que hay movimiento o que algo se ha aproximado. Si no hay detección, prox_out se establece en 0, lo que significa que no hay reacción ante el sensor.

#### Sensor fotoresistencia (FC-51):

```verilog
always @(posedge clk2) begin
        if (test_enable == 0) begin
            if (FR == 0) begin
                luz_out <= 1;   
            end else begin
                luz_out <= 0;   
            end
        end
    end
```

Este sensor actúa como un interruptor, con test_enable funcionando como un botón que permite leer datos de entrada únicamente cuando su valor es 0. Cuando la fotoresistencia detecta luz (FR = 0), se activa y genera una salida en luz_out, indicando la presencia de luz. En ausencia de luz, luz_out se establece en 0, señalando que no hay actividad.

#### Sensor de temperatura y humedad (DHT11):

```verilog
// Registros internos
    reg [31:0] timer;              // Temporizador para generar pulsos de tiempo
    reg [3:0] state;               // Estado del FSM
    reg [39:0] data;               // Datos leídos del sensor
    reg dht11_out;                 // Señal de salida para el pin bidireccional
    reg dht11_dir;                 // Dirección del pin (0: entrada, 1: salida)
    reg [5:0] bit_index;           // Índice del bit a leer
    reg [15:0] temperature;        // Temperatura leída
    reg [7:0] aju_t;               // Ajuste temperatura
    reg [$clog2(MAX_COUNT)-1:0] counter; // Contador
```

* Se crean registros para almacenar la información de las mediciones del sensor. El registro timer se utiliza para contar los pulsos cada vez que se actualiza un estado, lo que permite variar el funcionamiento del sensor.

* El registro state indica en qué estado se encuentra el sensor, ya sea en lectura, procesamiento o en la inicialización.

* El registro data almacena 40 bits de información, donde los primeros 16 bits corresponden a la temperatura y los siguientes 16 bits a la humedad.

* El registro dht11_out indica cuándo el sensor está en modo de salida, informando si está leyendo datos o enviando información.

* El registro dht11_dir señala si el sensor está en modo de entrada o salida.

* El registro bit_index muestra la posición de cada bit dentro de los datos leídos, permitiendo identificar cuál es el bit actual que se está procesando.

* Finalmente, el registro temperature almacena los datos relacionados exclusivamente con la temperatura, mientras que aju_t actúa como un calibrador, proporcionando una temperatura más precisa. Esto es importante, ya que las temperaturas pueden variar según la ubicación donde se realiza la medición.

### Modulo Banco  

Este modulo Mantiene registros para la salud, ánimo, comida, energía, días de vida y el estado general y procesa las señales de los botones y sensores, actualizando los estados internos según las interacciones del usuario y las condiciones ambientales.

```verilog
module BancoRegistro #(
	parameter SECONDS_IN_MINUTE = 60,
	parameter MINUTES_TO_INCREMENT_DAYS = 2,
	parameter TAU = 50
)
	input clk,
	input rst,
	input test,

	input btn_back,
	input btn_next,
	input btn_comer_inc,     		   
	input btn_curar_dec,
	
	input sns_prox,
	input sns_temp,
	input sns_luz,	 

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


### Modulo Module_test  
El Module_test se encarga de verificar si se cumplen las condiciones necesarias para entrar a dicho modo, tiene una señal de salida de 1 bit.

```verilog
always @(posedge clk) begin	
		if (test==0) begin
			if (counter >= ciclos_segs) begin
				counter <= 0;  
				test_active <= ~test_active;  
				test_enable <= test_active;  
			end else begin
				counter <= counter + 1;  
			end
		end else begin
			counter <= 0;  
		end
	end
```

    
Este modulo primero verifica si el boton de test se esta presionando, si el boton dura presionado por mas de "ciclo_segs" (5 segundos) se invierte la señal test_active y su valor se almacena en test_enable, la cual será la señal de salida del mudulo. La logica de invertir test_active permite tener un control en el codigo para entrar y salir del modo test facilmente.

### Modulo Display  

Este modulo se encarga de visualizar ciertas señales en el display 7 segmentos incluidos en la tarjeta FPGA. 

```verilog
always @(posedge enable) begin
		if(rst==0) begin
			count<= 0;
			an<=9'b111111111; 
		end else begin 
			count<= count+1;
			an<=9'b111111111; 
			case (count) 
				3'h0: begin bcd <= (stat_value % 10); an<=9'b111111110; end
				3'h1: begin bcd <= ((stat_value / 10) % 10); an<=9'b111111101; end
				3'h2: begin bcd <= (stat_name); an<=9'b111110111; end
				3'h3: begin bcd <= state[0]; an<=9'b111101111; end
				3'h4: begin bcd <= state[1]; an<=9'b111011111; end 
				3'h5: begin bcd <= state[2]; an<=9'b110111111; end
				3'h6: begin bcd <= state[3]; an<=9'b101111111; end
				3'h7: begin bcd <= (4'd5); an<=9'b101111111; end 
			endcase
		end
	end
```
    

De esta manera en el display se mostrará una estadistica (stat_name), su respectivo valor (stat_value), y por ultimo los 4 bits de state para poder verificar los cambios de estados cuando se cumplan las condiciones necesarias. 

## 5. Resultados y Conclusiones

### Demostración del Funcionamiento:

Implementación de la pantalla que muestra la animación, donde se modifican los aspectos del rostro a medida que se varían las estadísticas.

![Imagen](/pictures/pantalla2.jpg)

Al implementar el sensor de luz, se modifican estadísticas como el aumento de los indicadores de salud y ánimo, mientras que, por otro lado, disminuyen las estadísticas relacionadas con la alimentación y el cansancio.

https://github.com/user-attachments/assets/f75ead13-7bcf-4ca9-b386-a98144390d02


### Conclusiones:
Reflexionar sobre lo que se aprendio durante el proyecto, los desafíos que se enfrentastaton y cómo se superaron.


# Entrega 1 del proyecto Tamagotchi


* Daniel Mauricio Pamplona Chaparro
* Hernán Felipe Bernal Arévalo
* Elton Nicolas Sanabria Osorio
* Cristian Camilo Lopez Bernal


## Especificación detallada del sistema

### Sistema de botones 

* Realizaremos el uso de sensores infrarrojos FC-51 como botones para las siguientes funciones:

    * Alimentar: Permitirá al usuario alimentar a la mascota virtual.
    * Curar: Permitirá al usuario dar medicina a la mascota virtual.
    * Jugar: Iniciará una sesión de juego con la mascota.

* Además, tendremos estos dos botones (los cuales seran usados directamente de nuestra FPGA) que son requisitos esenciales en nuestro sistema.

    * Reset: Se utilizará un botón de reset para reiniciar todas las estadísticas de la mascota y volver a su estado inicial.
    * Test: Activa el modo de prueba al mantener pulsado por al menos 5 segundos, permitiendo al usuario navegar entre los diferentes estados del Tamagotchi con cada pulsación.

### Sistena de Sensado

Para nuestro proyecto de Tamagotchi, se plantea la implementación de 5 sensores, para que de esta forma el usuario llegue a tener mas interacción con el mismo. 


* El sensor infrarrojo FC-51 es un dispositivo de proximidad que funciona mediante un transmisor que emite luz infrarroja (IR) y un receptor que detecta la energía reflejada por objetos cercanos. El sensor utiliza el comparador LM393 para proporcionar una lectura digital cuando se supera un rango predefinido. Realizaremos uso de tres de los mismos, ya que seran implementados como nuestros botones de interacción con el Tamagotchi.

![Imagen](/pictures/fc-51.jpg)
![Imagen](/pictures/infrarrojo.png)

* El sensor LDR (Light Dependent Resistor) es un componente que permite medir la intensidad de luz en su entorno. Funciona como una resistencia variable cuya conductividad cambia según la cantidad de luz que incide sobre él. Aquí tienes los detalles clave:

![Imagen](/pictures/R.jpeg)
![Imagen](/pictures/luz.png)

Sera utilizado con el fin de simular los ciclos de día y noche, influyendo en las rutinas de actividad y descanso de la mascota.

* El sensor de temperatura infrarrojo MLX90614 es un dispositivo diseñado para medir la temperatura de objetos a distancia, sin necesidad de contacto físico. Puede medir temperaturas desde -70°C hasta 380°C con una precisión de ±0.5°C. Utiliza un protocolo de comunicación SMBus (I2C) para la transmisión de datos.

![Imagen](/pictures/temperatura.jpeg)
![Imagen](/pictures/temp.png)

### Sistema de Visualización

Realizaremos el uso del siguiente periférico como sistema de visualización, donde podremos representar visualmente nuestro Tamagotchi, además de los niveles de cada estado del mismo.

* La Pantalla TFT ILI9163 tiene tiene una resolucion 128x128 pxls. Se comunica mediante el protocolo SPI, lo que la hace compatible con microcontroladores como Arduino y PIC. Su tamaño es de 1.44 pulgadas, y su efecto visual es mucho mejor que otras pantallas pequeñas. Además, admite voltajes de entrada de 5V y 3.3V.

## Estados 
El Tamagotchi operará a través de una serie de estados que reflejan las necesidades físicas y emocionales de la mascota virtual, a saber:

* Hambriento: Este estado alerta sobre la necesidad de alimentar a la mascota. La falta de atención a esta necesidad puede desencadenar un estado de enfermedad.

* Ánimo : Denota la necesidad de cariño de la mascota. Refleja el bienestar general de la mascota como resultado de satisfacer adecuadamente sus necesidades básicas.

* Descansar: Identifica cuando la mascota requiere reposo para recuperar energía, especialmente después de períodos de actividad intensa o durante la noche, limitando la interacción del usuario durante estas fases.

* Salud: va a niveles de enfermo por el descuido en el cuidado de la mascota, requiriendo intervenciones específicas para su recuperación.

* Higiene: Subraya la importancia de mantener la limpieza de la mascota, introduciendo otra dimensión al cuidado requerido.

## Transiciones

* Temporizadores:

Se implementarán temporizadores para simular el avance temporal, afectando las necesidades básicas del Tamagotchi. A medida que el tiempo progresa, ciertas necesidades como el hambre incrementarán de forma gradual, requiriendo intervención del usuario para suministrar alimento a la mascota y mantener su estado de salud óptimo.

* Interacciones:

Las transiciones entre diferentes estados de la mascota se desencadenarán por interacciones directas del usuario, utilizando botones y sensores. Estas acciones permitirán al usuario influir activamente en el bienestar y comportamiento de la mascota virtual.

* Sistema de Niveles o Puntos:

Se desarrollará un sistema de niveles o puntuación que reflejará la calidad del cuidado proporcionado al Tamagotchi. Aspectos como el nivel de hambre y ánimo fluctuarán en una escala de 1 a 3, donde acciones positivas como alimentar o interactuar con la mascota incrementarán dichos niveles, mientras que la inactividad o negligencia resultará en su disminución. Este mecanismo brindará retroalimentación constante al usuario sobre la condición actual de la mascota virtual.

A continuación, planteamos una tabla donde podremas ver como estos estados cambian de manera dinámica, dependiendo de cada acción que realice el usuario:

| Actvidad / sensores  | Salud | Ánimo  | Hambre | Cansansio  | Higiene  |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
| Jugar  | No aplica | +  | -  | +  | -  |
| Alimentar  | +  | +  | +  | No aplica  | -  | 
| Curar  | +  | +  | No aplica  | No aplica  | No aplica  |
| Bañar  | +  | +  | No aplica  | No aplica  | +  |
| Dormir   | +  | +  | -  | -  | No aplica  |
| Tiempo  | -  | -  | -  | +  | -  |
| Temperatura  | -  | -  | No aplica  | No aplica  | No aplica  |
| Luz  | No aplica  | No aplica  | No aplica  | + | No aplica  |


## Caja negra general
A continuación, se plantea el siguiente diagrama de caja negra donde veremos los diagramas de bloques necesarios para la ejecución de nuestro proyecto:

![Imagen](/pictures/Cajanegrageneral.png )

### Descripción general 

1. Tendremos nuestras nuestras entradas a través de nuestros botones y sensores.
2. Todas nuestras entradas irán a una máquina de estados general, donde a partir de cada entrada, la máquina de estados cambiará nuestros estados del Tamagotchi.
3. Luego pasaremos a una FSM (Máquina de estados finita), la cual nos brindara la animación correspondiente a la acción que este realizando el usuario, permitiendo asi una visuazliación dinámica con el Tamagotchi.
4. Pasamos a un bloque que llamamos "ILI9163 Controller", en el cual tenemos toda la configuración interna de nuestra pantalla. Además, dentro del mismo, tambien se encuentra un banco de registros.
5. Luego pasamos al SPI del sistema. El SPI (Serial Peripheral Interface) Master de una pantalla TFT ILI9163 es el dispositivo que controla la comunicación serie SPI entre la pantalla y nyestra lógica anteriormente mencionada. El SPI es un protocolo de comunicación sincrónica que permite la transferencia de datos en serie, y en este caso, se utiliza para enviar comandos y datos a la pantalla TFT ILI9163.
6. Por último, tendriamos nuestra visualización en la pantalla TFT ILI9163.

## Arquitectura del sistema: 
[Aporte de Hernan Beltran]: # 

### Definición de Periféricos y Funcionalidad

* Sensor Infrarojo: Detecta la presencia o ausencia de un objeto cercano a la mascota virtual. En el contexto del juego, podría usarse para simular interacciones físicas con el usuario (por ejemplo, acariciar). En HDL, la salida del sensor (un bit) se conectaría directamente a la máquina de estados para desencadenar eventos como "jugar".
* Sensor de Temperatura: Mide la temperatura ambiente. La lectura del sensor se compararía con un rango de temperatura predefinido. Si la temperatura está fuera de rango, se activaría un proceso en la máquina de estados para disminuir la salud y el ánimo de la mascota. En HDL, la salida analógica del sensor se digitalizaría y compararía con un valor de referencia.
* Sensor de Luz: Mide la intensidad de la luz ambiente. Una alta intensidad de luz podría simular el día y afectar el ciclo de sueño de la mascota. En HDL, funcionaría de manera similar al sensor de temperatura, pero afectando principalmente el cansancio.
* Botón de Reset: Reinicia el juego a su estado inicial, restableciendo todos los valores de los indicadores de la mascota. En HDL, se conectaría a un registro de reset que se activaría al pulsar el botón.
* Botón de Test: Permite al usuario activar un modo de prueba para verificar el funcionamiento de los diferentes componentes del sistema. En HDL, se conectaría a un registro de control que habilitaría diferentes modos de operación.
* Reloj (Clk): Genera una señal de reloj que sincroniza todas las operaciones del sistema. Se utilizará para medir el tiempo de juego y para implementar temporizadores que controlen la evolución de los estados de la mascota. En HDL, se generaría un reloj de alta frecuencia y se dividiría para obtener las frecuencias necesarias para cada módulo.
* Pantalla TFT: Muestra la interfaz gráfica del juego, incluyendo los indicadores de la mascota y su imagen. En HDL, se controlaría a través de un interfaz serial (SPI o I2C) para enviar los datos de la imagen y los indicadores.

#### Conexión en HDL
La conexión de estos periféricos en HDL se realizaría mediante módulos que encapsulan la lógica de cada uno. Por ejemplo:

* Módulo Sensor: Recibe la señal analógica del sensor, la digitaliza y la compara con un valor de referencia.
* Módulo Botón: Detecta los flancos de subida y bajada de la señal del botón y genera una señal de activación.
* Módulo Pantalla: Envía los datos de la imagen y los indicadores a la pantalla TFT a través del interfaz serial.

Estos módulos se conectarían a la máquina de estados principal, que sería responsable de procesar toda la información y actualizar los estados de la mascota.

### Arquitectura Propuesta

Para este proyecto, una arquitectura basada en una Máquina de Estados Finita (FSM) es ideal. La FSM controlará la evolución del estado de la mascota en función de las entradas de los sensores y los botones.

### Componentes principales de la arquitectura:

* Máquina de Estados: El corazón del sistema. Definirá todos los posibles estados de la mascota (saludable, enfermo, feliz, triste, etc.) y las transiciones entre ellos.
* Módulo de Indicadores: Calculará los valores de los indicadores de la mascota (salud, ánimo, etc.) en función de las acciones del usuario y de los factores externos.
* Módulo de Pantalla: Generará la señal de video para la pantalla TFT, mostrando la interfaz gráfica del juego.
Módulo de Temporización: Implementará los temporizadores necesarios para controlar la evolución de los estados de la mascota y para medir el tiempo de juego.

### Modelos
* Modelo de la Mascota: Definirá las características de la mascota, como su especie, edad y personalidad. Este modelo se utilizará para personalizar el comportamiento de la mascota.
* Modelo del Ambiente: Simulará el entorno de la mascota, incluyendo la temperatura, la luz y la presencia de otros objetos.
* Modelo de Interacción: Describirá cómo el usuario interactúa con la mascota y cómo estas interacciones afectan el estado de la mascota.
