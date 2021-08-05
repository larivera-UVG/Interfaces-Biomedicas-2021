%% Modelado Peter Corke

clear;
clc;
% =========================================================================
%% Matriz de DH
q = [0 0 0 0 0 0];
DH = [           0,   q(1),     0, -pi/2; 
           q(2) + pi/2, -0.355,     0, -pi/2; 
           q(3) + pi/2,      0, 0.375,     0;
                  q(4),      0, 0.375,     0;
           q(5) - pi/2,      0,     0, -pi/2;
           q(6) + pi/2,      0,     0,     0];

T_base = [ 1,  0, 0,      0; 
           0,  0, 1,      0;
           0, -1, 0, -0.355;
           0,  0, 0,      1 ];
       
%R17mdl.base = transl(0, 0, d2)*trotx(-pi/2);

%% Definición de links y creación de las patas del robot
offset1 = 0;
theta1 = DH(1,1);
a1 = DH(1,3);
alpha1 = DH(1,4);
qlim1 = [-0.6, 0.6];
L1 = Prismatic('theta', theta1, 'a', a1, 'alpha', alpha1, 'offset', offset1, 'qlim', qlim1);

offset2 = DH(2,1);
d2 = DH(2,2);
a2 = DH(2,3);
alpha2 = DH(2,4);
L2 = Revolute('d', d2, 'a', a2, 'alpha', alpha2, 'offset', offset2);

offset3 = DH(3,1);
d3 = DH(3,2);
a3 = DH(3,3);
alpha3 = DH(3,4);
L3 = Revolute('d', d3, 'a', a3, 'alpha', alpha3, 'offset', offset3);

offset4 = DH(4,1);
d4 = DH(4,2);
a4 = DH(4,3);
alpha4 = DH(4,4);
L4 = Revolute('d', d4, 'a', a4, 'alpha', alpha4, 'offset', offset4);

offset5 = DH(5,1);
d5 = DH(5,2);
a5 = DH(5,3);
alpha5 = DH(5,4);
L5 = Revolute('d', d5, 'a', a5, 'alpha', alpha5, 'offset', offset5);

offset6 = DH(6,1);
d6 = DH(6,2);
a6 = DH(6,3);
alpha6 = DH(6,4);
L6 = Revolute('d', d6, 'a', a6, 'alpha', alpha6, 'offset', offset6);

R17_PC = SerialLink([L1, L2, L3, L4, L5, L6], 'name', 'R17', 'base', T_base);
%R17_PC.base = transl(0, 0, d2)*trotx(-pi/2);

%% Visualización
q0 = [-0.3, 0, 0, 0, 0, 0];
%figure(1);
workspace = 1.2*[-1, 1, -1, 1, -1, 1];
R17_PC.plot(q0, 'zoom', 2, 'workspace', workspace, 'nobase', 'notiles', 'noname', 'noshadow', 'nojaxes');

% figure(2);
% R17_PC.teach(q0,'zoom', 2, 'nobase', 'notiles');
%q1 = [pi/2, 0, 0, pi/2, -pi/2, pi, -pi/2];

%% Cinemática directa
q0 = [0.2, pi/3, pi/4, 0, 0, 0];
TF2 = R17_PC.fkine(q0);

T = R17FK(q0);

qi = R17IK(T, [0 0 0 0 0 0]', 0)
T1 = R17FK(qi);


%% Cinemática inversa
