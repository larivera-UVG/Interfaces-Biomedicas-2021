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


dd='C:\Users\barss\OneDrive\Desktop\EEG_Sesion1_Twist\'; 
cd 'C:\Users\barss\OneDrive\Desktop\EEG_Sesion1_Twist';
% Example: dd='Downlad_folder\SampleData\plotScalp\';

datedir = dir('*.mat');
filelist = {datedir.name};

% Setting time duration: interval 0~3 s
ival=[0 3001];

%% Performance measurement
for i = 1:1
    filelist{i}
    [cnt,mrk,mnt]=eegfile_loadMatlab([dd filelist{1}]);
    
    % Band pass filtering, order of 4, range of [8-30] Hz (mu-, beta-bands)
    filterBank = {[8 30]};
    for filt = 1:length(filterBank)
        filelist{i}
        filterBank{filt}
        
        cnt = proc_filtButter(cnt, 4 ,filterBank{filt});
        epo=cntToEpo(cnt,mrk,ival);
        
        % Select channels
       %% epo = proc_selectChannels(epo, {'EMG_1','EMG_2','EMG_3','EMG_4','EMG_5','EMG_6','EMG_ref'});
        epo = proc_selectChannels(epo, {'Fp1'});
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
        
        %% CSP - FEATURE EXTRACTION
        [csp_fv,csp_w,csp_eig]=proc_multicsp(concatEpo,3);
        proc=struct('memo','csp_w');
        
        proc.train= ['[fv,csp_w]=  proc_multicsp(fv, 3); ' ...
            'fv= proc_variance(fv); ' ...
            'fv= proc_logarithm(fv);'];
        
        proc.apply= ['fv= proc_linearDerivation(fv, csp_w); ','fv= proc_variance(fv); ' ,'fv= proc_logarithm(fv);'];
        
        
        %% RLDA - CLASSIFICATION WITH 10-FOLD CROSS-VALIDATION       
        [C_eeg, loss_eeg_std, out_eeg.out, memo] = xvalidation(concatEpo,'RLDAshrink','proc',proc, 'kfold', 10);
        Result(filt)= 1-C_eeg;
        Result_Std(filt)=loss_eeg_std;
        All_csp_w(:,:,filt)=csp_w;
    end   
    % Maximum classification performance of each subject
    maxPerformance(i) = max(Result);
    
end

%% Primera Prueba con WristTwisting 

data2 = cell(2,8);

data2{1,1}='ZC1';
data2{1,2}='ZC2';
data2{1,3}='MAV1';
data2{1,4}='MAV2';
data2{1,5}='VAR1';
data2{1,6}='VAR2';
data2{1,7}='KURTO1';
data2{1,8}='KURTO2';

[nTimes,nChan,nTrials] = size(concatEpo.x)

    
    eti1 = [];
    XtestZC1 = [];
    XtestMAV1 = [];   
    XtestVAR1 = [];
    XtestKUR1 = [];
            
    eti2 = [];
    XtestZC2 = [];
    XtestMAV2 = []; 
    XtestVAR2 = [];
     XtestKUR2 = [];
for j = 1:nTrials
            
    
            varian(j) = var(concatEpo.x(:,1,j));
             [zc(j), mav(j)]=metricas(concatEpo.x(:,1,j),0,0);  
             curtos(j) = kurtosis(concatEpo.x(:,1,j));
         
          
           %Izquierda
               if concatEpo.y(1,j) == 1
                   XtestZC1 = [XtestZC1;zc(j)];
                   XtestVAR1 = [XtestVAR1;varian(j)];
                   XtestMAV1 = [XtestMAV1;mav(j)];
                   XtestKUR1 = [XtestKUR1;curtos(j)];
               end 
               %Derecha
                  if concatEpo.y(2,j) == 1
                   XtestZC2 = [XtestZC2;zc(j)];
                   XtestMAV2 = [XtestMAV2;mav(j)]; 
                   XtestVAR2 = [XtestVAR2;varian(j)];
                   XtestKUR2 = [XtestKUR2;curtos(j)];
               end 
%         
% 
end
 
etiqueta2 = concatEpo.y

data2{2,1}=XtestZC1;
data2{2,2}=XtestZC2;
data2{2,3}=XtestMAV1;
data2{2,4}=XtestMAV2;
data2{2,5}=XtestVAR1;
data2{2,6}=XtestVAR2;
data2{2,7}=XtestKUR1;
data2{2,8}=XtestKUR2;
% dat = permute(concatEpo.x,[2 1 3]);
%  dat = mean(dat,2);
%  l22=concatEpo.x(:,5,100)
%  k1 = kurtosis(concatEpo.x(:,1,150));
%  v1=var(dat);
%  
%  [zc,mav]=metricas(dat(:,:,150),0,0);  


