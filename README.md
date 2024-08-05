# Entrega 1 del proyecto Tamagotchi

* Daniel Mauricio Pamplona Chaparro
* Hernán Felipe Bernal Arévalo
* Elton Nicolas Sanabria Osorio
* Cristian Camilo Lopez Bernal


## Especificación detallada del sistema

Para la implementación del proyecto del Tamagotchi, se utilizará el lenguaje de Verilog. Además, se planea emplear los siguientes periféricos:

* La Pantalla TFT ILI9163 tiene tiene una resolucion 128x128 pxls. Se comunica mediante el protocolo SPI, lo que la hace compatible con microcontroladores como Arduino y PIC. Su tamaño es de 1.44 pulgadas, y su efecto visual es mucho mejor que otras pantallas pequeñas. Además, admite voltajes de entrada de 5V y 3.3V.

* El sensor infrarrojo FC-51 es un dispositivo de proximidad que funciona mediante un transmisor que emite luz infrarroja (IR) y un receptor que detecta la energía reflejada por objetos cercanos. El sensor utiliza el comparador LM393 para proporcionar una lectura digital cuando se supera un rango predefinido.

![Imagen](/pictures/fc-51.jpg)
![Imagen](/pictures/infrarrojo.png)

* El sensor LDR (Light Dependent Resistor) es un componente que permite medir la intensidad de luz en su entorno. Funciona como una resistencia variable cuya conductividad cambia según la cantidad de luz que incide sobre él. Aquí tienes los detalles clave:

![Imagen](/pictures/R.jpeg)
![Imagen](/pictures/luz.png)

* El sensor de temperatura infrarrojo MLX90614 es un dispositivo diseñado para medir la temperatura de objetos a distancia, sin necesidad de contacto físico. Puede medir temperaturas desde -70°C hasta 380°C con una precisión de ±0.5°C. Utiliza un protocolo de comunicación SMBus (I2C) para la transmisión de datos.

![Imagen](/pictures/temperatura.jpeg)
![Imagen](/pictures/temp.png)

* Además de estos periféricos, se utilizarán interruptores o botones como entradas para las siguientes funciones:

    * Alimentar: Permitirá al usuario alimentar a la mascota virtual.

    * Dormir: Activará la función para que la mascota duerma.
    * Jugar: Iniciará una sesión de juego con la mascota.
    * Reset: Se utilizará un botón de reset para reiniciar todas las estadísticas de la mascota y volver a su estado inicial.


## Caja negra general

![Imagen](/pictures/Cajanegrageneral.png )


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
Modelo de Interacción: Describirá cómo el usuario interactúa con la mascota y cómo estas interacciones afectan el estado de la mascota.








