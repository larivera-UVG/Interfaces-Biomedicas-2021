clear all;

%%  Establecer la longitud de las epocas que se desea e inicializacion de variables
Epocas_Length = 10; % Duracion en segundos de cada epoca
Canales = 8;        % Numero de canales que se desea usar (1 a 8)
itr = 1;
t=1:1000;
vproyecto = zeros(1000,8);
i = 1;
ctrl = 0;
ctrl2 = 1;
M = 2;
%% Se definen los parametros para los filtros
fs_Hz = 250;
little_buff = zeros(1,10);
display_buff = zeros(1,5000);
cont = 1;

bpf = [7, 13];
[b,a] = butter(2,bpf/(fs_Hz / 2), 'bandpass');

notch = [59, 61];
[b2, a2] = butter(2,notch/(fs_Hz / 2), 'stop');

%%  Reservar memoria para vector de datos raw y para filtrar los datos
Col = 8;
Row = 50000000;
Offset = zeros(1,8);
Live_Data1 = zeros(Row,Col);
Live_Data_test = [];
Feature1_Vec = zeros(M,8);
Feature2_Vec = zeros(M,8);
Feature3_Vec = zeros(M,8);
Feature4_Vec = zeros(M,8);
Feature5_Vec = zeros(M,8);
Live_Data_test2 = zeros(Epocas_Length*250,8);
Fixed_Vector = zeros(Epocas_Length*250,8);
Full_Fill_Vec = zeros(2*Epocas_Length*250,8);
Temp_Raw_Vector = zeros(2*Epocas_Length*100,8);
index1 = 1;
cont = 1;
cont2 = Epocas_Length*250;
cont3 = Epocas_Length*250;
tiempos = zeros(Epocas_Length*250,1);
%% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();
% resolve a stream...
disp('Resolving an EEG stream...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','EEG');
end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});
disp('Now receiving data...');


mitimer  = tic;
n = 1;
Epocas = Epocas_Length*250  ; %se toma el tamano del buffer obtenido
L = Epocas; %longitud del vector epocas
t=linspace(0, Epocas/250, L);

%Preparando Graficas
subplot(2,4,1)
h1= plot( t, tiempos)
title('Ch1')
ylabel('uV')
xlabel('tiempo (s)')

subplot(2,4,2)
h2 = plot( t, tiempos)
title('Ch2')
ylabel('uV')
xlabel('tiempo (s)')
subplot(2,4,3)
h3 =plot( t, tiempos)
title('Ch3')
ylabel('uV')
xlabel('tiempo (s)')
subplot(2,4,4)
h4=plot( t, tiempos)
title('Ch4')
ylabel('uV')
xlabel('tiempo (s)')
subplot(2,4,5)
h5= plot( t, tiempos)
title('Ch5')
ylabel('uV')
xlabel('tiempo (s)')
subplot(2,4,6)
h6= plot( t, tiempos)
title('Ch6')
ylabel('uV')
xlabel('tiempo (s)')
subplot(2,4,7)
h7 = plot( t, tiempos)
title('Ch7')
ylabel('uV')
xlabel('tiempo (s)')
subplot(2,4,8)
h8=plot( t, tiempos)
title('Ch8')
ylabel('uV')
xlabel('tiempo (s)')



FactorEscalador = (4500000)/24/(2^23-1);



while true
    
    [vec,ts] = inlet.pull_sample();                         % Se realiza la lectura de los 8 canales 
    tiempos(n) = toc(mitimer);
    mitimer  = tic;
 
    Live_Data_test2(index1,:) =  (vec)*FactorEscalador;                       % Se ingresa los datos leidos a un vector temporal
    
%     h1.YData(i) = (vec(1, 1))/1000;                       %Actualizar gráfica 
%     
%     drawnow limitrate
   
    n = n +1;
     
    
    i=i+1;
   
     

    
    
    
    if(mod(i,Epocas_Length*250)==0)                       % Cada vez que pase cierta cantidad de tiempo se hace la separacion de epocas
        i=1;
        if (min(Live_Data_test2)==0)
             [M,I] = find(Live_Data_test2 == 0);
             Live_Data_test2(M,I) = Offset;
             fprintf('/');
        end
        Fixed_Vector = (Live_Data_test2 - (Offset));
%         Fixed_Vector = Live_Data_test2 - Live_Data_test2(1,:);
        display_buff_filt = filter(b2,a2,Fixed_Vector);  % Se realiza el friltrado del los datos
        display_buff_filt = filter(b,a,display_buff_filt);
        Offset = [mean(Live_Data_test2(:,1)),mean(Live_Data_test2(:,2)),mean(Live_Data_test2(:,3)),mean(Live_Data_test2(:,4)),mean(Live_Data_test2(:,5)),mean(Live_Data_test2(:,6)),mean(Live_Data_test2(:,7)),mean(Live_Data_test2(:,8))];
%         Offseet = mean(Live_Data_test2,1);
        Full_Fill_Vec(cont:cont3 ,:) = Live_Data_test2;     % Se almacenan los datos de cada epoca de los valores en bruto
        Temp_Raw_Vector(cont:cont3,:) = display_buff_filt;  % Se almacenan los datos de cada epoca de los valores filtrados
        cont = cont + cont2;                                % Contador para la primera posicion de la proxima epoca a guardar
        cont3 = cont3 + cont2;                              % Contador de la ultima posicion de la proxima epoca a guardar
        index1 = 1;
        flag = true;                                        % cuando se cumpla esta condicion se levanta una bandera para poder sacarle las caracterisiticas a dicha epoca
    else
        flag = false;
        index1 = index1 + 1;
    end
   
    
    
    if flag == true
        %Extraer caracteristicas
        Chn1 = display_buff_filt(: , 1);
        Chn2 = display_buff_filt(: , 2);
        Chn3 = display_buff_filt(: , 3);
        Chn4 = display_buff_filt(: , 4);
        Chn5 = display_buff_filt(: , 5);
        Chn6 = display_buff_filt(: , 6);
        Chn7 = display_buff_filt(: , 7);
        Chn8 = display_buff_filt(: , 8);
        
        subplot(2,4,1)
        h1 = plot( t, Chn1)
        ylim( [min(Chn1) max(Chn1)]);
        subplot(2,4,2)
        h2 = plot( t, Chn2)
        ylim( [min(Chn2) max(Chn2)]);
        subplot(2,4,3)
        h3 = plot( t, Chn3)
        ylim( [min(Chn3) max(Chn3)]);
        subplot(2,4,4)
        h4 = plot( t, Chn4)
        ylim( [min(Chn4) max(Chn4)]);
        subplot(2,4,5)
        h5 = plot( t, Chn5)
        ylim( [min(Chn5) max(Chn5)]);
        subplot(2,4,6)
        h6 = plot( t, Chn6)
        ylim( [min(Chn6) max(Chn6)]);
        subplot(2,4,7)
        h7 = plot( t, Chn7)
        ylim( [min(Chn7) max(Chn7)]);
        subplot(2,4,8)
        h8 = plot( t, Chn8)
        ylim( [min(Chn8) max(Chn8)]);
        drawnow limitrate
%h1 = ylim([min(Chn1) max(Chn1)]);
        
        Feature1_Vec(ctrl2,:) = [jKurtosis((Chn1)),jKurtosis((Chn2)),jKurtosis((Chn3)),jKurtosis((Chn4)),jKurtosis((Chn5)),jKurtosis((Chn6)),jKurtosis((Chn7)),jKurtosis((Chn8))];
        Feature2_Vec(ctrl2,:) = [jZeroCrossing(Chn1,0.01),jZeroCrossing(Chn2,0.01),jZeroCrossing(Chn3,0.01),jZeroCrossing(Chn4,0.01),jZeroCrossing(Chn5,0.01),jZeroCrossing(Chn6,0.01),jZeroCrossing(Chn7,0.01),jZeroCrossing(Chn8,0.01)];
        Feature3_Vec(ctrl2,:) = [jSkewness(Chn1),jSkewness(Chn2),jSkewness(Chn3),jSkewness(Chn4),jSkewness(Chn5),jSkewness(Chn6),jSkewness(Chn7),jSkewness(Chn8)];
        Feature4_Vec(ctrl2,:) = [jMeanEnergy(Chn1),jMeanEnergy(Chn2),jMeanEnergy(Chn3),jMeanEnergy(Chn4),jMeanEnergy(Chn5),jMeanEnergy(Chn6),jMeanEnergy(Chn7),jMeanEnergy(Chn8)];
        Feature5_Vec(ctrl2,:) = [jStandardDeviation(Chn1),jStandardDeviation(Chn2),jStandardDeviation(Chn3),jStandardDeviation(Chn4),jStandardDeviation(Chn5),jStandardDeviation(Chn6),jStandardDeviation(Chn7),jStandardDeviation(Chn8)];
        
        itr = 0;
        fprintf('Done - %d \n',ctrl);
        ctrl = ctrl + 1; % variable de control de duracion de la simulacion 
        ctrl2 = ctrl2 + 1;
    end
end