% Esta funci�n se encarga de hacer la transformaci�n de la representaci�n
% de orientaci�n en cuaterniones a su matriz de rotaci�n.

function R = cuat2rot(Q)
eta = Q(1);
eps = Q(2:4);

%Matriz de rotaci�n
R = (eta^2 - eps'*eps)*eye(3) + 2*eta*skew(eps) + 2*(eps*eps');
end