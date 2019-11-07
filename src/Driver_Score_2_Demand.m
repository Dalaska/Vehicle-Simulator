function [ trev_recon ] = Driver_Score_2_Demand( ds, ptrev_1, ptrev_2, pc_cof_trev, mean_trev )
%==========================================================================
% Objective: recomstruct demand from driver score
% input: driver score
% output: reconstructed torque reserv
%==========================================================================

% principle component from driver score
trev_pc = ptrev_1*ds + ptrev_2;

% reconstruct demand though inverted PCA
[ trev_recon ] = Invert_PCA( trev_pc,pc_cof_trev,mean_trev );

% limit minimal torque reserve is greater than zero
for n = 1:size(trev_pc,2)
    trev_recon(n,:) = max(0,trev_recon(n,:));
end

end

