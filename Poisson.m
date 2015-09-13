%Poisson Process Simulation

n = input('Enter the time interval: ');
samLength = input('Number of samples in each second: ');
lambda = input('Enter arrival rate: ');

p = lambda / samLength;
startTime = 0;
ArrTime = [];

for i = 1:n*samLength
    x = floor(rand(1,1) + p);
    if x == 1
        ArrTime = [ArrTime; i - startTime];
        startTime = i;
    end
end

ArrTime = ArrTime/samLength;

nBins = lambda / 10;
binBoundary = linspace(min(ArrTime), max(ArrTime), nBins+1);
binCounts = histc(ArrTime, binBoundary);

cumCount = zeros(1,length(binCounts));
for i = 1:length(binCounts)
    cumCount(1,i) = sum(binCounts(1:i));
end
cumCount = cumCount./sum(binCounts);

plot(binBoundary, binCounts)