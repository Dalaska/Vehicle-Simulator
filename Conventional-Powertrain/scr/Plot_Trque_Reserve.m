function [  ] = Plot_Trque_Reserve( trq_reserve,G_B )
%==========================================================================
% Objective: plot the trque reserve
% Input: the torque reserve vector, index of good/bad driver
% Output: NA
%==========================================================================

% good or bad
trq_g = G_B == 1;
trq_b = G_B == 0;

% caculate the mean of torque reserve
[ trq_mean ] = Get_Mean( trq_reserve );

figure()
hold on
plot(mean(trq_reserve(trq_g,:)),'g','LineWidth',1);
plot(mean(trq_reserve(trq_b,:)),'r','LineWidth',1);
plot(trq_mean,'b','LineWidth',1)
legend('Aggressive','Relaxed','Mean')
axis([0 45 0 250])
ylabel('Torque reserve [Nm]')
xlabel('index')
title('Torque reserve flatterned')

end

