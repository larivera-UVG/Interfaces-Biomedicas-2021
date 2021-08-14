%% Pruebas de trayectorias

%% Inicialización
% 2. Inicializar el R17, se debe indicar el puerto COM y su velocidad.
PuertoCOM = 'COM3';
speed = 10000;
R17 = R17Init(PuertoCOM, speed);

%% Moverse a posición HOME
R17Command(R17, 'HOME');

%% Crear un PLACE

% Primero nos dirigimos al punto donde queremos ir

% R17Command(R17, "CARTESIAN");

x = 0;
y = 0;
z = 650;
roll = 10;
pitch = 50;
yaw = 0;

x = 10*x;
y = 10*y;
z = 10*z;
roll = 10*roll;
pitch = 10*pitch;
yaw = 10*yaw;

R17Command(R17, string(x) + " " + string(y) + " " + string(z) +...
            " MOVETO");
% R17Command(R17, "WHERE");

% R17Command(R17, "WRIST PITCH " + string(pitch));
R17Command(R17, "JOINT TELL HAND 4000 MOVE");

% R17Command(R17, "WRIST ROLL " + string(roll));
% R17Command(R17, "WRIST PITCH " + string(pitch));
% 

pause(2);
% Se guarda el punto como un PLACE llamado JIG
R17Command(R17, "PLACE JIG");

% Se despliega los PLACES guardados
R17Command(R17, "PLACES");


%% Crear el APPROACH

R17Command(R17, "CARTESIAN");

x = 0;
y = 0;
z = 450;
roll = 10;
pitch = 50;
yaw = 0;

x = 10*x;
y = 10*y;
z = 10*z;
roll = 10*roll;
pitch = 10*pitch;
yaw = 10*yaw;

R17Command(R17, string(x) + " " + string(y) + " " + string(z) +...
            " MOVETO");
R17Command(R17, "WHERE");

pause(2);
% Se guarda el punto como un APPROACH del PLACE JIG
R17Command(R17, "APPROACH JIG");

pause(2);
% Se despliega los PLACES guardados
R17Command(R17, "PLACES");

%% Crear la rutina

R17Command(R17, ": TEST");
R17Command(R17, "HOME");
R17Command(R17, "JIG");
R17Command(R17, "WITHDRAW");
R17Command(R17, ";");

%% Probar la rutina

R17Command(R17, "TEST");


%% Cambiar JIG

x = 0;
y = 0;
z = 550;
roll = 10;
pitch = 50;
yaw = 0;

x = 10*x;
y = 10*y;
z = 10*z;
roll = 10*roll;
pitch = 10*pitch;
yaw = 10*yaw;

R17Command(R17, string(x) + " " + string(y) + " " + string(z) +...
            " MOVETO");
% R17Command(R17, "WHERE");

pause(5);
R17Command(R17, "PLEARN JIG");

%% Rutas

% No es necesario si ya está en modo Cartesian
% R17Command(R17Obj, "CARTESIAN"); 
R17Command(R17, "ROUTE R1");

% Se reserva espacio en memoria para 10 lineas (posiciones) en la ruta
lines = 10;
R17Command(R17, string(lines) + " RESERVE");

%Aquí se debe de tomar una posición en el robot, la cual será recordada
%dentro de la ruta. Luego efectuar los comandos a continuación y repetir
%para cada punto.

% Ir a la coordenada:
x = 300;
y = 0;
z = 450;
roll = 10;
pitch = 50;
yaw = 0;

x = 10*x;
y = 10*y;
z = 10*z;
roll = 10*roll;
pitch = 10*pitch;
yaw = 10*yaw;

R17Command(R17, string(x) + " " + string(y) + " " + string(z) +...
            " MOVETO");
pause(5);
R17Command(R17, "LEARN");

R17Command(R17, "HOME");
R17Command(R17, "R1 1 GOTO");
R17Command(R17, "R1 2 GOTO");
R17Command(R17, "R1 3 GOTO");
R17Command(R17, "R1 4 GOTO");
R17Command(R17, "R1 5 GOTO");
R17Command(R17, "R1 6 GOTO");

line = 5;
R17Command(R17, string(line) + " REPLACE");
% Elimina la última linea creada
R17Command(R17, "UNLEARN");
% Elimina la linea especificada
R17Command(R17, string(line) + " DELETE");

% Mostrar la ruta creada
R17Command(R17, "LISTROUTE");

%% Correr la ruta R1

% Corre la ruta de manera segmentada
% R17Command(R17, "SEGMENTED");
R17Command(R17, "SEGMENTED R1 RUN");

% Corre la ruta de manera continua
% R17Command(R17, "CONTINUOUS");
R17Command(R17, "CONTINUOUS R1 RUN");

%% Correr la ruta R1 en reversa

% Corre la ruta de manera segmentada en reversa
R17Command(R17, "SEGMENTED");
R17Command(R17, "R1 RETRACE");

% Corre la ruta de manera continua en reversa
R17Command(R17, "CONTINUOUS");
R17Command(R17, "R1 RETRACE");

