% Esta función se encarga de calcular la inversa de un cuaternion unitario.

function Qi = invcuat(Q)
eta = Q(1);
eps = Q(2:4);

% Cuaternión unitario
Qi = [eta; -eps];
end