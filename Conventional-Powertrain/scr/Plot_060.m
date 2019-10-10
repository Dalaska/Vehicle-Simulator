function [] = Plot_060( speed,time )
%==========================================================================
%  Objective: plot 0 to 60 time
%  input: vehicle, speed, time
%  output: NA
%==========================================================================
mps2mph = 2.2369;

for n = 1:size(speed,2)
    % time from 0 to 0
    t0(n) = Get_Accleration_Time( speed(:,n),time(:,n),0.5,0/mps2mph ); 
    % time from 0 to 60
    t60(n) = Get_Accleration_Time( speed(:,n),time(:,n),0.5,60/mps2mph ); 
    t0_60(n) = t60(n) - t0(n); % 0 to 60 time
end

driver_score = linspace(0,1,6); % driver score

plot(fliplr(driver_score),t60,'-ok','LineWidth',1)
ylabel('0-60 mph time [sec]')
xlabel('Driver score ')

end

