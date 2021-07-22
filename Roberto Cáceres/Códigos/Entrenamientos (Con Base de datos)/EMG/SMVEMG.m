%Rodrigo Ralda - 14813
%2020
%Este codigo implementa 6 SVM con diferentes tipos de nucleo. Se encuentran comentadas las opciones
%para aplicar SVM a diferentes combinaciones de caracteristicas, pero el mejor resultado se obtuvo
%con las 4 caracteristicas.

%% SVM
for ii=1:length(data{2,2})
   if (data{2,2}(ii) == 2) 
       data{2,2}(ii) = 0;
   end
end

%MAV y ZC
% X_train = [data{2,3}(1:20,:), data{2,5}(1:20,:);
%             data{2,4}(1:20,:), data{2,6}(1:20,:)];
%         
% Y= [data{2,1}(1:20,:);
%     data{2,2}(1:20,:)];
% 
% X_test = [data{2,3}(21:end,:), data{2,5}(21:end,:);
%            data{2,4}(21:end,:), data{2,6}(21:end,:)];

%VAR y KUR

% X_train = [data{2,7}(1:20,:), data{2,9}(1:20,:);
%             data{2,8}(1:20,:), data{2,10}(1:20,:)];
%         
% Y= [data{2,1}(1:20,:);
%     data{2,2}(1:20,:)];
% 
% X_test = [data{2,7}(21:end,:), data{2,9}(21:end,:);
%            data{2,8}(21:end,:), data{2,10}(21:end,:)];

%Todas juntas
%X_train = [data{2,1}(1:30,:), data{2,3}(1:30,:), data{2,5}(1:30,:), data{2,7}(1:30,:),data2{2,1}(1:30,:),data2{2,3}(1:30,:),data2{2,5}(1:30,:),data2{2,7}(1:30,:); data{2,2}(1:30,:), data{2,4}(1:30,:), data{2,6}(1:30,:), data{2,8}(1:30,:),data2{2,2}(1:30,:),data2{2,4}(1:30,:),data2{2,6}(1:30,:),data2{2,8}(1:30,:)];
% X_train = [data{2,1}(1:30,:), data{2,3}(1:30,:), data{2,5}(1:30,:), data{2,7}(1:30,:); data{2,2}(1:30,:), data{2,4}(1:30,:), data{2,6}(1:30,:), data{2,8}(1:30,:)];       
X_train = [data{2,1}(1:30,:), data{2,3}(1:30,:), data{2,5}(1:30,:), data{2,7}(1:30,:);data2{2,1}(1:30,:),data2{2,3}(1:30,:),data2{2,5}(1:30,:),data2{2,7}(1:30,:); data{2,2}(1:30,:), data{2,4}(1:30,:), data{2,6}(1:30,:), data{2,8}(1:30,:);data2{2,2}(1:30,:),data2{2,4}(1:30,:),data2{2,6}(1:30,:),data2{2,8}(1:30,:)];

%Xtarget = [ones(length(data{2,1}(1:30,:)),1);  2*ones(length(data{2,2}(1:30,:)),1)];

Xtarget = [ones(length(data{2,1}(1:30,:)),1);  2*ones(length(data{2,2}(1:30,:)),1);  3*ones(length(data{2,2}(1:30,:)),1);  4*ones(length(data{2,2}(1:30,:)),1)];

Y= Xtarget ;

X_test = [data{2,1}(31:end,:), data{2,3}(31:end,:), data{2,5}(31:end,:), data{2,7}(31:end,:);data2{2,1}(31:50,:),data2{2,3}(31:50,:),data2{2,5}(31:50,:),data2{2,7}(31:50,:); data{2,2}(31:end,:), data{2,4}(31:end,:), data{2,6}(31:end,:), data{2,8}(31:end,:);data2{2,2}(31:50,:),data2{2,4}(31:50,:),data2{2,6}(31:50,:),data2{2,8}(31:50,:)];

%X_test = [data{2,1}(31:end,:), data{2,3}(31:end,:), data{2,5}(31:end,:), data{2,7}(31:end,:),data2{2,1}(31:50,:),data2{2,3}(31:50,:),data2{2,5}(31:50,:),data2{2,7}(31:50,:); data{2,2}(31:end,:), data{2,4}(31:end,:), data{2,6}(31:end,:), data{2,8}(31:end,:),data2{2,2}(31:50,:),data2{2,4}(31:50,:),data2{2,6}(31:50,:),data2{2,8}(31:50,:)];
 
%X_test = [data{2,1}(31:end,:), data{2,3}(31:end,:), data{2,5}(31:end,:), data{2,7}(31:end,:); data{2,2}(31:end,:), data{2,4}(31:end,:), data{2,6}(31:end,:), data{2,8}(31:end,:)];      
 %--------------------------------------       
%Ysol= [ones(length(data{2,1}(31:end,:)),1);  2*ones(length(data{2,2}(31:end,:)),1)];
Ysol= [ones(length(data{2,1}(31:end,:)),1);  2*ones(length(data{2,2}(31:end,:)),1);  3*ones(length(data{2,2}(31:end,:)),1);  4*ones(length(data{2,2}(31:end,:)),1)];
        
%figure(7); clf;
%gscatter(X_train,Y);
%grid on;
%title('Muestras de Entrenamiento');

%% Crear celdas y vectores para guardar modelos y otras cosas
ModeloSVM = cell(1,6);
ModeloVC = cell(1,6);
errorVC = zeros(1,6);
asignado = cell(1,6);
valores = cell(1,6);
titulos = {'Kernel Lineal','Kernel Polinomial Grado 2','Kernel Polinomial Grado 3',...
           'Kernel Polinomial Grado 4','Kernel Gaussiano, Muestras No Estandarizadas',...
           'Kernel Gaussiano, Muestras Estandarizadas'};
%% Entrenamiento, variando Kernels y ciertos parámetros
%ModeloSVM{1} = fitcsvm(X_train,Y,'KernelFunction','linear','KernelScale','auto');
ModeloSVM{1} = fitcecoc(X_train,Y);
%ModeloSVM{2} = fitcsvm(X_train,Y,'KernelFunction','polynomial','KernelScale','auto','PolynomialOrder',2);
%ModeloSVM{3} = fitcsvm(X_train,Y,'KernelFunction','polynomial','KernelScale','auto','PolynomialOrder',3);
%ModeloSVM{4} = fitcsvm(X_train,Y,'KernelFunction','polynomial','KernelScale','auto','PolynomialOrder',4);
%ModeloSVM{5} = fitcsvm(X_train,Y,'KernelFunction','rbf','KernelScale','auto');
%ModeloSVM{6} = fitcsvm(X_train,Y,'KernelFunction','rbf','KernelScale','auto','Standardize',true);

% Se hace validación cruzada con las muestras de entrenamiento, se calcula el error
% de clasificación de la validación cruzada, se clasifican las muestras de prueba,
% y se grafican resultados. Todo lo anterior para los 6 modelos de arriba.
[fil,col] = size(ModeloSVM);
for k = 1:col
    % Validación cruzada, clasificación errónea
    ModeloVC{k} = crossval(ModeloSVM{k});
    errorVC(k) = kfoldLoss(ModeloVC{k});
    
    % Clasificación de las muestras de prueba
    [asignado{2},valores{2}] = predict(ModeloSVM{1},X_test); % etiquetas asignadas, valores
    
    % Gráficas
    figure(k); clf;
    subplot(1,2,1);
    gscatter(X_train(:,1),X_train(:,2),Y); hold on;
    % Vectores de soporte
    plot(X_train(ModeloSVM{k}.IsSupportVector,1),X_train(ModeloSVM{k}.IsSupportVector,2),'ko','MarkerSize',10);
    % Frontera de decisión
   % contour(x1Grid,x2Grid,reshape(valores{k}(:,2),size(x1Grid)),[0 0],'k');
    grid on;
    title('Muestras de Entrenamiento y Frontera de Decisión')
    legend({'1','2','Support Vectors'},'Location','Best');
    
    subplot(1,2,2);
    gscatter(X_test(:,1),X_test(:,2),asignado{k});
    legend({'1','2'},'Location','Best');
    grid on;
    title('Muestras de Prueba');
    %sgtitle(sprintf('%s.    Error en la Validación Cruzada: %.2f%%',titulos{k},100*errorVC(k)));
    
end
NYsol = full(ind2vec(Ysol',4));
NAsig = full(ind2vec(asignado{1,2}',4))
%confusionmat
%crosstab
%confusionmat(Ysol,asignado{1,1});
figure(9); clf;
plotconfusion(NYsol,NAsig);