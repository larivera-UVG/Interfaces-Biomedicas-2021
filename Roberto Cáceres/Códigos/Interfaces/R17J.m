% =========================================================================
% C�lculo num�rico del Jacobiano para R17
% -------------------------------------------------------------------------
% Los par�metros son el vector de configuraci�n del robot. La funci�n
% devuelve el jacobiano del manipulador.
% =========================================================================
function J = R17J(q)
    % El argumento q es el vector de configuraci�n, el cual est� dado por
    % un vector columna q = [q1; q2; q3; q4; q5; q6].
    
    % Dimensi�n de la configuraci�n del manipulador R17
    n = 6;
    delta = 0.00001;
    
    % Cinem�tica directa del manipulador R17
    T = R17FK(q); 
    % Orientaci�n en matriz de rotaci�n
    R = T(1:3, 1:3);
    
    % Inicializaci�n del jacobiano
    J = zeros(6, n);
    
% Algoritmo num�rico para calcular el jacobiano
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