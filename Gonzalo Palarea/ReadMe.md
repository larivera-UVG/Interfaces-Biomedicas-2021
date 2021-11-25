# Diseño y Fabricación de una Prótesis Electromecánica de Mano Humana, Controlada por Señales EMG de Superficie

Autor: Gonzalo Palarea A. - pal15559@uvg.edu.gt 

Este proyecto tiene como fin el desarrollo de un prototipo de próstesis de mano humana, controlada por señales EMG de superficie. Las características principales de la mano son:

  * Accesible económicamente. La mayoría de piezas se pueden fabricar por medio de impresión 3D FDM.
  * Utiliza señales EMG de superficie para interpretar los movimientos deseados del usuario.
  * Replica movimientos simples.
  * Fuente de energía portátil y recargable.
  * Partes fácilmente reemplazables

<p align="center">
  <img src="https://github.com/larivera-UVG/Interfaces-Biomedicas-2021/blob/main/Gonzalo%20Palarea/Documentos/imagenes%20Overleaf/ptototipo2/palma.JPG" width="800" title="hover text">
</p>


## Índice

**[1. Estructura de Carpetas](#carpetas)**
  * [1.1 Code](#code)
  * [1.2 Documentos](#documentos)
  * [1.3 Experimentos](#experimentos)
  * [1.4 Inventor](#inventor)
  
**[2. Instrucciones de uso](#instrucciones)**

**[3. Créditos](#creditos)**


## 1. Estructura de Carpetas <a name="carpetas"></a>
A continuación se presenta la estructura y contenido de las carpetas de este repositorio.

### 1.1 Code <a name="documentos"></a>
En esta carpeta se encuentran los siguientes archivos:
1. **Hoja de cálculo de interrupts que fue utilizada para calcular el período de muestreo utilizando el timer 2 del arduino nano**
2. **Carpeta "Code" que contiene el programa .ino utilizado en el prototipo**

### 1.2 Documentos <a name="documentos"></a>
En esta carpeta se encuentran las siguientes carpetas:

1. **Borradores Protocolos**
2. **Borradores Tesis**
3. **Datasheets**
4. **Documentos Tesis Gonzalo Palarea**
5. **Material de investigación**


### 1.3 Experimentos <a name="experimentos"></a>
En esta carpeta se encuentran los resultados de experimentos realizados.

### 1.4 Inventor <a name="inventor"></a>
En esta carpeta se encuentran los modelos 3D de la mano.

## 2. Instrucciones de uso <a name="instrucciones"></a>
1. Colocar una batería 18650 cargada en el portabaterías poniendo atención a los polos. El polo negativo (la punta plana de la batería) va hacia el resorte del portabaterías
2. Colocar uno de los sensores Myoware en el músculo extensor de los dedos, como en la imagen a continuación
<p align="center">
  <img src="https://github.com/larivera-UVG/Interfaces-Biomedicas-2021/blob/main/Gonzalo%20Palarea/Documentos/imagenes%20Overleaf/emg/sensoresextensor.jpeg" width="350" title="hover text">
</p>

3. Colocar otro sensor Myoware en el músculo flexor de los dedos, como en la imagen a continuación
<p align="center">
  <img src="https://github.com/larivera-UVG/Interfaces-Biomedicas-2021/blob/main/Gonzalo%20Palarea/Documentos/imagenes%20Overleaf/emg/sensoresflexor.jpeg" width="350" title="hover text">
</p>
4. Colocar el último sensor Myoware en el músculo extensor del pulgar, como en la imagen a continuación
<p align="center">
  <img src="https://github.com/larivera-UVG/Interfaces-Biomedicas-2021/blob/main/Gonzalo%20Palarea/Documentos/imagenes%20Overleaf/emg/sensoresextensorpulgar.jpeg" width="350" title="hover text">
</p>
5. Encender el prototipo con el switch ubicado en la tapadera.
6. Esperar 5 segundos, con los músculos relajados, para que los sensores se ajusten.
7. Puede comenzar a utilizar el prototipo.
8. En caso de que la mano comenzara a realizar movimientos no deseados, apagar el switch de la tapa y hacer el procedimiento desde el paso 5 para volver a calibrar los sensores. 


## 3. Créditos <a name="creditos"></a>
Autor: Gonzalo Palarea A. - pal15559@uvg.edu.gt 
