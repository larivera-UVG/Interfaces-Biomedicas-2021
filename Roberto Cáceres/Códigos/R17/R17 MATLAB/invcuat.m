% Esta funci�n se encarga de calcular la inversa de un cuaternion unitario.

function Qi = invcuat(Q)
eta = Q(1);
eps = Q(2:4);

% Cuaterni�n unitario
Qi = [eta; -eps];
end