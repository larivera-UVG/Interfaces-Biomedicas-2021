% =========================================================================
% Cinem�tica inversa del R17
% -------------------------------------------------------------------------
% Los par�metros son la pose deseada, la configuraci�n inicial y
% la opci�n "solop" para indicar si calcular la cinem�tica inversa o total.
% La funci�n devuelve la configuraci�n del manipulador.

function q = R17IK(Td, q0, solop)
% Tolerancia del error de posici�n
tol_p = 1e-06;

% Tolerancia del error de orientaci�n
tol_o = 1e-05;

% N�mero m�ximo de iteraciones (reducir en caso de mala performance
% durante la simulaci�n)
K = 10000;

% Posici�n deseada del efector final
pd = Td(1:3, 4);

% Configuraci�n inicial
q = q0;

% Cinem�tica directa actual
T = R17FK(q);

% Posici�n actual
p = T(1:3, 4);

% Operaciones con cuaterniones
% Matriz de rotaci�n de la pose deseada
Rd = Td(1:3, 1:3);

% Cuaterni�n unitario de la orientaci�n deseada
qtd = rot2cuat(Rd);

% Matriz de rotaci�n actual
R = T(1:3, 1:3);

% Cuaterni�n unitario de la orientaci�n actual
qt = rot2cuat(R);

% Cuaterni�n unitario inverso de la orientaci�n actual
qt_inv = invcuat(qt);

% Error de orientaci�n (parte vectorial de qtd*qt_inv)
qe = multcuat(qtd, qt_inv);
e_o = qe(2:4);

% Creaci�n de arreglo para almacenar los valores de cada itereaci�n del
% algoritmo.
Q = zeros(numel(q), K);
Q(:,1) = q;

% Error de posici�n
e_p = pd - p;
k = 0;


% Se efect�a el algoritmo de cinem�tica inversa, si solop == 1 se calcula
% solo la cinem�tica inversa de posici�n, de lo contrario se calcula la
% cinem�tica total.
if (solop == 1)
    while((norm(e_p) > tol_p) && (k < K))
        T = R17FK(q);
        p = T(1:3, 4);
        e_p = pd - p;
        J = R17J(q);
        Jv = J(1:3,:);
        
        Jiv = Jv'/(Jv*Jv'+(sqrt(0.1))^2*eye(3)); %jacobiano de posicion
        
        q = q + Jiv*e_p; % Se actualiza la soluci�n
        k = k + 1; % Se incrementa el n�mero de iteraci�n
        Q(:,k+1) = q; % Se almacena la configuraci�n en el hist�rico
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
        
        % Jacobiano por el m�todo de Levenberg-Marquadt
        Ji = J'/(J*J'+(sqrt(0.01))^2*eye(6));
        
        % Se combinan los errores de posici�n y orientaci�n
        e = [e_p; e_o];
        
        % Se actualiza la soluci�n
        q = q + Ji*e;
        
        % Se incrementa el n�mero de iteraci�n% Se incrementa el n�mero
        % de iteraci�n
        k = k + 1;
        
        % Se almacena la configuraci�n en el hist�rico
        Q(:,k+1) = q;
    end
end
Q = Q(:,1:k+1); % Se extrae s�lo la parte del hist�rico que se emple�
fprintf('El n�mero de iteraciones empleadas fue de: %d iteraciones\n',k+1);
end