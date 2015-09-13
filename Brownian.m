%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B RAJA REDDY
% EE13B1004
% Simulation of Brownian Motion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
N = input('Enter number of steps needed: ');

position = struct();
xDisp = randn(N,1);
yDisp = randn(N,1);
position.x = cumsum(xDisp);
position.y = cumsum(yDisp);

figure;
xlabel('X Position');
ylabel('Y Position');
title('Position of Particle in 2D');
hold on
for i = 1:N-1
    plot([position.x(i),position.x(i+1)], [position.y(i),position.y(i+1)]);
    drawnow
    pause(0.05)
end 