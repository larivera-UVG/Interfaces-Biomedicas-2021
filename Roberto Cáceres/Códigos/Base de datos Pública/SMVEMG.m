  %Roberto Caceres - 17163
%2021
%Este codigo implementa 6 SVM con diferentes tipos de nucleo. Se encuentran comentadas las opciones
%para aplicar SVM a diferentes combinaciones de caracteristicas, pero el mejor resultado se obtuvo
%con las 4 caracteristicas.

%% SVM
% for ii=1:length(DatosEMG{2,2})
%    if (DatosEMG{2,2}(ii) == 2) 
%        DatosEMG{2,2}(ii) = 0;
%    end
% end

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
Limit = 1000;
Init = Limit+1;
%X_train = [data{2,1}(1:30,:), data{2,3}(1:30,:), data{2,5}(1:30,:), data{2,7}(1:30,:),data2{2,1}(1:30,:),data2{2,3}(1:30,:),data2{2,5}(1:30,:),data2{2,7}(1:30,:); data{2,2}(1:30,:), data{2,4}(1:30,:), data{2,6}(1:30,:), data{2,8}(1:30,:),data2{2,2}(1:30,:),data2{2,4}(1:30,:),data2{2,6}(1:30,:),data2{2,8}(1:30,:)];
% X_train = [data{2,1}(1:30,:), data{2,3}(1:30,:), data{2,5}(1:30,:), data{2,7}(1:30,:); data{2,2}(1:30,:), data{2,4}(1:30,:), data{2,6}(1:30,:), data{2,8}(1:30,:)];       
X_train = [ Datos(1:Limit,1:8);Datos(1251:2250,1:8);Datos(2501:3500,1:8);Datos(3751:4750,1:8)]
%Xtarget = [ones(length(data{2,1}(1:30,:)),1);  2*ones(length(data{2,2}(1:30,:)),1)];

Xtarget = [ones(length(Datos(1:Limit,:)),1);  2*ones(length(Datos(1:Limit,:)),1);  3*ones(length(Datos(1:Limit,:)),1);  4*ones(length(Datos(1:Limit,:)),1)];

Y= Xtarget ;

X_test = [Datos(1001:1250,1:8);Datos(2251:2500,1:8);Datos(3501:3750,1:8);Datos(4751:5000,1:8) ]
%X_test = [data{2,1}(31:end,:), data{2,3}(31:end,:), data{2,5}(31:end,:), data{2,7}(31:end,:),data2{2,1}(31:50,:),data2{2,3}(31:50,:),data2{2,5}(31:50,:),data2{2,7}(31:50,:); data{2,2}(31:end,:), data{2,4}(31:end,:), data{2,6}(31:end,:), data{2,8}(31:end,:),data2{2,2}(31:50,:),data2{2,4}(31:50,:),data2{2,6}(31:50,:),data2{2,8}(31:50,:)];
 
%X_test = [data{2,1}(31:end,:), data{2,3}(31:end,:), data{2,5}(31:end,:), data{2,7}(31:end,:); data{2,2}(31:end,:), data{2,4}(31:end,:), data{2,6}(31:end,:), data{2,8}(31:end,:)];      
 %--------------------------------------       
%Ysol= [ones(length(data{2,1}(31:end,:)),1);  2*ones(length(data{2,2}(31:end,:)),1)];
Ysol= [ones(length(Datos(1001:1250,1:8)),1) ;  2*ones(length(Datos(1001:1250,1:8)),1);  3*ones(length(Datos(1001:1250,1:8)),1);  4*ones(length(Datos(1001:1250,1:8)),1)];
        
%figure(7); clf;
%gscatter(X_train,Y);
%grid on;
%title('Muestras de Entrenamiento');

%% Crear celdas y vectores para guardar modelos y otras cosas
ModeloSVM = cell(1,4);
ModeloVC = cell(1,4);
errorVC = zeros(1,4);
asignado = cell(1,4);
valores = cell(1,4);
titulos = {'Kernel Lineal','Kernel Polinomial Grado 2','Kernel Gaussiano, Muestras No Estandarizadas',...
           'Kernel Gaussiano, Muestras Estandarizadas'};
%% Entrenamiento, variando Kernels y ciertos parametros
ModeloSVM{1} = fitcsvm(X_train,Y,'KernelFunction','linear','KernelScale','auto');
%ModeloSVM{1} = fitcecoc(X_train,Y);
ModeloSVM{2} = fitcsvm(X_train,Y,'KernelFunction','polynomial','KernelScale','auto','PolynomialOrder',2);
ModeloSVM{3} = fitcsvm(X_train,Y,'KernelFunction','rbf','KernelScale','auto');
ModeloSVM{4} = fitcsvm(X_train,Y,'KernelFunction','rbf','KernelScale','auto','Standardize',true);

% Se hace validaci�n cruzada con las muestras de entrenamiento, se calcula el error
% de clasificaci�n de la validaci�n cruzada, se clasifican las muestras de prueba,
% y se grafican resultados. Todo lo anterior para los 6 modelos de arriba.
[fil,col] = size(ModeloSVM);
for k = 1:col
    % Validaci�n cruzada, clasificaci�n err�nea
    ModeloVC{k} = crossval(ModeloSVM{k});
    errorVC(k) = kfoldLoss(ModeloVC{k});
    
    % Clasificaci�n de las muestras de prueba
    [asignado{k},valores{k}] = predict(ModeloSVM{k},X_test); % etiquetas asignadas, valores
    
    % Gr�ficas
   % figure(k); clf;
    %subplot(1,2,1);
   % gscatter(X_train(:,1),X_train(:,2),Y); hold on;
    % Vectores de soporte
 %   plot(X_train(ModeloSVM{k}.IsSupportVector,1),X_train(ModeloSVM{k}.IsSupportVector,2),'ko','MarkerSize',10);
    % Frontera de decisi�n
   % contour(x1Grid,x2Grid,reshape(valores{k}(:,2),size(x1Grid)),[0 0],'k');
   % grid on;
    %title('Muestras de Entrenamiento y Frontera de Decision')
    %legend({'1','2','Support Vectors'},'Location','Best');
    
    %subplot(1,2,2);
   % gscatter(X_test(:,1),X_test(:,2),asignado{k});
    %legend({'1','2'},'Location','Best');
    %grid on;
    %title('Muestras de Prueba');
    %sgtitle(sprintf('%s.    Error en la Validaci�n Cruzada: %.2f%%',titulos{k},100*errorVC(k)));
    
end
NYsol = full(ind2vec(Ysol',2));
NAsig1 = full(ind2vec(asignado{1,1}',2))
NAsig2 = full(ind2vec(asignado{1,2}',2))
NAsig3 = full(ind2vec(asignado{1,3}',2))
NAsig4 = full(ind2vec(asignado{1,4}',2))
%confusionmat
%crosstab
%confusionmat(Ysol,asignado{1,1});
figure(9); clf;

plotconfusion(NYsol,NAsig1);
plotconfusion(NYsol,NAsig2);
plotconfusion(NYsol,NAsig3);
plotconfusion(NYsol,NAsig4);
