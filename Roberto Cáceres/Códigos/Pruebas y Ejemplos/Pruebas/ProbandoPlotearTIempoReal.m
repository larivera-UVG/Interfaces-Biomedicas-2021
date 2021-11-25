

%Bit = Bitalino;
TiempoBuffer = 5;
n=0;
i = 0;
data_n =0;
Epocas = TiempoBuffer*1000;
L = Epocas;
t=linspace(0, Epocas/1000, L);
Hola = 0 ;
 h1 = plot( t, data_n)

Live_Data_test1 = zeros(TiempoBuffer*1000,1);
data_n=0;


%se preparan los filtros 
F_pb = filtro_pasa_banda(1000,20,450);    %Diseñar filtro pasa banda       
F_notch = filtro_rechaza_banda(1000);     %Diseñar filtro rechaza banda 

 ga = 0.15;  
 b_act = 0;
  j =0;
  index2 = 1;
%Bit.startBackground
while 1
  %  tic
    currentValue = readCurrentValues(Bit,1)
       Live_Data_test1(index2,1) = (currentValue(1,6))*(3.3/1024);
%     h1.YData(i) = (vec(1, 1))/1000;                       %Actualizar gráfica 
%     
%     drawnow limitrate
   
    
    
   
    j=j+1;
   
     

    if (mod(j,TiempoBuffer*1000)==0)
        j=0;
        data_f = filter(F_pb,  Live_Data_test1);                          %Aplicar filtro pasa bandas
    data_n = filter(F_notch, data_f);                       %Aplicar filtro notch
         subplot(1,2,2)
        h2 = plot( t,  data_n)
        ylim( [min( data_n) max( data_n)]);
        drawnow limitrate
         index2 = 1;
        
    else 
         index2 = index2 + 1;
    end 
   %Hola =   toc
     %EMG_raw = data(:,6)
  
   
end
%Bit.stopBackground

% h1 = plot( t, data_n)
% clear Bit
% tic
% currentValue = readCurrentValues(b,5000)
% toc
% % 
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