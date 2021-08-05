%Roberto caceres
%2021
%Este codigo tomo como base el proporcionado por el Dr. Luis Rivera y se modificio para hacerlo iterativo de acuerdo
%al tipo de las estructuras de datos que se estarana utilizando. 

%% Neural network
% 5 caracteristiscas 
%en este script y en esta seccion se estaran probando distintos tipos de entrenamiento con los datos proporcionados por la base de datos encontrada
%% Zero Crossing, MAV,  RMS, VARIANZA, Wav,  WilsonAmplitude, AverageEnergy, Skewness, IntegratedEMG, MeanAbsoluteValue

%X_input = [DatosEMG{2,1}, DatosEMG{2,3},DatosEMG{2,5}, DatosEMG{2,7}, DatosEMG{2,9},DatosEMG{2,11},DatosEMG{2,13},DatosEMG{2,15},DatosEMG{2,17},DatosEMG{2,19}; DatosEMG{2,2},DatosEMG{2,4},DatosEMG{2,6},DatosEMG{2,8},DatosEMG{2,10},DatosEMG{2,12},DatosEMG{2,14},DatosEMG{2,16},DatosEMG{2,18},DatosEMG{2,20}]';

% 84% obtenido de resultado de validacion hasta 89%


%% Zero Crossing, MAV,  RMS, VARIANZA, Wav,  WilsonAmplitude,  Skewness, IntegratedEMG, MeanAbsoluteValue
%X_input = [DatosEMG{2,1}, DatosEMG{2,3},DatosEMG{2,5}, DatosEMG{2,7}, DatosEMG{2,9},DatosEMG{2,11},DatosEMG{2,15},DatosEMG{2,17},DatosEMG{2,19}; DatosEMG{2,2},DatosEMG{2,4},DatosEMG{2,6},DatosEMG{2,8},DatosEMG{2,10},DatosEMG{2,12},DatosEMG{2,16},DatosEMG{2,18},DatosEMG{2,20}]';

% 89% obtenido de resultado de validacion

%% Zero Crossing, MAV,  RMS, VARIANZA, Wav,  WilsonAmplitude,  Skewness, IntegratedEMG 
%X_input = [DatosEMG{2,1}, DatosEMG{2,3},DatosEMG{2,5}, DatosEMG{2,7}, DatosEMG{2,9},DatosEMG{2,11},DatosEMG{2,15},DatosEMG{2,17}; DatosEMG{2,2},DatosEMG{2,4},DatosEMG{2,6},DatosEMG{2,8},DatosEMG{2,10},DatosEMG{2,12},DatosEMG{2,16},DatosEMG{2,18}]';

% 83 % obtenido de resultado de validacion

%% Zero Crossing, MAV, VARIANZA, Wav,  WilsonAmplitude,  Skewness, IntegratedEMG 
X_input = [Canal1EEG{2,3}, Canal1EEG{2,9},Canal1EEG{2,13},Canal1EEG{2,15},Canal1EEG{2,17},Canal1EMG{2,1},Canal1EMG{2,3}, Canal1EMG{2,9},Canal1EMG{2,15},Canal1EMG{2,17},Canal2EEG{2,3}, Canal2EEG{2,9},Canal2EEG{2,13},Canal2EEG{2,15},Canal2EEG{2,17},Canal2EMG{2,1},Canal2EMG{2,3}, Canal2EMG{2,9},Canal2EMG{2,15},Canal2EMG{2,17}; Canal1EEG{2,4},Canal1EEG{2,10},Canal1EEG{2,14},Canal1EEG{2,16},Canal1EEG{2,18},Canal1EMG{2,2},Canal1EMG{2,4}, Canal1EMG{2,10},Canal1EMG{2,16},Canal1EMG{2,18},Canal2EEG{2,4},Canal2EEG{2,10},Canal2EEG{2,14},Canal2EEG{2,16},Canal2EEG{2,18},Canal2EMG{2,2},Canal2EMG{2,4}, Canal2EMG{2,10},Canal2EMG{2,16},Canal2EMG{2,18}]';

%%  RMS, WAVELET 

%X_input = [ DatosEMG{2,5}, DatosEMG{2,7}; DatosEMG{2,6},DatosEMG{2,8}]';
 


Xtarget = [ones(length(Canal1EMG{2,1}),1),zeros(length(Canal1EMG{2,1}),1);
           zeros(length(Canal1EMG{2,2}),1),ones(length(Canal1EMG{2,2}),1)]';
    




x = X_input;  % Vectores que representan a las muestras (vectores de caracter�sticas).
                 % Notar que se tienen como vectores columna.
          
t = Xtarget; % Vectores con los "targets", que identifican a qu� clase pertenecen las 
                 % muestras. Para tres clases, notar que los targets tienen la forma
                 % [1; 0; 0] - clase 1  Podr�a ser [1; -1; -1], seg�n la no linealidad usada
                 % [0; 1; 0] - clase 2  Podr�a ser [-1; 1; -1], seg�n la no linealidad usada
                 % [0; 0; 1] - clase 3  Podr�a ser [-1; -1; 1], seg�n la no linealidad usada

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 10/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);  % Se pasan los datos por la red.
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);  % Investiguen esta �til funci�n. Con ella se pude determinar la clase
yind = vec2ind(y);  % f�cilmente. B�sicamente, busca en qu� fila est� el n�mero mayor.
                    % Si no tienen el toolbox que tiene a esta funci�n, s�lo es cuesti�n
                    % de determinar el �ndice de la fila con el mayor valor (por cada
                    % vector columna). Ese �ndice ser�a la clase asignada.
%percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
view(net)

% %% Ejemplos adicionales de uso de la red para clasificar
% % Para usar la red entrenada para clasificar datos nuevos, se har�a lo siguiente.
% % Se est�n usando datos del mismo x, pero, en general, se clasificar�an datos nuevos.
% 
% x_prueba = x(:,randi(size(x,2)));  % un dato al azar
% y_prueba = net(x_prueba);
% clase_prueba = vec2ind(y_prueba)   % contiene la etiqueta asignada
% 
% % Como se vio antes, se pueden clasificar varias muestras al mismo tiempo:
% xs_prueba = x(:,randperm(size(x,2), 10));  % 10 datos al azar
% ys_prueba = net(xs_prueba);
% clases_prueba = vec2ind(ys_prueba) % contiene las etiquetas asignadas
        
xs_prueba = x; % 10 datos al azar
ys_prueba = net(xs_prueba);
clases_prueba = vec2ind(ys_prueba); % contiene las etiquetas asignadas
yResp = full(ind2vec(clases_prueba));

figure(9); clf;
plotconfusion(t,yResp); 