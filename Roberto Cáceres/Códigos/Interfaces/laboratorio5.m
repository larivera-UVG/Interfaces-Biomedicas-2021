% =========================================================================
% MT3005 - LABORATORIO 6: Cinemática diferencial numérica de manipuladores 
% seriales
% -------------------------------------------------------------------------
% Ver las instrucciones en la guía adjunta para el problema de la
% cinemática diferencial numérica para el robot R17
% =========================================================================
%% Parámetros DH del robot

theta1 = 0; a1 = 0; alpha1 = -pi/2; offst1 = 0;

d2 = -0.355;
a2 = 0;
alpha2 = -pi/2;
offst2 = pi/2;

% d3 = 0;
% a3 = 0.375;
% alpha3 = 0;
% offst3 = pi/2;

d3 = 0;
a3 = 0.375;
alpha3 = 0;
offst3 = pi/2;

d4 = 0;
a4 = 0.375;
alpha4 = 0;
offst4 = 0;

d5 = 0*(0.154 - 0.113) / 2;
a5 = 0*0.04;
alpha5 = -pi/2;%-pi/2;
offst5 = -pi/2;%-pi/2;

d6 = 0;
a6 = 0;
alpha6 = 0*pi/2;
offst6 = pi/2;

%% Definición de links y creación del robot
L1 = Prismatic('theta', theta1, 'a', a1, 'alpha', alpha1, 'offset', offst1);
L2 = Revolute('d', d2, 'a', a2, 'alpha', alpha2, 'offset', offst2);
L3 = Revolute('d', d3, 'a', a3, 'alpha', alpha3, 'offset', offst3);
L4 = Revolute('d', d4, 'a', a4, 'alpha', alpha4, 'offset', offst4);
L5 = Revolute('d', d5, 'a', a5, 'alpha', alpha5, 'offset', offst5);
L6 = Revolute('d', d6, 'a', a6, 'alpha', alpha6, 'offset', offst6);

L1.qlim = [0, 1.2];

R17mdl = SerialLink([L1, L2, L3, L4, L5, L6], 'name', 'R17');
R17mdl.base = transl(0, 0, d2)*trotx(-pi/2);
%R17mdl.tool = trotx(-pi/2);

q0 = [0, 0, 0, 0, 0, 0];
R17mdl.plot(q0, 'workspace', 1.5*[-1, 1, -1, 1, -1, 1], 'reach',1)
R17mdl.teach()

% %% Visualización
% figure;
% q0 = zeros(1,7);
% sawyer.plot(q0, 'zoom', 3);
% 
% figure;
% sawyer.plot(q0, 'zoom', 3);
% sawyer.teach();
% q1 = [pi/2, 0, 0, pi/2, -pi/2, pi, -pi/2];
% 
% %% Cinemática directa
% q2 = [pi/2, -pi/4, pi/4, pi/2, -pi/4, pi/2, pi/4];
% T1 = sawyer.fkine(q2); T1 = T1.T;
% t1 = T1(1:3,4);
% R1 = T1(1:3,1:3);
% theta1 = tr2rpy(R1, 'deg')';
