%% Roberto Caceres 17163
%codigo para recolectar Datos y visualizar en tiempo real.

%% Configuración Bitalino.
Bit = Bitalino; %Creamos la conexion con el dispositivo bitalino y esa conexion la volvemos un objeto.

%% Definicion de variables para el ciclo.


TiempoVentana = 5;      %Tiempo que se quiere visualizar en el ploteo de datos (segundos)/Tambien se les llaman Epocas
fs=1000; %La frecuencia de muestreo es la cantidad de muestras que obtenemos por segundo por parte del bitalino
DataEMG = zeros(5000,1);
EMG=zeros(5000,1);
EMG_raw=0;
data=0;
Index=1;
i=1;
Offset = zeros(1,1);
ctrl =1;
DataEnBruto = cell(0,0);

BanderaBuffer =false; %Bandera para indicar que el buffer esta lleno.
ctrl2=1;
DataAnterior=0;


%% Gráfica

Epocas = TiempoVentana *1000;
L = Epocas; %longitud del vector epocas
t=linspace(0, Epocas/1000, L);
tiempos = zeros(Epocas,1);

h1= plot( t, tiempos);
ylim([-0.5 0.5]);
title('ChEMG')
ylabel('V')
xlabel('tiempo (s)')


%% Se preparan los filtros
F_pb = filtro_pasa_banda(1000,20,450);    %Diseñar filtro pasa banda
F_notch = filtro_rechaza_banda(1000);     %Diseñar filtro rechaza banda

%% Empezar a recolectar data en  streaming
Bit.SampleRate = 1000;
Bit.startBackground

%% Comienzo del loop
%esta funcion prepara al bitalino para empezar funcionar en modo streaming
%y no dejara de enviar hasta que se haga un b.stopBackground mientras
%tanto se empieza a recibir lo datos de acuerdo a como se lleno el bufer.
while true
    %     if i==0
    %     pause; %este comando pausara la iteracion por si se necesita hacer un ajuste en el hardware.  hasta que se presione cualquier tecla seguira
    %     end
    %si se quiere tener una recoleccion continua solo se comenta esta parte
    %del codigo
    
    
    data = readCurrentValues(Bit,5000)*(3.3/1024); %ReadCurrenteValue  recibe el dato en tiempo real de todos los canales del bitalino.
    
    if DataAnterior~= data(1,6)
        i = i+1;
        
        
    end
    EMG(Index,:) =data(1,6)*(3.3/1024); %La senal que recibimos esta dada en bits por lo que recibimos valores entre 0 a 1024, tenemos que hacer una conversion a voltaje, el dispositivo bitalino trabaja a 3.3V
       
    
    DataAnterior=data(1,6);
    
    
    if (mod(i,TiempoVentana*1000)==0 )%Revisamos que se haya llenado el buffer(Esto es un array circular, una ventana que siempre esta llenandose de diferentes datos)
        i=1;%reiniciamos el contador
        %         if (min(EMG)==0) %revisamos si el minimo valor de la señal es 0
        %             [M,I] = find(EMG == 0); %buscamos donde ese valor era 0
        %             EMG(M,I) = Offset;%este es nuestro offset
        %             fprintf('/');
        %         end
        % Fixed_Vector = (EMG - (Offset)); %arreglamos la señal de acuerdo al offset
        Fixed_Vector = EMG
        data_f = filter(F_pb,Fixed_Vector); % a este vector tenemos que filtrarlo con el filtro pasa banda
        data_n = filter(F_notch, data_f);     %Aplicar filtro notch para corrientes de 60 Hz, que es la banda de frecuencia a la que trabaja la energía electrica en Guatemala
        Offset = mean(EMG); %el Offset de la siguiente iteracion es la media de la señal EMG
        Index=1; %reiniciamos el contador para llenar el buffer EMG
        BanderaBuffer =true; %Bandera para indicar que el buffer esta lleno.
    else
        
        BanderaBuffer =false; %Bandera para indicar que el buffer esta lleno.
         Index=Index+1;
    end
    
    if BanderaBuffer ==true
        BanderaBuffer =false;
        h1= plot( t, data_n); %ploteamos la data del vector filtrado y arreglado
        drawnow limitrate % esta funcion es para poder plotear dentro del while
        
        fprintf('Done - %d \n',ctrl);
        ctrl = ctrl + 1 % variable de control de duracion de la simulacion
        DataEnBruto(:,ctrl2)= num2cell(data_n); %En esta celda guardamos cada corrida o cada iteracion
        ctrl2 =ctrl2+1;
        
        %En matlab es muy importante el orden de la linea de codigo porque
        %segun el orden este ejecuta el comando.
        
        
    end
    
    
    
    
    
end
%% Parar la adquisición de data
Bit.stopBackground %para el  modo streaming
%%
delete(Bit)%elimina el objeto creado












