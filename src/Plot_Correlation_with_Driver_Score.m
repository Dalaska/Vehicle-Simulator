function [  ] = Plot_Correlation_with_Driver_Score( driver_score,trq_1d,G_B )
%==========================================================================
%  Objective: plot the correlation with the driver score
%  torque
%  input: driver score, aggressiveness, good/bad label
%  output: NA
%==========================================================================

% index of good/bad cycles
Tg = G_B == 1;
Tb = G_B == 0;

figure()
hold on
plot(driver_score(Tg),trq_1d(Tg),'og','LineWidth',1)
plot(driver_score(Tb),trq_1d(Tb),'or','LineWidth',1)


% plot the fitted line
p = polyfit(driver_score,trq_1d,1);
x = [0 1];
y = p(1)*x + p(2);
plot(x,y,'b')

grid on
axis([0 1 0 1])
ylabel('Normalized torque reserve')
xlabel('Driver score')
legend('Relaxed','Aggressive','Fitted line')


end

