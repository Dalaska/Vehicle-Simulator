function [  ] = Plot_Down_Shift( shift_map )
%==========================================================================
%  Objective: visualize the downshift map
%  Input: down shift map
%  Output: NA
%==========================================================================

mps2mph = 2.2369; % convert mps to mph
ENG_torq = linspace(0,100,17);  % inicialize engine torque

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
    
% plot down shift
figure()
hold on
for m =1:size(shift_map,1) % loop through each driver score
    % reshape the flattened shift map to a max
    shift_map2 = reshape(shift_map(m,:),[6,17]);
    for n =1:5 % loop through each gear
        plot(shift_map2(n+1,:)*mps2mph,ENG_torq(:),'-o','Color',col(n,:))
    end
end
legend('2-1','3-2','4-3','5-4','6-5')
xlabel('Vehicle speed [mph]')
ylabel('Throttle [%]')
grid on

end

