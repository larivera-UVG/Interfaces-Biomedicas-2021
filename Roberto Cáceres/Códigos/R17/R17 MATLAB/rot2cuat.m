% Esta funci�n se encarga de hacer la transformaci�n de la representaci�n
% de la orientaci�n en matriz de rotaci�n a cuaterniones unitarios.

function Q = rot2cuat(R)
eta = 0.5*sqrt(1+trace(R));
eps = (1/(4*eta))*[R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)];

Q = [eta; eps];
end