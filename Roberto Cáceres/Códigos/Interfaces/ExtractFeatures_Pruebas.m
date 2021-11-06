T = table()
T.HjorthActivity = zeros(0)
T.NormalizedFirstDifference = zeros(0)
T.HjorthComplexity = zeros(0)
T.Kurtosis = zeros(0)
T.MeanEnergy = zeros(0)
T.Skewness = zeros(0)
T.ShannonEntropy = zeros(0)
T.HjorthMobility = zeros(0)
T.PCALatent = zeros(0);
T.PCAMu = zeros(0);
T.Clase = zeros(0);
n = 0;
    %%
for i = 1:120
    n = n+1
    FFT = fft(Turn4(:,i));
    
    [coeff,score,latent,tsquared,explained,mu] = pca(FFT);
    T.HjorthActivity(n) = jHjorthActivity(FFT);
    T.NormalizedFirstDifference(n) = jNormalizedFirstDifference(FFT);
    T.HjorthComplexity(n) = jHjorthComplexity(FFT);
    T.Kurtosis(n) = jKurtosis(FFT);
    T.MeanEnergy(n) = jMeanEnergy(FFT);
    T.Skewness(n) =  jSkewness(FFT);
    T.ShannonEntropy(n) = jShannonEntropy(FFT);
    T.HjorthMobility(n) = jShannonEntropy(FFT);
    T.PCALatent(n) = latent;
    T.PCAMu(n) = mu;
    T.Clase(n) = 2;

    
end

