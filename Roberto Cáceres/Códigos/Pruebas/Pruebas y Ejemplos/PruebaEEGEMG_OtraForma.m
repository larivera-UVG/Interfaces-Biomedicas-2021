%PruebaDataJunta ElectroCap - Bitalino
%clear all;

%% Bitalino 

Bit = Bitalino;
TiempoBuffer = 5;      %No. muestras totales
time = 0;
 n=0;
 b_act = 0 ;
 M = 0; 
 volt = 0 ;
 %esta funcion prepara al bitalino para empezar funcionar en modo streaming
 %y no dejara de enviar hasta que se haga un b.stopBackground mientras
 %tanto se empieza a recibir lo datos de acuerdo a como se lleno el bufer. 

data_n=0;


%se preparan los filtros 
F_pb = filtro_pasa_banda(1000,20,450);    %Diseñar filtro pasa banda       
F_notch = filtro_rechaza_banda(1000);     %Diseñar filtro rechaza banda 
% th  = 0.20
% ga = 0.15
% i=0;
% j=0;

% 'HELLOO'

%%  Establecer la longitud de las epocas que se desea e inicializacion de variables
Epocas_Length = 5; % Duracion en segundos de cada epoca
Canales = 8;        % Numero de canales que se desea usar (1 a 8)
itr = 1;
t=1:1000;
vproyecto = zeros(1000,8);
i = 1;
j = 0;
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
Live_Data_test1 = zeros(TiempoBuffer*1000,1);
Fixed_Vector = zeros(Epocas_Length*250,8);
Full_Fill_Vec = zeros(2*Epocas_Length*250,8);
Temp_Raw_Vector = zeros(2*Epocas_Length*100,8);
index1 = 1;
index2 = 1;
cont = 1;
cont2 = Epocas_Length*250;
cont3 = Epocas_Length*250;
tiempos = zeros(Epocas_Length*250,1);
tiempos2 = zeros(TiempoBuffer*1000,1);

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
Epocas2 = TiempoBuffer *1000;
L = Epocas; %longitud del vector epocas
L2 = Epocas2; %longitud del vector epocas
t=linspace(0, Epocas/250, L);
t2=linspace(0, Epocas2/1000, L2);



%Preparando Graficas
subplot(1,2,1)
h1= plot( t, tiempos)
title('Ch1')
ylabel('uV')
xlabel('tiempo (s)')

subplot(1,2,2)
h2 = plot( t2, tiempos2)
title('Ch2')
ylabel('uV')
xlabel('tiempo (s)')

Bit.SampleRate = 1000;

FactorEscalador = (4500000)/24/(2^23-1);

Bit.startBackground

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
data = read(Bit);% tomamos los ultimos valores en el buffer.              
    %n=n+1%contador para ingresar los datos a la tabla. 

    EMG_raw = data(:,6); %se toma solo la columna de la senal EMG
    EMG = EMG_raw*(3.3/1024);%se convierte la senal a la escala de 3.3 V
    data_f = filter(F_pb, EMG');                          %Aplicar filtro pasa bandas
    data_n = filter(F_notch, data_f);                       %Aplicar filtro notch
    

% 
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
        
        
        subplot(1,2,1)
        h1 = plot( t, Chn1)
        ylim( [min(Chn1) max(Chn1)]);
        
       drawnow limitrate
       
%h1 = ylim([min(Chn1) max(Chn1)]);
        
        
        itr = 0;
        fprintf('Done - %d \n',ctrl);
        ctrl = ctrl + 1; % variable de control de duracion de la simulacion 
        ctrl2 = ctrl2 + 1;
    end
end