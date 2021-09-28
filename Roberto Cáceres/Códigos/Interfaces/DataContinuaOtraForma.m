%% Roberto Caceres 17163
%% codigo para adquirir data continua desde el bitalino. 

TiempoBuffer = 5;      %No. muestras totales
%b = Bitalino;
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
th  = 0.20
ga = 0.15
i=0;
j=0;
b.startBackground
'HELLOO'
while 1
    
   while (time < TiempoBuffer)      %la variable m determina el tiempoque nosotros asignaramos para llenar el buffer
                    pause(1)   % se le da una pausa de 1 segundo por cada vez que pase, para que se logre llenar el buffer en el tiempo que se requiere
                    time = time + 1 %variable que aumenta cada 1 segundo. 
   end
   
    data = read(b);% tomamos los ultimos valores en el buffer.              
    %n=n+1%contador para ingresar los datos a la tabla. 
    time = 0; %se reinicia el contador para la siguiente vez que se llene el buffer
    EMG_raw = data(:,6); %se toma solo la columna de la senal EMG
    EMG = EMG_raw*(3.3/1024);%se convierte la senal a la escala de 3.3 V
    data_f = filter(F_pb, EMG');                          %Aplicar filtro pasa bandas
    data_n = filter(F_notch, data_f);                       %Aplicar filtro notch
    wt = cwt(data_n);
   volt = max(data_n);
    
    M = max(max(wt));
    Th = abs(M)
    
    if  Th > 0.31  &&  b_act == 0  && volt < 5 %este th se determina con pruebas previas. 
            %Activar bandera de inicio de actividad
            b_act = 1;
    end
        
    n = n+1;
    
     
    
    if b_act ==1
        Epocas = size(data_n,2) ; %se toma el tamano del buffer obtenido
    L = Epocas; %longitud del vector epocas
    t=linspace(0, Epocas/1000, L);
    h1 = plot( t, data_n) %se plotea esa muestra
      b_act = 0 ;  
    Data.WaveC5EMG(1) = jEnhancedWaveLength(data_n);
    Data.WaveFormC5EMG(1)= jWaveformLength(data_n);
    Data.MaximumFC5EMG(1) = jMaximumFractalLength(data_n);
    Data.SkewnessFC5EMG(1) = jSkewness(data_n);
        
     
        yfit = TREE_Canal5EMG.predictFcn(Data)
     switch yfit
      case 'Left'
          %q2 = [0; deg2rad(60);0; 0;deg2rad(90); 0];
         
         %R17fKine(R17, q2);
         'hola'
          case 'Forward'
         %q2 = [0; deg2rad(60);0; deg2rad(45);deg2rad(90); 0];
         %R17fKine(R17, q2);
         'hola2'
     end
     end 
    
    
    
    
end 
b.stopBackground

delete(b)



  






        

