% =========================================================================
% Cinem�tica directa del R17
% -------------------------------------------------------------------------
% Los par�metros son el vector de configuraci�n del robot. La funci�n
% devuelve la cinem�tica directa en la forma de una matriz de
% transformaci�n homog�nea.
% =========================================================================
function T = R17FK(q)
    % Matriz de par�metros Denavit-Hartenberg
    DH = [           0,   q(1),     0, -pi/2; 
           q(2) + pi/2, -0.355,     0, -pi/2; 
           q(3) + pi/2,      0, 0.375,     0;
                  q(4),      0, 0.375,     0;
           q(5) - pi/2,      0,     0, -pi/2;
           q(6) + pi/2,      0,     0,     0];

    % Transformaci�n de base
    T_base = [ 1,  0, 0,      0; 
               0,  0, 1,      0;
               0, -1, 0, -0.355;
               0,  0, 0,      1 ];
           
    % Falta a�adir la transformaci�n de herramienta.
    
    T = T_base*getFK(DH); 
end