

b = Bitalino;

n=0;
i = 0;
data_n =0;
Epocas = 5000
L = Epocas;
t=linspace(0, Epocas/1000, L);
Hola = 0 ;
 h1 = plot( t, data_n)

h1.YData = data_n


 ga = 0.15;  
 b_act = 0;
  
b.startBackground
while 1
  %  tic
     data = b.readCurrentValues
   %Hola =   toc
     EMG_raw = data(:,6);
   dranow limtrate
  h1.YData = EMG_raw
  
   
end
b.stopBackground

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