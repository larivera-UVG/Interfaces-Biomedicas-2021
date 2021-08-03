% -------------------------------------------------------------------------
%Roberto Caceres - 17163
%2021
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

DatosEMGCanal1 = cell(2,10);
DatosEMGCanal2 = cell(2,10);

DatosEMGCanal1{1,1}='ZC1';
DatosEMGCanal1{1,2}='ZC2';
DatosEMGCanal1{1,3}='MAV1';
DatosEMGCanal1{1,4}='MAV2';
DatosEMGCanal1{1,5}='RMS1';
DatosEMGCanal1{1,6}='RMS2';
DatosEMGCanal1{1,7}='Varianza1';
DatosEMGCanal1{1,8}='Varianza2';
DatosEMGCanal1{1,9}='WaveForm1';
DatosEMGCanal1{1,10}='WaveForm2';
DatosEMGCanal1{1,11}='WilsonA1';
DatosEMGCanal1{1,12}='WilsonA2';
DatosEMGCanal1{1,13}='AverageEnergy1';
DatosEMGCanal1{1,14}='AverageEnergy2';
DatosEMGCanal1{1,15}=' skewness1';
DatosEMGCanal1{1,16}=' skewness2';
DatosEMGCanal1{1,17}='IntegratedEMG1 ';
DatosEMGCanal1{1,18}='IntegratedEMG2';
DatosEMGCanal1{1,19}='MeanAbsolute1 ';
DatosEMGCanal1{1,20}='MeanAbsolute2';

DatosEMGCanal2{1,1}='ZC3';
DatosEMGCanal2{1,2}='ZC4';
DatosEMGCanal2{1,3}='MAV3';
DatosEMGCanal2{1,4}='MAV4';
DatosEMGCanal2{1,5}='RMS3';
DatosEMGCanal2{1,6}='RMS4';
DatosEMGCanal2{1,7}='Varianza3';
DatosEMGCanal2{1,8}='Varianza4';
DatosEMGCanal2{1,9}='WaveForm3';
DatosEMGCanal2{1,10}='WaveForm4';
DatosEMGCanal2{1,11}='WilsonA3';
DatosEMGCanal2{1,12}='WilsonA4';
DatosEMGCanal2{1,13}='AverageEnergy3';
DatosEMGCanal2{1,14}='AverageEnergy4';
DatosEMGCanal2{1,15}=' skewness3';
DatosEMGCanal2{1,16}=' skewness4';
DatosEMGCanal2{1,17}='IntegratedEMG3 ';
DatosEMGCanal2{1,18}='IntegratedEMG4';
DatosEMGCanal2{1,19}='MeanAbsolute3 ';
DatosEMGCanal2{1,20}='MeanAbsolute4';



    
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

     eti3 = [];
     XtestZC3 = [];
     XtestMAV3 = [];   
     XtestVAR3 = [];
     XtestRMS3 = [];
     XtestWaveF3=[];
     XtestWilsonA3=[];
     XtestAverageEnergy3=[];
      Xtestskewness3=[];
      XtestIntegratedEMG3=[];
      XtestMeanAbsoluteValue3=[];
             
     eti4 = [];
     XtestZC4 = [];
     XtestMAV4 = []; 
     XtestVAR4 = [];
     XtestRMS4 = [];
     XtestWaveF4=[];
     XtestWilsonA4=[];
     XtestAverageEnergy4=[];
     Xtestskewness4=[];
     XtestIntegratedEMG4=[];
      XtestMeanAbsoluteValue4=[];

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
        epo = proc_selectChannels(epo, {'EMG_1','EMG_2'}); %seleccionamos que canales utilizaremos para poder extraerlos. 
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
        
if concatEpo.x(:,1,:)
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
           %if concatEpo.x(:,p,:) ==3
               if (concatEpo.y(1,j) == 1) 
           
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
                  if (concatEpo.y(2,j) == 1) 
      
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
          % end
    %         
    % 
    end
end
    etiqueta2 = concatEpo.y

DatosEMGCanal1{2,1}=  XtestZC1;
DatosEMGCanal1{2,2}=  XtestZC2;
DatosEMGCanal1{2,3}=  XtestMAV1;
DatosEMGCanal1{2,4}=  XtestMAV2;
DatosEMGCanal1{2,5}=  XtestRMS1;
DatosEMGCanal1{2,6}=  XtestRMS2;
DatosEMGCanal1{2,7}=  XtestVAR1;
DatosEMGCanal1{2,8}=  XtestVAR2;
DatosEMGCanal1{2,9}=  XtestWaveF1;
DatosEMGCanal1{2,10}=XtestWaveF2;
DatosEMGCanal1{2,11}=  XtestWilsonA1;
DatosEMGCanal1{2,12}=XtestWilsonA2;
DatosEMGCanal1{2,13}=  XtestAverageEnergy1;
DatosEMGCanal1{2,14}=XtestAverageEnergy2;
DatosEMGCanal1{2,15}=    Xtestskewness1;
DatosEMGCanal1{2,16}=   Xtestskewness2;
DatosEMGCanal1{2,17}=   XtestIntegratedEMG1;
DatosEMGCanal1{2,18}=  XtestIntegratedEMG2;
DatosEMGCanal1{2,19}=      XtestMeanAbsoluteValue1; 
DatosEMGCanal1{2,20}=     XtestMeanAbsoluteValue2;
    
  


if concatEpo.x(:,2,:)
          for j = 1:nTrials
            
    
             varian2(j)              =     var(concatEpo.x(:,2,j));
             [zc2(j), mav2(j)]   =     metricas(concatEpo.x(:,2,j),0,0);  
             rmslevel2(j)        =     rms(concatEpo.x(:,2,j));
             WF2(j)                 =     jWaveformLength(concatEpo.x(:,2,j));
             Wilson2(j)          =     jWillisonAmplitude(concatEpo.x(:,2,j),0.1);
             LCOV2(j)            =     jAverageEnergy(concatEpo.x(:,2,j));
             SKEW2(j)           =      jSkewness(concatEpo.x(:,2,j));
             IntEMG2(j)            =    jIntegratedEMG(concatEpo.x(:,2,j));
             MeanAbs2(j)    = jMeanAbsoluteValue(concatEpo.x(:,2,j));
             
           %Izquierda
           %if concatEpo.x(:,p,:) ==3
               if (concatEpo.y(1,j) == 1) 
           
                   XtestZC3 = [XtestZC3;zc2(j)];
                   XtestVAR3 = [XtestVAR3;varian2(j)];
                   XtestMAV3 = [XtestMAV3;mav2(j)];
                   XtestRMS3 = [XtestRMS3;rmslevel2(j)];
                   XtestWaveF3 = [XtestWaveF3;WF2(j)];
                    XtestWilsonA3 = [XtestWilsonA3;Wilson2(j)];
                    XtestAverageEnergy3 = [ XtestAverageEnergy3;LCOV2(j)];
                    Xtestskewness3=[ Xtestskewness3; SKEW2(j)];
                     XtestIntegratedEMG3 = [XtestIntegratedEMG3;  IntEMG2(j)];
                     XtestMeanAbsoluteValue3 =  [XtestMeanAbsoluteValue3;     MeanAbs2(j)];
          
               end 
               %Derecha
                  if (concatEpo.y(2,j) == 1) 
      
                   XtestZC4 = [XtestZC4;zc2(j)];
                   XtestMAV4 = [XtestMAV4;mav2(j)]; 
                   XtestVAR4 = [XtestVAR4;varian2(j)];
                   XtestRMS4 = [XtestRMS4;rmslevel2(j)];
                   XtestWaveF4 = [XtestWaveF4;WF2(j)];
                   XtestWilsonA4 = [XtestWilsonA4 ; Wilson2(j)];
                   XtestAverageEnergy4 = [ XtestAverageEnergy4;LCOV2(j)];
                   Xtestskewness4= [ Xtestskewness4; SKEW2(j)];
                   XtestIntegratedEMG4 = [XtestIntegratedEMG4;  IntEMG2(j)];
                     XtestMeanAbsoluteValue4 =  [XtestMeanAbsoluteValue4;     MeanAbs2(j)];
                   
                  end 
          % end
    %         
    % 
    end
    
  
 


DatosEMGCanal2{2,1}=  XtestZC3;
DatosEMGCanal2{2,2}=  XtestZC4;
DatosEMGCanal2{2,3}=  XtestMAV3;
DatosEMGCanal2{2,4}=  XtestMAV4;
DatosEMGCanal2{2,5}=  XtestRMS3;
DatosEMGCanal2{2,6}=  XtestRMS4;
DatosEMGCanal2{2,7}=  XtestVAR3;
DatosEMGCanal2{2,8}=  XtestVAR4;
DatosEMGCanal2{2,9}=  XtestWaveF3;
DatosEMGCanal2{2,10}=XtestWaveF4;
DatosEMGCanal2{2,11}=  XtestWilsonA3;
DatosEMGCanal2{2,12}=XtestWilsonA4;
DatosEMGCanal2{2,13}=  XtestAverageEnergy3;
DatosEMGCanal2{2,14}=XtestAverageEnergy4;
DatosEMGCanal2{2,15}=    Xtestskewness3;
DatosEMGCanal2{2,16}=   Xtestskewness4;
DatosEMGCanal2{2,17}=   XtestIntegratedEMG3;
DatosEMGCanal2{2,18}=  XtestIntegratedEMG4;
DatosEMGCanal2{2,19}=      XtestMeanAbsoluteValue3; 
DatosEMGCanal2{2,20}=     XtestMeanAbsoluteValue4;

    


      end
   
end   

    
end





