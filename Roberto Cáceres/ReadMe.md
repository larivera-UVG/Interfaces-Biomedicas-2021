# Interfaces Biomédicas para el Control de Sistemas Robóticos Utilizando Señales combinación de señales EMG y EEG
Este proyecto tiene el objetivo de desarrollar una interfaz biomédica para el control de dispositivos robóticos. Las señales tienen que poder ser adquiridas, filtradas y analizadas en tiempo real, para poder convertirlas en comandos y enviarlos a los sistemas robóticos. Las señales a utilizar son tanto las EMG como las EEG, pudiendo así combinarlas para poder tener un mejor control sobre los sistemas robóticos. Se desarrollaron 3 interfaces recolectoras de datos para cada tipo de señal; EMG, EEG y EEG-EMG. Con estas interfaces se recolectaron datos y se creó una base de datos propia con las que se emplearían algoritmos de clasificación de inteligencia artificial. También se desarrollaron 3 interfaces clasificadoras de para cada tipo de señal que permiten conectarse con el Robot R17. 

## Índice

**[1. Prerrequisitos](#prerrequisitos)**
  * [1.1 Base De Datos Gigascience.](#BaseDeDatosGigascience)
  * [1.2 Toolboxes](#toolboxes)
  * [1.3 MATLAB 2017a ](#database)
* [1.4 OpenBCI LSL Setup ](#OpenBCILSLSetup)

**[2. Estructura de Carpetas](#carpetas)**
  * [2.1 Código](#codigo)
  * [2.2 Documentos](#documentos)
* [2.3 Hardware](#Hardware)

## Prerrequisitos 

### 1.1 Base De Datos Gigascience. 
1. Leer el Artículo Científico:  *Multimodal signal dataset for 11 intuitive movement tasks from single upper extremity during multiple recording sessions. Encontrado en: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7539536/#bib67
2. Para poder descargar las muestras de las señales se tiene que ir al siguiente enlace: http://gigadb.org/dataset/100788
3. Es importante tener en cuenta que para acceder a la data, se tiene que hacer a tráves de un protocolo FTP (Cliente-Servidor) esto debido al peso de la data que se generó en el artículo científico. Esto se lográ con el programa FileZilla, que permite usar tu computadora como un cliente para acceder a la base de datos. Se puede descargar desde: https://filezilla-project.org
1. Al tener FileZilla descargado se tiene que agregar un nuevo servidor e ingresar el link proporcionado por Gigascience: ftp://parrot.genomics.cn/gigadb/pub/10.5524/100001_101000/100788/.

### 1.2 Toolboxes 
#### *Robotics Toolbox* de Peter Corke
1. Descargar el *Toolbox* de robótica de Peter Corke del siguiente enlace https://petercorke.com/toolboxes/robotics-toolbox/2.
2. Desde el explorador de archivos de Matlab dirigirse a la ubicación del archivo descargado y dar doble click sobre el mismo para finalizar la instalación.

#### *BITalino Toolbox* de Matlab
1. Se puede descargar directamente desde la sección *Add-ons* en MATLAB o desde el siguiente enlace: https://www.mathworks.com/matlabcentral/fileexchange/53983-bitalino-toolbox.
2. La instalación más detallada se puede encontrar en el manual de usuario de interfaces EMG.

#### *Signal Processing Toolbox* de Matlab

1. Se puede descargar directamente desde la sección *Add-ons* en MATLAB o desde el siguiente enlace: https://www.mathworks.com/products/signal.html.
2. Este *toolbox* es necesario para las etapas de filtrado de las señales.

#### *EMG Feature Extraction Toolbox* de Matlab

1. Se puede descargar directamente desde la sección *Add-ons* en MATLAB o desde el siguiente enlace: https://www.mathworks.com/matlabcentral/fileexchange/71514-emg-feature-extraction-toolbox.
2. Este *toolbox* es necesario para las etapas de extracción de características de las señales EMG.

#### *EEG Feature Extraction Toolbox* de Matlab

1. Se puede descargar directamente desde la sección *Add-ons* en MATLAB o desde el siguiente enlace: https://www.mathworks.com/matlabcentral/fileexchange/84235-eeg-feature-extraction-toolbox
2. Este *toolbox* es necesario para las etapas de extracción de características de las señales EEG.

### 1.3 MATLAB®. 

1. Se puede descargar directamente desde el siguiente enlace: https://www.mathworks.com/products/matlab.html
2. Es necesario que la versión de MATLAB que se utilice, sea una versión igual o posterior a Matlab 2017a. Ya que el *toolbox* que sirve para la conexión con bitalino fue hecha para ese Matlab.

### 1.4 OpenBCI LSL Setup. 
1. Se necesita tener Python 2.7 o posterior.
2. Se debe de seguir los pasos de instalación establecidos en el repositorio del siguiente enlace: https://github.com/openbci-archive/OpenBCI_MATLAB
3. Se debe de seguir los pasos en el siguiente enlace para poder implementar el repositorio en MATLAB: https://irenevigueguix.wordpress.com/2016/07/22/openbci-lab-streaming-layer-lsl/
## Estructura de Carpetas 
A continuación se presenta la estructura y contenido de las carpetas de este repositorio.

### 2.1 Código 
En esta carpeta se encuentran las carpetas siguientes:

1. **Base de datos Pública**
    * Extracción de características Base de datos.
    * Redes neuronales para base de datos.
    * Máquina de soporte de vectores para base de datos.
2. **Interfaces**
    * **Interfaces EMG**
      + Interfaz para recolección de datos EMG.
      + Interfaz clasificadora de señales EMG
    * **Interfaces EEG**
       + Interfaz para recolección de datos EEG.
       + Interfaz clasificadora de señales EEG
    * **Interfaces EEG-EMG**
       + Interfaz para recolección de datos EEG-EMG.
       + Interfaz clasificadora de señales EEG-EMG.
3. **Pruebas**
    + En está carpeta se pueden encontrar ejemplos y pruebas que se realizaron en las diversas etapas de la investigación 
4. **R17**
    + En está carpeta se pueden encontrar todos los códigos, funciones e interfaces creadas por José David Pellecer en su trabajo de graduación. 


### 2.2 Documentos
En esta carpeta se encuentra los documentos de protocolo, tesis, artículo y manuales de usuario.

### 2.3 Hardware
En esta carpeta se encuentra datasheets y links, para entender mejor los dispositivos y sensores de recopilación de señales. 