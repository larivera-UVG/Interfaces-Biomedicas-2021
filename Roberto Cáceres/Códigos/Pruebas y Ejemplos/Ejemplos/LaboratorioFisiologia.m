%% Roberto Caceres 17163
%codigo para recolectar Datos y visualizar en tiempo real.

%% Configuración Bitalino.
Bit = Bitalino('BITalino-00-97'); %Creamos la conexion con el dispositivo bitalino y esa conexion la volvemos un objeto.

%% Definicion de variables para el ciclo.


TiempoVentana = 5;      %Tiempo que se quiere visualizar en el ploteo de datos (segundos)/Tambien se les llaman Epocas
fs=1000; %La frecuencia de muestreo es la cantidad de muestras que obtenemos por segundo por parte del bitalino
DataEMG = zeros(5000,1);
EMG=zeros(5000,1);
EMG_raw=0;
data=0;
data_n=zeros(4800,1)
Index=1;
i=1;
Offset = zeros(1,1);
ctrl =1;
DataEnBruto = cell(0,0);
time=0;

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

startBackground(Bit)

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
    while (time < TiempoVentana)      %la variable m determina el tiempoque nosotros asignaramos para llenar el buffer
        pause(1)   % se le da una pausa de 1 segundo por cada vez que pase, para que se logre llenar el buffer en el tiempo que se requiere
        time = time + 1 %variable que aumenta cada 1 segundo.
    end
     %data = read(Bit);% tomamos los ultimos valores en el buffer.
   
      time = 0; %se reinicia el contador para la siguiente vez que se llene el buffer
  
    %n=n+1%contador para ingresar los datos a la tabla.
    
    EMG_raw = data(:,6); %se toma solo la columna de la senal EMG
    EMG = EMG_raw*(3.3/1024);
    
    
    
    

    % Fixed_Vector = (EMG - (Offset)); %arreglamos la señal de acuerdo al offset
    
    data_f = filter(F_pb,EMG); % a este vector tenemos que filtrarlo con el filtro pasa banda
    data_n = filter(F_notch, data_f);     %Aplicar filtro notch para corrientes de 60 Hz, que es la banda de frecuencia a la que trabaja la energía electrica en Guatemala
   
    Epocas = size(data_n,1) ; %se toma el tamano del buffer obtenido
    L = Epocas; %longitud del vector epocas
    t=linspace(0, Epocas/1000, L);
    h1 = plot( t, data_n) %se plotea esa muestra

    drawnow limitrate % esta funcion es para poder plotear dentro del while
    
    if ctrl2 >1
    DataEnBruto(:,ctrl2)= num2cell(data_n(1:4800)); %En esta celda guardamos cada corrida o cada iteracion
    
    fprintf('Done - %d \n',ctrl2);
    end 
    ctrl2 =ctrl2+1;
    %En matlab es muy importante el orden de la linea de codigo porque
    %segun el orden este ejecuta el comando.
    
    
end






%% Parar la adquisición de data
stopBackground(Bit)%para el  modo streaming

%%
delete(Bit)%elimina el objeto creado












