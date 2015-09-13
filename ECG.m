%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B RAJA REDDY
% EE13B1004
% ECG Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
filename = '100.dat';
fid=fopen(filename,'r');
time=10;

f=fread(fid,2*360*time,'ubit12');
ecg_Sig=f(1:2:length(f));

%Rescaling the signal between -1 and 1
Signal = ecg_Sig - mean2(ecg_Sig);
Signal = -1 + 2 * ((Signal - min(Signal))/ (max(Signal) - min(Signal)));

figure;
subplot(2,1,1);plot(ecg_Sig); ylabel('Actual ECG Signal'); 
subplot(2,1,2);plot(Signal); ylabel('After re-scaling'); 
%%
%Adding Gaussian Noise to the signal
sigLen = length(Signal);
mean = 0;
var = 0.1;
gausNoise = normrnd(mean, var, [sigLen 1]);
sigGNoise = Signal + gausNoise;

%Applying Wiener Filter
fiSig = wienerFilter(Signal, sigGNoise);

%Computing MSE after filtering
gError = fiSig - Signal;
mseG = sum(gError.^2)/sigLen;

%%
%Adding Poisson Noise
samLength = 1000;
ArrRate = 100;
p = ArrRate / samLength;

sigPNoise = Signal;
for i = 1:sigLen
    x = floor(rand(1,1) + p);
    if x == 1
        sigPNoise(i) = Signal(i) + 1;
    end
end

%Applying Median Filter
filtSig = medfilt1(sigPNoise);

%Computing MSE after filtering
pError = filtSig - Signal;
mseP = sum(pError.^2)/sigLen;
Np = 3;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(Np,1,1);plot(sigPNoise); ylabel('Unfiltered signal'); 
title('Median Filter'); 
subplot(Np,1,2);plot(Signal); ylabel('Actual Signal');
subplot(Np,1,3);plot(filtSig);ylabel('Filtered Data');

fprintf('Mean Squared Error after Wiener Filtering (%f variance): %f\n',var,mseG);
fprintf('Mean Squared Error after Median Filtering (%f probability): %f\n',p,mseP);

