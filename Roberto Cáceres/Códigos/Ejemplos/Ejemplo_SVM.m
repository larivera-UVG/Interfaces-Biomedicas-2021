%% Ejemplo de SVM multiclase
%  Dise�o e Innovaci�n de Ingenier�a 1
%  Luis Alberto Rivera

load('Ejemplo_SVM_datos.mat');

% Gr�fica de muestras originales (en este ejemplo, son 3 clases tri-dimensionales)
% X1, X2 y X3 contienen datos de las clases 1, 2 y 3, respectivamente
% Notar que los datos son vectores fila. �stos ser�an los "feature vectors".
figure(1); clf;
scatter3(X1(:,1), X1(:,2) ,X1(:,3), 'b');
hold on;
scatter3(X2(:,1), X2(:,2), X2(:,3), 'r');
scatter3(X3(:,1), X3(:,2), X3(:,3), 'g');
grid on;
xlabel('x1'); ylabel('x2'); zlabel('x3');
legend('Clase 1', 'Clase 2', 'Clase 3');
title('Muestras Originales');

pause(0.5);  % Para que la gr�fica se muestre de una vez, no al final de la ejecuci�n

%% Entrenamiento de modelo SVM, usando distintos tipos de Kernel
%  Nota: El entrenamiento y la validaci�n cruzada pueden tomar alg�n tiempo.

X = [X1;X2;X3];  % Todos los datos juntos
% Las etiquetas son n�meros enteros, distintos para cada clase. Podr�an usarse otro tipo
% de etiquetas.
Etiquetas = [ones(size(X1,1),1); 2*ones(size(X2,1),1); 3*ones(size(X3,1),1)];

% Primero se escoge el tipo de Kernel
tipo_Kernel = 2; % 0 - Gaussiano, 1 - Lineal, 2 - Polinom. grado 2, 3 - Polinom. grado 3

switch tipo_Kernel 
    case 0
        plantilla = templateSVM('KernelFunction', 'gaussian');
        
    case 1
        plantilla = templateSVM('KernelFunction', 'linear');
        
    case 2
        plantilla = templateSVM('KernelFunction', 'polynomial', 'PolynomialOrder', 2);
        
    case 3
        plantilla = templateSVM('KernelFunction', 'polynomial', 'PolynomialOrder', 3);
end

% Luego se entrena el clasificador (modelo). La opci�n de Verbose es para deplegar
% mensajes durante el entrenamiento. No es necesario.
Mdl = fitcecoc(X, Etiquetas, 'Learners', plantilla, 'Verbose', 2);

% Validaci�n cruzada
CVMdl = crossval(Mdl);

% Porcentaje de error de clasificaci�n (promedio de la validaci�n cruzada).
genError = 100*kfoldLoss(CVMdl)


%% Clasificaci�n de muestras nuevas, no usadas antes
Xtest = [5,-1,0;2,-1,2;3,1,5];  % 3 muestras (vectores fila)
Clasif_test = predict(Mdl,Xtest)
