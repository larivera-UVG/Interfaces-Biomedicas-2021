% Esta función se encarga de hacer la transformación de la representación
% de la orientación en matriz de rotación a cuaterniones unitarios.

function Q = rot2cuat(R)
eta = 0.5*sqrt(1+trace(R));
eps = (1/(4*eta))*[R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)];

Q = [eta; eps];
end