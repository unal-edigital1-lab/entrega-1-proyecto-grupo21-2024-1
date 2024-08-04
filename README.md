# Entrega 1 del proyecto Tamagotchi

* Daniel Mauricio Pamplona Chaparro
* Gustavo Adolfo Ropero Bastidas
* Elton Nicolas Sanabria Osorio
* Cristian Camilo Lopez Bernal


## Especificación detallada del sistema

Para la implementación del proyecto del Tamagotchi, se utilizará el lenguaje de Verilog. Además, se planea emplear los siguientes periféricos:

* La Pantalla TFT ILI9163 tiene tiene una resolucion 128x128 pxls. Se comunica mediante el protocolo SPI, lo que la hace compatible con microcontroladores como Arduino y PIC. Su tamaño es de 1.44 pulgadas, y su efecto visual es mucho mejor que otras pantallas pequeñas. Además, admite voltajes de entrada de 5V y 3.3V.

* El sensor infrarrojo FC-51 es un dispositivo de proximidad que funciona mediante un transmisor que emite luz infrarroja (IR) y un receptor que detecta la energía reflejada por objetos cercanos. El sensor utiliza el comparador LM393 para proporcionar una lectura digital cuando se supera un rango predefinido.

* El sensor LDR (Light Dependent Resistor) es un componente que permite medir la intensidad de luz en su entorno. Funciona como una resistencia variable cuya conductividad cambia según la cantidad de luz que incide sobre él. Aquí tienes los detalles clave:

* El sensor de temperatura infrarrojo MLX90614 es un dispositivo diseñado para medir la temperatura de objetos a distancia, sin necesidad de contacto físico. Puede medir temperaturas desde -70°C hasta 380°C con una precisión de ±0.5°C. Utiliza un protocolo de comunicación SMBus (I2C) para la transmisión de datos.

* Además de estos periféricos, se utilizarán interruptores o botones como entradas para las siguientes funciones:

    * Alimentar: Permitirá al usuario alimentar a la mascota virtual.

    * Dormir: Activará la función para que la mascota duerma.

    * Jugar: Iniciará una sesión de juego con la mascota.

    * Reset: Se utilizará un botón de reset para reiniciar todas las estadísticas de la mascota y volver a su estado inicial.

### Sensor Infrarojo
![Imagen](/pictures/Sensor.png)

### Caja negra general

![Imagen](/pictures/Cajanegrageneral.png )

Desde la caja negra, donde se integran los módulos que se utilizarán en la implementación del proyecto, se dispone de lo siguiente:

* Sensor de infrarrojo: Este módulo se encargará de desarrollar el controlador necesario para permitir la captura de datos externos a través de un sensor de infrarrojo, los cuales posteriormente serán almacenados en el banco de registros.
* Banco de registros: En este módulo se almacenará la información obtenida del jugador, con el propósito de ser procesada y guardada. Además, esta información será compartida con los módulos siguientes para su visualización.
* 7 segmentos: Como se mencionó anteriormente, este módulo será utilizado para mostrar las estadísticas de la mascota, presentando sus valores en formato decimal mediante cuatro displays de siete segmentos.
* Matriz 8*8: En este módulo, se generará una animación para la mascota conforme el usuario interactúe, reflejando tanto las estadísticas de la mascota como su evolución a lo largo del tiempo.








