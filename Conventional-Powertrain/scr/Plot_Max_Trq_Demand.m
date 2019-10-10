function [  ] = Plot_Max_Trq_Demand( max_trq,v_mph,G_B )
%==========================================================================
%  Objective: plot maxium torque at wheel at different speed
%  Input: maxium torque demand at diffferent speed, vehicle speed in mph, 
%  good/bad label
%  Output: NA
%==========================================================================

id_g = G_B == 1; % index of good driver
id_b = G_B == 0; % index of bad driver
trq_mean = mean(max_trq); % the average torque
mph2kmh = 1.60934;
v_kmh = v_mph*mph2kmh;
% Plot aggressive relexed and mean
%figure()
%hold on
plot(v_kmh,mean(max_trq(id_g,:)),'LineWidth',2,'LineStyle','--');
plot(v_kmh,mean(max_trq(id_b,:)),'LineWidth',2,'LineStyle','-.');
plot(v_kmh,trq_mean,'LineWidth',2);
ylabel('Maxium traction torque [Nm]')
xlabel('Vechile speed [km/h]')
%legend('Relaxed','Aggressive','Average')
%grid on
%title('Maximum Torque Demand')

end

