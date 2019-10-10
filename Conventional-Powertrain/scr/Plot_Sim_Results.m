function [ ] = Plot_Sim_Results( v_060,t_060,driver_score,lms,mpg )
%==========================================================================
%  Objective: Plot simulation results for 0-60 time, drivability metrics
%  and fuel economy
%  Input: speed(0-60),time(0-60),driver score, drivability metric, mpg
%  Output:  NA
%==========================================================================

% color scale
col = [     0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840;
    0    0.4470    0.7410;
    0.8500    0.3250    0.0980;];


figure()
% plot 0-60 time 
subplot(3,1,1)
%Plot_060( v_060,t_060 )
Plot_0100kmh( v_060,t_060 )
grid on

% plot drivability metrics
subplot(3,1,2)
hold on
plot(driver_score,lms(:,1),'-o','LineWidth',1,'Color',col(2,:));
plot(driver_score,lms(:,2),'-o','LineWidth',1,'Color',col(3,:));
plot(driver_score,lms(:,3),'-o','LineWidth',1,'Color',col(1,:));
ylabel('Drivability (LMS)')
xlabel('Driver score ')
grid on
legend('ds: 0.19','ds: 0.51','ds: 0.89')

% plot fuel economy
subplot(3,1,3)
hold on
plot((driver_score),mpg(:,1),'-o','LineWidth',1,'Color',col(2,:));
plot((driver_score),mpg(:,2),'-o','LineWidth',1,'Color',col(3,:));
plot((driver_score),mpg(:,3),'-o','LineWidth',1,'Color',col(1,:));
ylabel('Fuel economy [MPG]')
xlabel('Driver score ')
grid on
axis([0 1 11 17])
end

