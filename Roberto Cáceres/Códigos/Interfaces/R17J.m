% =========================================================================
% Cálculo numérico del Jacobiano para R17
% -------------------------------------------------------------------------
% Los parámetros son el vector de configuración del robot. La función
% devuelve el jacobiano del manipulador.
% =========================================================================
function J = R17J(q)
    % El argumento q es el vector de configuración, el cual está dado por
    % un vector columna q = [q1; q2; q3; q4; q5; q6].
    
    % Dimensión de la configuración del manipulador R17
    n = 6;
    delta = 0.00001;
    
    % Cinemática directa del manipulador R17
    T = R17FK(q); 
    % Orientación en matriz de rotación
    R = T(1:3, 1:3);
    
    % Inicialización del jacobiano
    J = zeros(6, n);
    
% Algoritmo numérico para calcular el jacobiano
for j = 1:n
    e = zeros(n, 1);
    e(j) = delta;
    
    dKdqj = (R17FK(q+e) - T) / delta;
    dtdqj = dKdqj(1:3,end);
    dRdqj = dKdqj(1:3,1:3);
    S = dRdqj*R.';
    dthetadqj = vex(S);
    
    J(:, j) = [dtdqj; dthetadqj];
end

end 