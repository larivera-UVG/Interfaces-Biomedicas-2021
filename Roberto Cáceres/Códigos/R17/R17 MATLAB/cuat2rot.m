% Esta función se encarga de hacer la transformación de la representación
% de orientación en cuaterniones a su matriz de rotación.

function R = cuat2rot(Q)
eta = Q(1);
eps = Q(2:4);

%Matriz de rotación
R = (eta^2 - eps'*eps)*eye(3) + 2*eta*skew(eps) + 2*(eps*eps');
end