% =========================================================================
% Generador de matriz de DH.
% -------------------------------------------------------------------------
% Los parámetros son los correspondientes a los parámetros DH. La función
% devuelve la matríz de transformación correspondiente a cada uno de los
% eslabones del manipulador.
% =========================================================================
function A = genDHmatrix(theta, d, a, alpha)

Rotz = [cos(theta) -sin(theta) 0 0;
        sin(theta) cos(theta) 0 0;
        0 0 1 0;
        0 0 0 1];
    
Translz = [1 0 0 0;
           0 1 0 0;
           0 0 1 d;
           0 0 0 1];
       
Translx = [1 0 0 a;
           0 1 0 0;
           0 0 1 0;
           0 0 0 1];
       
Rotx = [1 0 0 0;
        0 cos(alpha) -sin(alpha) 0;
        0 sin(alpha) cos(alpha) 0;
        0 0 0 1];

A = Rotz*Translz*Translx*Rotx;      
end