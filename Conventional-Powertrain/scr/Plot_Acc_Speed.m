function [  ] = Plot_Acc_Speed( V,T,num_maps )
%==========================================================================
%  Objective: plot vehicle acceleration results
%  Input: vehicle speed, time, number of shift maps
%  Output: NA
%==========================================================================

mps2mph = 2.2369; % unit conversion

% color scale
col = [ 0.4660    0.6740    0.1880; % 5.green   
             0    0.4470    0.7410; % 1.blue
        0.4940    0.1840    0.5560; % 4.purp
        0.8500    0.3250    0.0980; % 2.red
        0.9290    0.6940    0.1250; % 3.yellow  
        0.3010    0.7450    0.9330; % 6.cyn
        0.6350    0.0780    0.1840]; % 7.rose
    
figure()
hold on
for n = 1:num_maps % plot the result for each shift map
plot(T(:,n),V(:,n)*mps2mph,'-','LineWidth',1,'Color',col(n,:))
end 
legend('Max Efficiency','Relaxed','Base Line','Aggressive','Max Accleration');
ylabel('Vehicle speed [mph]')
xlabel('Time [sec]')
grid on
axis([0 100 0 80 ])

end

