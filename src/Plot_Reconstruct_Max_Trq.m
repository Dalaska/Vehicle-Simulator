function [  ] = Plot_Reconstruct_Max_Trq( trev_recon )
%==========================================================================
%  Objective: plot the reconstruct maxium torque demand
%  Input: reconstructed maxium torque demand
%  Output: NA
%==========================================================================

% visual reserve
figure()
hold on
for n = 1:size(trev_recon,1) % loop through each driver score
    plot(trev_recon(n,:))
end
ylabel('Torque reserve [Nm]')
xlabel('index')
legend('0.0','0.2','0.4','0.6','0.8','1.0')


end

