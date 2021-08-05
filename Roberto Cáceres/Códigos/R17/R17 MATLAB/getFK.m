% =========================================================================
% Matriz de transformación para cinemática directa.
% -------------------------------------------------------------------------
% Los parámetros son la matriz de Denavit-Hartenberg. La función devuelve
% la matriz de transformación para obtener la cinemática directa a partir
% de la configuración.
% =========================================================================
function K = getFK(DH)
    
    K = eye(4);
    % Nos movemos fila a fila de la matriz de parámetros DH
    for i = 1:size(DH, 1)
         K = K*genDHmatrix(DH(i, 1), DH(i, 2), DH(i, 3), DH(i, 4)); 
    end
end