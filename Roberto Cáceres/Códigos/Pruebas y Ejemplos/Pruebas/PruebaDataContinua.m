

b = Bitalino;

n=0;
i = 0;
data_n =0;
Epocas = 5000
L = Epocas;
t=linspace(0, Epocas/1000, L);
Hola = 0 ;
th = identificacion2(pserial,t_inicio);    %Identificar el valor del threshold
 ga = 0.15;  
 b_act = 0;
  
  b.SampleRate = 1000
while 1
    tic
     data = readCurrentValues(b, 5000); 
   Hola =   toc
     
    Voltaje = max(data_n);
    v1 = max(abs());
    if volt > (th + ga) && b_act == 0 && volt < 5 && cont_r > 25
            %Activar bandera de inicio de actividad
            b_act = 1;
    end
    
    if b_act == 0
            data_r = ;        %Almaceno una ventana de muestras anteriores al mov.
    
         
    else   
         
                data(n_n,cont) = v2(:,n_n);      

     F_pb = filtro_pasa_banda(1000,20,450);    %Diseñar filtro pasa banda       
    F_notch = filtro_rechaza_banda(1000);     %Diseñar filtro rechaza banda 
    data_f = filter(F_pb, data(:,6)');                          %Aplicar filtro pasa bandas
    data_n = filter(F_notch, data_f)*(5/1024)                      %Aplicar filtro notch   
    n=n+1;
    Data.WaveC5EMG(n) = jEnhancedWaveLength(data_n);
    Data.WaveFormC5EMG(n)= jWaveformLength(data_n);
    Data.MaximumFC5EMG(n) = jMaximumFractalLength(data_n);
    Data.SkewnessFC5EMG(n) = jSkewness(data_n);
    end
   
end


h1 = plot( t, data_n)
clear b
tic
currentValue = readCurrentValues(b,5000)
toc
% 
%  Epocas = 10100
%  L = Epocas;
%  t=linspace(0, Epocas/1000, L);
%  h1 = plot( t, data_n)
%  ylim([min(data_n) max(data_n)]);
% h1.YData = data_n
% 
% Data.WaveC5EMG(2) = jEnhancedWaveLength(data_n);
% Data.WaveFormC5EMG(2)= jWaveformLength(data_n);
% Data.MaximumFC5EMG(2) = jMaximumFractalLength(data_n);
% Data.SkewnessFC5EMG(2) = jSkewness(data_n);
% %[year month day hour minute seconds
% 
% yfit = TREE_Canal5EMG.predictFcn(Data)
% switch yfit
%     case 'Left'
%         %q2 = [0; deg2rad(60);0; 0;deg2rad(90); 0];
%         
%         %R17fKine(R17, q2);
%         'hola'
%     case 'Forward'
%         %q2 = [0; deg2rad(60);0; deg2rad(45);deg2rad(90); 0];
%         %R17fKine(R17, q2);
%         'hola2'
%     end
% 
% nombres = []
% tel = []
% h = []
% t = table()