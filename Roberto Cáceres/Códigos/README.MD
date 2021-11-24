# Código

Esta carpeta almacena los códigos necesarios para poder utilizar las interfaces creadas, así como los códigos para la implementación de la conexión con el Robot R17.

1. **Base de datos Públicas:** En esta carpeta se encuentran los códigos en MATLAB para poder realizar la extracción de características de la data que se recopiló en los paradigmas experimentales de esta base de datos. No es necesario emplear estos códigos a menos que se use está base de datos para experimentar con ella. Sin embargo, se encuentran ejemplos para entrenar clasificadores de inteligencia artificial, como redes neuronales y máquina de soporte de vectores
   
2. **Interfaces:** En esta carpeta se encuentran las 6 interfaces desarrolladas, seccionadas en 3 carpetas. En cada carpeta se encuentran tanto la interfaz recolectora, como la interfaz clasificadora de cada tipo de señal, en cada carpeta se encontrarán los archivos necesarios para poder correr las interfaces. Es importante que se encuentren en un mismo directorio. Para el uso de las interfaces clasificadores, si se hará uso de del robot R17, se tiene que colocar los códigos de la carpeta R17 en los mismos directorios. 
     * **Interfaces EMG**
     * **Interfaces EEG**
     * **Interfaces EEG-EMG**
    
3. **Pruebas y Ejemplos**
    * **Pruebas:** En esta carpeta se encuentran diversas pruebas hechas con los dispositivos y sensores utilizados para la captura de señales.
    * **Ejemplos:** En esta carpeta se encuentran ejemplos, de adquisición de señales y ejemplos de como extraer características en forma de tabla, utilizando las bases de datos generadas por las interfaces recolectoras
3. **R17**
  En estas carpetas se encuentra los códigos generados por José David Pellecer, los cuales desarrollo para poder enviar comandos al robot R17, también se encuentra la interfaz generada por él. 
      
