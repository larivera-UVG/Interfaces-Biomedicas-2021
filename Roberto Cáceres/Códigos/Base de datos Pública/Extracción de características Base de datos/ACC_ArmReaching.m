% -------------------------------------------------------------------------
% ACC_ArmReaching.m
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
dd='C:\Users\barss\OneDrive\Documents\GitHub\Interfaces-Biomedicas-2021\Roberto Cáceres\Códigos\Base de datos Pública\Extracción de características Base de datos\'; 
cd 'C:\Users\barss\OneDrive\Documents\GitHub\Interfaces-Biomedicas-2021\Roberto Cáceres\Códigos\Base de datos Pública\Extracción de características Base de datos';
% Example: dd='Downlad_folder\SampleData\plotScalp\';

datedir = dir('*.mat');
filelist = {datedir.name};

% Setting time duration: interval 0~3 s
ival=[0 3001];

DatosEMGCanal1 = cell(2,10);
DatosEMGCanal2 = cell(2,10);

DatosEMGCanal1{1,1}='ZC1';
DatosEMGCanal1{1,2}='ZC2';
DatosEMGCanal1{1,3}='ZC3';
DatosEMGCanal1{1,4}='ZC4';
DatosEMGCanal1{1,5}='ZC5';
DatosEMGCanal1{1,6}='ZC6';
DatosEMGCanal1{1,7}='MAV1';
DatosEMGCanal1{1,8}='MAV2';
DatosEMGCanal1{1,9}='MAV3';
DatosEMGCanal1{1,10}='MAV4';
DatosEMGCanal1{1,11}='MAV5';
DatosEMGCanal1{1,12}='MAV6';
DatosEMGCanal1{1,13}='WaveForm1';
DatosEMGCanal1{1,14}='WaveForm2';
DatosEMGCanal1{1,15}=' WaveForm3';
DatosEMGCanal1{1,16}=' WaveForm4';
DatosEMGCanal1{1,17}='WaveForm5';
DatosEMGCanal1{1,18}='WaveForm6';


DatosEMGCanal2{1,1}='ZC1c2';
DatosEMGCanal2{1,2}='ZC2c2';
DatosEMGCanal2{1,3}='ZC3c2';
DatosEMGCanal2{1,4}='ZC4c2';
DatosEMGCanal2{1,5}='ZC5c2';
DatosEMGCanal2{1,6}='ZC6c2';
DatosEMGCanal2{1,7}='MAV1c2';
DatosEMGCanal2{1,8}='MAV2c2';
DatosEMGCanal2{1,9}='MAV3c2';
DatosEMGCanal2{1,10}='MAV4c2';
DatosEMGCanal2{1,11}='MAV5c2';
DatosEMGCanal2{1,12}='MAV6c2';
DatosEMGCanal2{1,13}='WaveForm1c2';
DatosEMGCanal2{1,14}='WaveForm2c2';
DatosEMGCanal2{1,15}=' WaveForm3c2';
DatosEMGCanal2{1,16}=' WaveForm4c2';
DatosEMGCanal2{1,17}='WaveForm5c2 ';
DatosEMGCanal2{1,18}='WaveForm6c2';




    

    XtestZC1 = [];
    XtestZC2 = [];   
    XtestZC3 = [];
    XtestZC4 = [];
    XtestZC5=[];
    XtestZC6=[];
    XtestMAV1=[];
     XtestMAV2=[];
     XtestMAV3 =[];
     XtestMAV4=[];
     XtestMAV5=[];
     XtestMAV6=[];
      XtestWaveForm1=[];
      XtestWaveForm2=[];
      XtestWaveForm3=[];
      XtestWaveForm4=[];
      XtestWaveForm5=[];
      XtestWaveForm6=[];
      
    XtestZC1c2 = [];
    XtestZC2c2 = [];   
    XtestZC3c2 = [];
    XtestZC4c2 = [];
    XtestZC5c2=[];
    XtestZC6c2=[];
    XtestMAV1c2=[];
     XtestMAV2c2=[];
     XtestMAV3c2 =[];
     XtestMAV4c2=[];
     XtestMAV5c2=[];
     XtestMAV6c2=[];
      XtestWaveForm1c2=[];
      XtestWaveForm2c2=[];
      XtestWaveForm3c2=[];
      XtestWaveForm4c2=[];
      XtestWaveForm5c2=[];
      XtestWaveForm6c2=[];
            
    

%% Performance measurement
for i = 1:length(filelist)
    filelist{i}
    [cnt,mrk,mnt]=eegfile_loadMatlab([dd filelist{i}]);
    
    % Band pass filtering, order of 4, range of [8-30] Hz (mu-, beta-bands)
    filterRange = {[8 30]};
    for filt = 1:length(filterRange)
        filelist{i}
        filterRange{filt}
        
        cnt = proc_filtButter(cnt, 4 ,filterRange{filt});
        epo=cntToEpo(cnt,mrk,ival);
        
        % Select channels
      %  epo = proc_selectChannels(epo, {'EMG_1','EMG_2'});
      epo = proc_selectChannels(epo, {'AF3'});
        
        classes=size(epo.className,2);
        
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
        if classes<7
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
        
        %% CSP - FEATURE EXTRACTION
        
         [nTimes,nChan,nTrials] = size(concatEpo.x)
        
if concatEpo.x(:,1,:)
          for j = 1:nTrials
            
    
             
             zc(j)   =     jZeroCrossing(concatEpo.x(:,1,j),0.1);  
             WF(j)                 =     jWaveformLength(concatEpo.x(:,1,j));
             mav(j)   = jMeanAbsoluteValue(concatEpo.x(:,1,j))
           %Forward
           %if concatEpo.x(:,p,:) ==3
               if (concatEpo.y(1,j) == 1) 
           
                   XtestZC1 = [XtestZC1;zc(j)];
                   XtestMAV1 = [ XtestMAV1; mav(j)];
                   XtestWaveForm1=[ XtestWaveForm1; mav(j)];
               end 
              %Backward
                  if (concatEpo.y(2,j) == 1) 
      
                  XtestZC2 = [XtestZC2;zc(j)];
                  XtestMAV2 = [ XtestMAV2; mav(j)];
                   XtestWaveForm2=[ XtestWaveForm2; mav(j)];
                   
                  end 
                  %'Left'
                   if (concatEpo.y(3,j) == 1) 
      
                   XtestZC3 = [XtestZC3;zc(j)];
                  XtestMAV3 = [ XtestMAV3; mav(j)];
                   XtestWaveForm3=[ XtestWaveForm3; mav(j)];
                   
                   end 
                  %'Right'
                   if (concatEpo.y(4,j) == 1) 
      
                   XtestZC4 = [XtestZC4;zc(j)];
                   XtestMAV4 = [ XtestMAV4; mav(j)];
                   XtestWaveForm4=[ XtestWaveForm4; mav(j)];
                   
                   end 
                   
                     %'Up'
                   if (concatEpo.y(5,j) == 1) 
      
                   XtestZC5 = [XtestZC5;zc(j)];
                   XtestMAV5 = [ XtestMAV5; mav(j)];
                   XtestWaveForm5 =[ XtestWaveForm5; mav(j)];
                   
                   end 
                   
                    %'Down'
                   if (concatEpo.y(6,j) == 1) 
      
                   XtestZC6 = [XtestZC6;zc(j)];
                   XtestMAV6 = [ XtestMAV6; mav(j)];
                   XtestWaveForm6 =[ XtestWaveForm6; mav(j)];
                   
                   end 

    end
end
    etiqueta2 = concatEpo.y

DatosEMGCanal1{2,1}=  XtestZC1;
DatosEMGCanal1{2,2}=  XtestZC2;
DatosEMGCanal1{2,3}=  XtestZC3;
DatosEMGCanal1{2,4}=  XtestZC4;
DatosEMGCanal1{2,5}=  XtestZC5;
DatosEMGCanal1{2,6}=  XtestZC6;
DatosEMGCanal1{2,7}=  XtestMAV1;
DatosEMGCanal1{2,8}=  XtestMAV2;
DatosEMGCanal1{2,9}=  XtestMAV3;
DatosEMGCanal1{2,10}=XtestMAV4;
DatosEMGCanal1{2,11}=  XtestMAV5;
DatosEMGCanal1{2,12}= XtestMAV6;
DatosEMGCanal1{2,13}=  XtestWaveForm1;
DatosEMGCanal1{2,14}= XtestWaveForm2;
DatosEMGCanal1{2,15}=    XtestWaveForm3;
DatosEMGCanal1{2,16}=   XtestWaveForm4;
DatosEMGCanal1{2,17}=   XtestWaveForm5;
DatosEMGCanal1{2,18}=  XtestWaveForm6;

  


if concatEpo.x(:,1,:)
          for j = 1:nTrials
            
    
             zc2(j)   =     jZeroCrossing(concatEpo.x(:,1,j),0.1);  
             WF2(j)                 =     jWaveformLength(concatEpo.x(:,1,j));
             mav2(j)   = jMeanAbsoluteValue(concatEpo.x(:,1,j))
             
           %Forward
               if (concatEpo.y(1,j) == 1) 
           
                   XtestZC1c2 = [XtestZC1c2;zc2(j)];
                   XtestMAV1c2 = [XtestMAV1c2;mav2(j)];
                   XtestWaveForm1c2 = [XtestWaveForm1c2;WF2(j)];
                   
          
               end 
               %Backward
                  if (concatEpo.y(2,j) == 1) 
                      XtestZC2c2 = [XtestZC2c2;zc2(j)];
                   XtestMAV2c2 = [XtestMAV2c2;mav2(j)];
                   XtestWaveForm2c2 = [XtestWaveForm2c2;WF2(j)];                   
                  end
                  
                     %Left
                  if (concatEpo.y(3,j) == 1) 
                    XtestZC3c2 = [XtestZC3c2;zc2(j)];
                   XtestMAV3c2 = [XtestMAV3c2;mav2(j)];
                   XtestWaveForm3c2 = [XtestWaveForm3c2;WF2(j)];                   
                  end
                  
                  %Right
                  if (concatEpo.y(4,j) == 1) 
                    XtestZC4c2 = [XtestZC4c2;zc2(j)];
                   XtestMAV4c2 = [XtestMAV4c2;mav2(j)];
                   XtestWaveForm4c2 = [XtestWaveForm4c2;WF2(j)];                   
                  end
                  
                  %Up
                  if (concatEpo.y(5,j) == 1) 
                    XtestZC5c2 = [XtestZC5c2;zc2(j)];
                   XtestMAV5c2 = [XtestMAV5c2;mav2(j)];
                   XtestWaveForm5c2 = [XtestWaveForm5c2;WF2(j)];                   
                  end
                  
                  %Up
                  if (concatEpo.y(6,j) == 1) 
                    XtestZC6c2 = [XtestZC6c2;zc2(j)];
                   XtestMAV6c2 = [XtestMAV6c2;mav2(j)];
                   XtestWaveForm6c2 = [XtestWaveForm6c2;WF2(j)];                   
                  end
                  
    end
    
  DatosEMGCanal2{2,1}=  XtestZC1c2;
DatosEMGCanal2{2,2}=  XtestZC2c2;
DatosEMGCanal2{2,3}=  XtestZC3c2;
DatosEMGCanal2{2,4}=  XtestZC4c2;
DatosEMGCanal2{2,5}=  XtestZC5c2;
DatosEMGCanal2{2,6}=  XtestZC6c2;
DatosEMGCanal2{2,7}=  XtestMAV1c2;
DatosEMGCanal2{2,8}=  XtestMAV2c2;
DatosEMGCanal2{2,9}=  XtestMAV3c2;
DatosEMGCanal2{2,10}=XtestMAV4c2;
DatosEMGCanal2{2,11}=  XtestMAV5c2;
DatosEMGCanal2{2,12}= XtestMAV6c2;
DatosEMGCanal2{2,13}=  XtestWaveForm1c2;
DatosEMGCanal2{2,14}= XtestWaveForm2c2;
DatosEMGCanal2{2,15}=    XtestWaveForm3c2;
DatosEMGCanal2{2,16}=   XtestWaveForm4c2;
DatosEMGCanal2{2,17}=   XtestWaveForm5c2;
DatosEMGCanal2{2,18}=  XtestWaveForm6c2;
 



end
        
        %% RLDA - CLASSIFICATION WITH 10-FOLD CROSS-VALIDATION       

    end   
   
end



