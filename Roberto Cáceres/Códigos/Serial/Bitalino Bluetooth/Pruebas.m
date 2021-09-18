% Create the object
m = 000;      %No. muestras totales
% Start background acquisition

b = Bitalino;



b.startBackground;
% Pause to acquire data for 20 seconds
%pause(10);
% Read the data from the device
'HELLOO'
%data = readCurrentValues(b, 5000)*5/255;
pause(10);
% Read the data from the device
data = b.read*5/255;       
%hola =          data(:,2)
% Stop background acquisition of data
b.stopBackground;
% Clean up the bitalino object
delete(b)


 Epocas = 10100
 L = Epocas;
 t=linspace(0, Epocas, L);
 h1 = plot( t, data(:,6))
 ylim([min(data(:,6)) max(data(:,6))]);
h1.YData = data(:,6)

Data.WaveC5EMG(1) = jEnhancedWaveLength(data(:,6));
Data.WaveFormC5EMG(1) = jWaveformLength(data(:,6));
Data.MaximumFC5EMG(1) = jMaximumFractalLength(data(:,6));
Data.SkewnessFC5EMG(1) = jSkewness(data(:,6));


yfit = TREE_Canal5EMG.predictFcn(Data)
switch yfit
    case 'Left'
        'hola'
    case 'Forward'    
        'hola2'
    end



        

