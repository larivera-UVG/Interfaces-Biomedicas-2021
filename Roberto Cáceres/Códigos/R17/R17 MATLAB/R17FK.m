% =========================================================================
% Cinemática directa del R17
% -------------------------------------------------------------------------
% Los parámetros son el vector de configuración del robot. La función
% devuelve la cinemática directa en la forma de una matriz de
% transformación homogénea.
% =========================================================================
function T = R17FK(q)
    % Matriz de parámetros Denavit-Hartenberg
    DH = [           0,   q(1),     0, -pi/2; 
           q(2) + pi/2, -0.355,     0, -pi/2; 
           q(3) + pi/2,      0, 0.375,     0;
                  q(4),      0, 0.375,     0;
           q(5) - pi/2,      0,     0, -pi/2;
           q(6) + pi/2,      0,     0,     0];

    % Transformación de base
    T_base = [ 1,  0, 0,      0; 
               0,  0, 1,      0;
               0, -1, 0, -0.355;
               0,  0, 0,      1 ];
           
    % Falta añadir la transformación de herramienta.
    
    T = T_base*getFK(DH); 
end