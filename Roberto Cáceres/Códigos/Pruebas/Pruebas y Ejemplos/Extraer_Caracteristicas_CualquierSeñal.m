T = table()
T.C0Mean = zeros(0)
T.C1Mean = zeros(0)
T.C2Mean = zeros(0)
T.C3Mean = zeros(0)
T.C4Mean = zeros(0)
T.C5Mean = zeros(0)

T.C0Entropia = zeros(0)
T.C1Entropia = zeros(0)
T.C2Entropia = zeros(0)
T.C3Entropia = zeros(0)
T.C4Entropia = zeros(0)
T.C5Entropia = zeros(0)

T.C0SD = zeros(0)
T.C1SD = zeros(0)
T.C2SD = zeros(0)
T.C3SD = zeros(0)
T.C4SD = zeros(0)
T.C5SD = zeros(0)

%T.Actividad = zeros(0)




T.Clase = zeros(0);
n = 1;
    %%
for i = 1:120
   
%     FFT = fft(Turn4(:,i));
wpt = wpdec(Wrist2(:,i),5,'db4');
%wt = cwt(Right3(150:end,i));
%Actividad = max(max(abs(wt)));

C0 = wpcoef(wpt,[5 2]);
C1 = wpcoef(wpt,[5 3]);
C2 = wpcoef(wpt,[5 4]);
C3 = wpcoef(wpt,[5 5]);
C4 = wpcoef(wpt,[5 6]);
C5 = wpcoef(wpt,[5 7]);

T.C0Mean(n) = jArithmeticMean(C0);
T.C1Mean(n) = jArithmeticMean(C1);
T.C2Mean(n) = jArithmeticMean(C2);
T.C3Mean(n) = jArithmeticMean(C3);
T.C4Mean(n) = jArithmeticMean(C4);
T.C5Mean(n) = jArithmeticMean(C5);

% T.C0Mean(n) = jHjorthMobility(C0);
% T.C1Mean(n) = jHjorthMobility(C1);
% T.C2Mean(n) = jHjorthMobility(C2);
% T.C3Mean(n) = jHjorthMobility(C3);
% T.C4Mean(n) = jHjorthMobility(C4);
% T.C5Mean(n) = jHjorthMobility(C5);

T.C0Entropia(n) = jShannonEntropy(C0);
T.C1Entropia(n) = jShannonEntropy(C1);
T.C2Entropia(n) = jShannonEntropy(C2);
T.C3Entropia(n) = jShannonEntropy(C3);
T.C4Entropia(n) = jShannonEntropy(C4);
T.C5Entropia(n) = jShannonEntropy(C5);
% 
% T.C0Entropia(n) = jHjorthComplexity(C0);
% T.C1Entropia(n) = jHjorthComplexity(C1);
% T.C2Entropia(n) = jHjorthComplexity(C2);
% T.C3Entropia(n) = jHjorthComplexity(C3);
% T.C4Entropia(n) = jHjorthComplexity(C4);
% T.C5Entropia(n) = jHjorthComplexity(C5);



T.C0SD(n) = jStandardDeviation(C0);
T.C1SD(n) = jStandardDeviation(C1);
T.C2SD(n) = jStandardDeviation(C2);
T.C3SD(n) = jStandardDeviation(C3);
T.C4SD(n) = jStandardDeviation(C4);
T.C5SD(n) = jStandardDeviation(C5);
% 
% T.C0SD(n) =jHjorthActivity(C0);
% T.C1SD(n) = jHjorthActivity(C1);
% T.C2SD(n) = jHjorthActivity(C2);
% T.C3SD(n) = jHjorthActivity(C3);
% T.C4SD(n) = jHjorthActivity(C4);
% T.C5SD(n) = jHjorthActivity(C5);

%T.Actividad(n) = Actividad;
T.Clase(n) = 0;

     n = n+1;
end

writetable(T,'WaveletComponentSesion1' +"."+'xls')
%writetable(T,'WNodos'+'.csv')



