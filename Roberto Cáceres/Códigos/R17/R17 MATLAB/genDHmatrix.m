% =========================================================================
% Generador de matriz de DH.
% -------------------------------------------------------------------------
% Los par�metros son los correspondientes a los par�metros DH. La funci�n
% devuelve la matr�z de transformaci�n correspondiente a cada uno de los
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