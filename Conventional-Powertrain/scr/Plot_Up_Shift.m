function [  ] = Plot_Up_Shift( SL )
%==========================================================================
%  Objective: visualize the upshift map
%  Input: the upshift map
%  Output: NA
%==========================================================================

% convert mps to mph
mps2mph = 2.2369;

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

% inicialize engine torque    
ENG_torq = linspace(0,100,17);  

figure()
hold on
for m =1:size(SL,1)
    SL1 = reshape(SL(m,:),[5,17]); % 
    for n =1:5 % each gear
        plot(SL1(n,:)*mps2mph,ENG_torq(:),'-o','Color',col(n,:))
    end
end
legend('1-2','2-3','3-4','4-5','5-6')
xlabel('Vehicle speed [mph]')
ylabel('Throttle [%]')
grid on


end

