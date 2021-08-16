%% Pruebas R17

% 1. Primero llevar a su posición de Home (extender el brazo verticalmente).

%% Inicialización
% 2. Inicializar el R17, se debe indicar el puerto COM y su velocidad.
PuertoCOM = 'COM3';
speed = 1000;
R17 = R17Init(PuertoCOM, speed);

%% Cinemática directa
% 3. Probar una configuración (cinemática directa)
% Se ingresan los valores de configuración para las revolutas en grados.

% Rango entre -0.6 y 0.6
career = 0;
% Rango entre -135 y 135 (anterior)
% Rango entre -180 y 180
waist =  100;
% Rango entre -111 y 111 (anterior)
% Rango entre -142 y 142
shouler =  0;
% Rango entre -150 y 150 (anterior)
% Rango entre -163 y 163
elbow =  0;
% Rango entre -180 y 180
hand =  0;
% Rango entre -180 y 180
wrist =  160;

q = [career; deg2rad(waist); deg2rad(shouler); deg2rad(elbow);...
     deg2rad(hand); deg2rad(wrist)];

R17fKine(R17, q);


%% Desconexión
% 4. Desconectar el R17.
R17Close(R17);

%% Otros comandos útiles
% R17Command(R17, '');

command = 1;

switch command
    case 1
        R17Command(R17, 'SPEED ?');
    case 2
        R17Command(R17, 'ACCEL ?');
    case 3
        R17Command(R17, '2000 SPEED !');
    case 4
        R17Command(R17, '2000 ACCEL !');
    case 5
        R17Command(R17, 'HOME');
    case 6
        R17Command(R17, 'CARTESIAN');
    case 7
        R17Command(R17, 'WHERE');
    case 8
        R17Command(R17, 'COMPUTE CARTWHERE');
    case 9
        R17Command(R17, 'WHEREIS PART');
    case 10
        R17Command(R17, 'HOLDING PART');
    case 11
        R17Command(R17, 'TRACKSPEED .');
    case 12
        R17Command(R17, 'ROLLSPEED .');
        case 12
        R17Command(R17, 'VIEW WORKSPACE');
end


% R17Command(R17, 'VIEW LIMITS');
% R17Command(R17, 'B-RATIO .'); %WAIST ratio
% R17Command(R17, 'S-RATIO .'); %SHOULDER ratio

%%
xlim([-500 500]);
ylim([-500 500]);
zlim([-500 500]);
plot3(-500:500,0,0);
hold on;
line(2*xlim, [0,0], [0,0], 'LineWidth', 3, 'Color', 'k');









