% =========================================================================
% Cinemática inversa del R17
% -------------------------------------------------------------------------
% Los parámetros son la pose deseada, la configuración inicial y
% la opción "solop" para indicar si calcular la cinemática inversa o total.
% La función devuelve la configuración del manipulador.

function q = R17IK(Td, q0, solop)
% Tolerancia del error de posición
tol_p = 1e-06;

% Tolerancia del error de orientación
tol_o = 1e-05;

% Número máximo de iteraciones (reducir en caso de mala performance
% durante la simulación)
K = 10000;

% Posición deseada del efector final
pd = Td(1:3, 4);

% Configuración inicial
q = q0;

% Cinemática directa actual
T = R17FK(q);

% Posición actual
p = T(1:3, 4);

% Operaciones con cuaterniones
% Matriz de rotación de la pose deseada
Rd = Td(1:3, 1:3);

% Cuaternión unitario de la orientación deseada
qtd = rot2cuat(Rd);

% Matriz de rotación actual
R = T(1:3, 1:3);

% Cuaternión unitario de la orientación actual
qt = rot2cuat(R);

% Cuaternión unitario inverso de la orientación actual
qt_inv = invcuat(qt);

% Error de orientación (parte vectorial de qtd*qt_inv)
qe = multcuat(qtd, qt_inv);
e_o = qe(2:4);

% Creación de arreglo para almacenar los valores de cada itereación del
% algoritmo.
Q = zeros(numel(q), K);
Q(:,1) = q;

% Error de posición
e_p = pd - p;
k = 0;


% Se efectúa el algoritmo de cinemática inversa, si solop == 1 se calcula
% solo la cinemática inversa de posición, de lo contrario se calcula la
% cinemática total.
if (solop == 1)
    while((norm(e_p) > tol_p) && (k < K))
        T = R17FK(q);
        p = T(1:3, 4);
        e_p = pd - p;
        J = R17J(q);
        Jv = J(1:3,:);
        
        Jiv = Jv'/(Jv*Jv'+(sqrt(0.1))^2*eye(3)); %jacobiano de posicion
        
        q = q + Jiv*e_p; % Se actualiza la solución
        k = k + 1; % Se incrementa el número de iteración
        Q(:,k+1) = q; % Se almacena la configuración en el histórico
    end
    
else
    while((norm(e_p) > tol_p) && (norm(e_o) > tol_o) && (k < K))
        
        T = R17FK(q);
        p = T(1:3, 4);
        R = T(1:3, 1:3);
        qt = rot2cuat(R);
        qt_inv = invcuat(qt);
        
        % Errores
        e_p = pd - p;
        qe = multcuat(qtd, qt_inv);
        e_o = qe(2:4);
        
        % Jacobiano
        J = R17J(q);
        
        % Jacobiano por el método de Levenberg-Marquadt
        Ji = J'/(J*J'+(sqrt(0.01))^2*eye(6));
        
        % Se combinan los errores de posición y orientación
        e = [e_p; e_o];
        
        % Se actualiza la solución
        q = q + Ji*e;
        
        % Se incrementa el número de iteración% Se incrementa el número
        % de iteración
        k = k + 1;
        
        % Se almacena la configuración en el histórico
        Q(:,k+1) = q;
    end
end
Q = Q(:,1:k+1); % Se extrae sólo la parte del histórico que se empleó
fprintf('El número de iteraciones empleadas fue de: %d iteraciones\n',k+1);
end