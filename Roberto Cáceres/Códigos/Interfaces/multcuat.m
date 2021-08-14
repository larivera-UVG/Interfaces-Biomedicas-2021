% Esta función se encarga de hacer la multiplicación entre 2 cuaterniones
% unitarios.

function Q = multcuat(Q1, Q2)
eta1 = Q1(1);
eps1 = Q1(2:4);

eta2 = Q2(1);
eps2 = Q2(2:4);

% Definición matemática de la multiplicación de 2 cuaterniones.
Q = [(eta1*eta2 - eps1'*eps2); (eta1*eps2 + eta2*eps1 + skew(eps1)*eps2)];
end