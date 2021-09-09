% Create the object
m = 5;      %No. muestras totales
% Start background acquisition

b = Bitalino;


time = 0;
b.startBackground;

% Pause to acquire data for 20 seconds
%pause(10);
% Read the data from the device

'HELLOO'

%data = readCurrentValues(b, 5000)*5/255;

                while (time < m)
                    pause(1)
                    time = time + 1
                end

% Read the data from the device
data = b.read*5/1024;       
%hola =          data(:,2)
% Stop background acquisition of data
b.stopBackground;

% Clean up the bitalino object
delete(b)
F_pb = filtro_pasa_banda(1000,20,450);    %Diseñar filtro pasa banda       
F_notch = filtro_rechaza_banda(1000);     %Diseñar filtro rechaza banda 
data_f = filter(F_pb, data(:,6)');                          %Aplicar filtro pasa bandas
data_n = filter(F_notch, data_f);                       %Aplicar filtro notch

 Epocas = 10100
 L = Epocas;
 t=linspace(0, Epocas/1000, L);
 h1 = plot( t, data_n)
 ylim([min(data_n) max(data_n)]);
h1.YData = data_n

Data.WaveC5EMG(2) = jEnhancedWaveLength(data_n);
Data.WaveFormC5EMG(2)= jWaveformLength(data_n);
Data.MaximumFC5EMG(2) = jMaximumFractalLength(data_n);
Data.SkewnessFC5EMG(2) = jSkewness(data_n);
%[year month day hour minute seconds

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



        

