%Roberto Caceres - 17163
%2021
%Este codigo nos sirve para poder extraer las caracteristicas de la base de
%datos obtenida. 

%% Initalization
clc; close all; clear all;
%%
% Directory
% Write down where converted data file downloaded (file directory)
dd='C:\Users\barss\OneDrive\Desktop\EMG_AllSesions_AllSub_twist\'; 
cd 'C:\Users\barss\OneDrive\Desktop\EMG_AllSesions_AllSub_twist';
% Example: dd='Downlad_folder\SampleData\plotScalp\';

datedir = dir('*.mat');
filelist = {datedir.name};

% Setting time duration: interval 0~3 s
ival=[0 3001];
j =0;

%% Performance measurement
for i = 1:length(filelist)
    

    filelist{i}
    [cnt,mrk,mnt]=eegfile_loadMatlab([dd filelist{i}]);
    
    filterBank = {[8 30]};
    for filt = 1:length(filterBank)
        filelist{i}
        filterBank{filt}
        
        cnt = proc_filtButter(cnt, 4 ,filterBank{filt});
        epo=cntToEpo(cnt,mrk,ival);
        
        % Select channels
        epo = proc_selectChannels(epo, {'EMG_1','EMG_2','EMG_3','EMG_4','EMG_5','EMG_6','EMG_ref'});
        
        classes=size(epo.className,2);
        
        trial=50;
        
    end
    anotaciones = length(classes);
    zc=zeros(anotaciones,n);
    mav=zeros(anotaciones,n);
    varian=zeros(anotaciones,n);
    curtos=zeros(anotaciones,n);
    for j=1:anotaciones

    Record = epo.x(1)
    
    end
    
    
    
end

A = num2cell(maxPerformance);
subPerformance = cat(1, filelist, A);

% Save results of FBCSP with RLDA in excel file
% total results: 9 bands of accuracies
filename = 'Performance_reaching_ME.xlsx';
writecell((subPerformance)', filename, 'Sheet', 1);

