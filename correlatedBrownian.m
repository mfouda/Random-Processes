%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B RAJA REDDY
% EE13B1004
% Simulation of Correlated Brownian Motion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
N = 100;
rho = input('Enter correlation coefficient: ');

position = struct(); %Structure for storing position of particle
xDisp = randn(N,1); %Motion along X direction

%Motion along Y direction is in correlation with motion along x direction
yDisp = rho * xDisp + sqrt(1 - rho^2) * randn(N,1); 
position.x = cumsum(xDisp);
position.y = cumsum(yDisp);

%%
%Plotting the position of the particle
figure;
xlabel('X Position');
ylabel('Y Position');
title(['Position versus Time in 2D (\rho = ' num2str(rho) ')']);
hold on
for i = 1:N-1
    plot([position.x(i),position.x(i+1)], [position.y(i),position.y(i+1)]);
    drawnow
    pause(0.05)
end