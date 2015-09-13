%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B RAJA REDDY
% EE13B1004
% Simulation of Poisson Process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
samLength = 1000000; %Number of samples needed 
lambda = 10000; %Arrival Rate

p = lambda / samLength; %Probability of occurence
startTime = 0;
ArrTime = [];

for i = 1:samLength
    x = floor(rand(1,1) + p);
    if x == 1
        ArrTime = [ArrTime; i - startTime];
        startTime = i;
    end
end

ArrTime = ArrTime/samLength;

%%
nBins = 100; %Putting the arrival times into bins and getting their counts
binBoundary = linspace(min(ArrTime), max(ArrTime), nBins+1);
binCounts = histc(ArrTime, binBoundary);

%The plot must resemble Exponential Probability Distribution
figure('units','normalized','outerposition',[0 0 1 1])
plot(binBoundary, binCounts)
title(['PDF of Arrival Times with ' 'Arrival Rate:' ...
    num2str(lambda) ', No. of Samples:' num2str(samLength)])
xlabel('Arrival Time')
ylabel('Number of Occurences')