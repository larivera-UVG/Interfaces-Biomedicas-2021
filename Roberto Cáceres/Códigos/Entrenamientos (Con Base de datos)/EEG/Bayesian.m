%%  Naive Bayes

%Roberto Caceres - 17163
%2021
% 
% Naive Bayes model with Gaussian, multinomial, or kernel predictors
% Naive Bayes models assume that observations have some multivariate distribution given class membership, but the predictor or features composing the observation are independent. This framework can accommodate a complete feature set such that an observation is a set of multinomial counts.
% To train a naive Bayes model, use fitcnb in the command-line interface. After training, predict labels or estimate posterior probabilities by passing the model and predictor data to predict.

%Algoritmo Creada como alternativa a Redes Neuronales y SVM


X_input = [DatosEMG{2,1}, DatosEMG{2,3}, DatosEMG{2,7}, DatosEMG{2,9},DatosEMG{2,11}; DatosEMG{2,2},DatosEMG{2,4},DatosEMG{2,8},DatosEMG{2,10},DatosEMG{2,12}]';

Xtarget = [ones(length(DatosEMG{2,1}),1),zeros(length(DatosEMG{2,1}),1);
           zeros(length(DatosEMG{2,2}),1),ones(length(DatosEMG{2,2}),1)]';
    


classNames = ['Right','Left']; % Class order

Mdl = fitcnb(X_input, classNames)