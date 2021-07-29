% -------------------------------------------------------------------------
% ACC_WistTwisting.m
% This source code is about to measure the classification accuracy based on the basic machine learning method.
% This classification accuracy was computed by usign the fundamental EEG signal processing such band-pass filtering, time epoch, feature extraction, classification.
% Feature extraction: Common spatial pattern (CSP),
% Classifier: regularized linear discriminant analysis (RLDA)

% If you want to improve the classification accuracies, you could adopt more advanced methods. 
% For example: 
% 1. Independent component analysis(ICA) for artifact rejection
% 2. Common average reference (CAR) filter, Laplacian spatial filter, and band power for feature extraction
% 3. Support vector machine (SVM) or Random forest (RF) for classifier 

% Please add the bbci toolbox in the 'Reference_toolbox' folder
%--------------------------------------------------------------------------

%% Initalization
clc; close all; clear all;
%%
% Directory
% Write down where converted data file downloaded (file directory)

%Cada uno de los tipos de movimiento que tiene esta base de datos, tiene su propio  script para poder obtener los datos directamente de las estrucutras que 
% ellos hicieron, teniendo así acceso a cada uno de los datos importantes para poder realizar los entrenamientos


dd='C:\Users\barss\OneDrive\Desktop\SeñalesEMG\'; %% le damos una direccion para ir a buscar los datos 
cd 'C:\Users\barss\OneDrive\Desktop\SeñalesEMG'; 
% Example: dd='Downlad_folder\SampleData\plotScalp\';

datedir = dir('*.mat'); %% le dice que tipo de dato tiene que buscar en la dirección
filelist = {datedir.name}; %%vuelve los archivos de ese tipo en esa direccion una lista para poder recorrerla 

% Setting time duration: interval 0~3 s
ival=[0 3001]; %para poder filtrar luego

DatosEMG = cell(2,10);

DatosEMG{1,1}='ZC1';
DatosEMG{1,2}='ZC2';
DatosEMG{1,3}='MAV1';
DatosEMG{1,4}='MAV2';
DatosEMG{1,5}='RMS1';
DatosEMG{1,6}='RMS2';
DatosEMG{1,7}='Varianza1';
DatosEMG{1,8}='Varianza2';
DatosEMG{1,9}='WaveForm1';
DatosEMG{1,10}='WaveForm2';
DatosEMG{1,11}='WilsonA1';
DatosEMG{1,12}='WilsonA2';
DatosEMG{1,13}='AverageEnergy1';
DatosEMG{1,14}='AverageEnergy2';
DatosEMG{1,15}=' skewness1';
DatosEMG{1,16}=' skewness2';
DatosEMG{1,17}='IntegratedEMG1 ';
DatosEMG{1,18}='IntegratedEMG2';
DatosEMG{1,19}='MeanAbsolute1 ';
DatosEMG{1,20}='MeanAbsolute2';



    
    eti1 = [];
    XtestZC1 = [];
    XtestMAV1 = [];   
    XtestVAR1 = [];
    XtestRMS1 = [];
    XtestWaveF1=[];
    XtestWilsonA1=[];
    XtestAverageEnergy1=[];
     Xtestskewness1=[];
     XtestIntegratedEMG1=[];
     XtestMeanAbsoluteValue1=[];
            
    eti2 = [];
    XtestZC2 = [];
    XtestMAV2 = []; 
    XtestVAR2 = [];
    XtestRMS2 = [];
    XtestWaveF2=[];
    XtestWilsonA2=[];
    XtestAverageEnergy2=[];
    Xtestskewness2=[];
    XtestIntegratedEMG2=[];
     XtestMeanAbsoluteValue2=[];

%% Performance measurement
for i = 1:3
    filelist{i}
    [cnt,mrk,mnt]=eegfile_loadMatlab([dd filelist{1}]); %extraemos estos datos (Se puede encontrar que significa cada uno en los readme de la base de datos)
    
    % Band pass filtering, order of 4, range of [8-30] Hz (mu-, beta-bands)
    filterBank = {[8 30]};
    for filt = 1:length(filterBank)
        filelist{i}
        filterBank{filt}
        
        cnt = proc_filtButter(cnt, 4 ,filterBank{filt});
        epo=cntToEpo(cnt,mrk,ival);
        
        % Select channels
       %% epo = proc_selectChannels(epo, {'EMG_1','EMG_2','EMG_3','EMG_4','EMG_5','EMG_6','EMG_ref'});
        epo = proc_selectChannels(epo, {'EMG_1'}); %seleccionamos que canales utilizaremos para poder extraerlos. 
        classes=size(epo.className,2); % obtiene las clases que traen las señales
        
        trial=50;
        
        % Set the number of rest trial to the same as the number of other classes trial.
        for ii =1:classes
            if strcmp(epo.className{ii},'Rest')
                epoRest=proc_selectClasses(epo,{epo.className{ii}});
                epoRest.x=datasample(epoRest.x,trial,3,'Replace',false);
                epoRest.y=datasample(epoRest.y,trial,2,'Replace',false);
            else
                epo_check(ii)=proc_selectClasses(epo,{epo.className{ii}});
                
                % Randomization
                epo_check(ii).x=datasample(epo_check(ii).x,trial,3,'Replace',false);
                epo_check(ii).y=datasample(epo_check(ii).y,trial,2,'Replace',false);
            end
        end
        if classes<3
            epo_check(size(epo_check,2)+1)=epoRest;
        end
        
        % concatenate the classes
        for ii=1:size(epo_check,2)
            if ii==1
                concatEpo=epo_check(ii);
            else
                concatEpo=proc_appendEpochs(concatEpo,epo_check(ii));
            end
        end
        
        %% Extraccion de caracteristicas 

        % Este codigo sirve para poder obtener las caracteristicas de cada una de las señales de las 3 diferentes sesiones y poder organizarla 
         %para poder obtener los datos y así realizar los entrenamientos. 

        [nTimes,nChan,nTrials] = size(concatEpo.x)


for j = 1:nTrials
            
    
            varian(j)              =     var(concatEpo.x(:,1,j));
             [zc(j), mav(j)]   =     metricas(concatEpo.x(:,1,j),0,0);  
             rmslevel(j)        =     rms(concatEpo.x(:,1,j));
             WF(j)                 =     jWaveformLength(concatEpo.x(:,1,j));
             Wilson(j)          =     jWillisonAmplitude(concatEpo.x(:,1,j),0.1);
             LCOV(j)            =     jAverageEnergy(concatEpo.x(:,1,j));
             SKEW(j)           =      jSkewness(concatEpo.x(:,1,j));
             IntEMG(j)            =    jIntegratedEMG(concatEpo.x(:,1,j));
             MeanAbs(j)    = jMeanAbsoluteValue(concatEpo.x(:,1,j));
           %Izquierda
               if concatEpo.y(1,j) == 1
                   XtestZC1 = [XtestZC1;zc(j)];
                   XtestVAR1 = [XtestVAR1;varian(j)];
                   XtestMAV1 = [XtestMAV1;mav(j)];
                   XtestRMS1 = [XtestRMS1;rmslevel(j)];
                   XtestWaveF1 = [XtestWaveF1;WF(j)];
                    XtestWilsonA1 = [XtestWilsonA1;Wilson(j)];
                    XtestAverageEnergy1 = [ XtestAverageEnergy1;LCOV(j)];
                    Xtestskewness1=[ Xtestskewness1; SKEW(j)];
                     XtestIntegratedEMG1 = [XtestIntegratedEMG1;  IntEMG(j)];
                     XtestMeanAbsoluteValue1 =  [XtestMeanAbsoluteValue1;     MeanAbs(j)];
               end 
               %Derecha
                  if concatEpo.y(2,j) == 1
                   XtestZC2 = [XtestZC2;zc(j)];
                   XtestMAV2 = [XtestMAV2;mav(j)]; 
                   XtestVAR2 = [XtestVAR2;varian(j)];
                   XtestRMS2 = [XtestRMS2;rmslevel(j)];
                   XtestWaveF2 = [XtestWaveF2;WF(j)];
                   XtestWilsonA2 = [XtestWilsonA2 ; Wilson(j)];
                   XtestAverageEnergy2 = [ XtestAverageEnergy2;LCOV(j)];
                   Xtestskewness2= [ Xtestskewness2; SKEW(j)];
                   XtestIntegratedEMG2 = [XtestIntegratedEMG2;  IntEMG(j)];
                     XtestMeanAbsoluteValue2 =  [XtestMeanAbsoluteValue2;     MeanAbs(j)];
               end 
%         
% 
end
 
etiqueta2 = concatEpo.y

DatosEMG{2,1}=  XtestZC1;
DatosEMG{2,2}=  XtestZC2;
DatosEMG{2,3}=  XtestMAV1;
DatosEMG{2,4}=  XtestMAV2;
DatosEMG{2,5}=  XtestRMS1;
DatosEMG{2,6}=  XtestRMS2;
DatosEMG{2,7}=  XtestVAR1;
DatosEMG{2,8}=  XtestVAR2;
DatosEMG{2,9}=  XtestWaveF1;
DatosEMG{2,10}=XtestWaveF2;
DatosEMG{2,11}=  XtestWilsonA1;
DatosEMG{2,12}=XtestWilsonA2;
DatosEMG{2,13}=  XtestAverageEnergy1;
DatosEMG{2,14}=XtestAverageEnergy2;
DatosEMG{2,15}=    Xtestskewness1;
DatosEMG{2,16}=   Xtestskewness2;
DatosEMG{2,17}=   XtestIntegratedEMG1;
DatosEMG{2,18}=  XtestIntegratedEMG2;
DatosEMG{2,19}=      XtestMeanAbsoluteValue1;
DatosEMG{2,20}=     XtestMeanAbsoluteValue2;



   
    end   

    
end





