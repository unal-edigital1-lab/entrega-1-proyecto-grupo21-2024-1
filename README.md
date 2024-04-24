# Entrega 1 del proyecto Tamagotchi

* Daniel Mauricio Pamplona Chaparro
* Gustavo Adolfo Ropero Bastidas
* Elton Nicolas Sanabria Osorio
* Cristian Camilo Lopez Bernal


## Especificación detallada del sistema

Para la implementación del proyecto del Tamagotchi, se utilizará el lenguaje de Verilog. Además, se planea emplear los siguientes periféricos:

* La matriz 8x8 MAX7219 tiene la función de mostrar animaciones de la mascota cuando se realice alguna acción o actividad con ella. Esta matriz de LED ofrece la capacidad de visualizar de manera dinámica las diferentes interacciones con la mascota.

* Sensor de infrarrojo: Se utilizará un sensor de infrarrojo para detectar movimientos frente al sensor y enviar una señal para activar (despertar) la mascota.

* Display siete segmentos: Para la visualización de las estadísticas, se implementarán displays de siete segmentos. Estos displays permitirán ver las estadísticas actuales de la mascota en tiempo real, y se actualizarán automáticamente a medida que pase el tiempo o cuando se realice alguna acción con la mascota. Esta función proporcionará una manera clara y fácil de monitorear el estado y el progreso de la mascota en cualquier momento.

* Además de estos periféricos, se utilizarán interruptores o botones como entradas para las siguientes funciones:

    * Alimentar: Permitirá al usuario alimentar a la mascota virtual.

    * Dormir: Activará la función para que la mascota duerma.

    * Jugar: Iniciará una sesión de juego con la mascota.

    * Reset: Se utilizará un botón de reset para reiniciar todas las estadísticas de la mascota y volver a su estado inicial.

### Sensor Infrarojo
![Imagen](/pictures/Sensor.png)

### Caja negra general

![Imagen](/pictures/CajaNegraGeneral.png)

Desde la caja negra, donde se integran los módulos que se utilizarán en la implementación del proyecto, se dispone de lo siguiente:

* Sensor de infrarrojo: Este módulo se encargará de desarrollar el controlador necesario para permitir la captura de datos externos a través de un sensor de infrarrojo, los cuales posteriormente serán almacenados en el banco de registros.
* Banco de registros: En este módulo se almacenará la información obtenida del jugador, con el propósito de ser procesada y guardada. Además, esta información será compartida con los módulos siguientes para su visualización.
* 7 segmentos: Como se mencionó anteriormente, este módulo será utilizado para mostrar las estadísticas de la mascota, presentando sus valores en formato decimal mediante cuatro displays de siete segmentos.
* Matriz 8*8: En este módulo, se generará una animación para la mascota conforme el usuario interactúe, reflejando tanto las estadísticas de la mascota como su evolución a lo largo del tiempo.








