% =========================================================================
% Matriz de transformaci�n para cinem�tica directa.
% -------------------------------------------------------------------------
% Los par�metros son la matriz de Denavit-Hartenberg. La funci�n devuelve
% la matriz de transformaci�n para obtener la cinem�tica directa a partir
% de la configuraci�n.
% =========================================================================
function K = getFK(DH)
    
    K = eye(4);
    % Nos movemos fila a fila de la matriz de par�metros DH
    for i = 1:size(DH, 1)
         K = K*genDHmatrix(DH(i, 1), DH(i, 2), DH(i, 3), DH(i, 4)); 
    end
end