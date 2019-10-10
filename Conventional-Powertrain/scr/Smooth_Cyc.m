function [ CYC_v_smth,CYC_acc ] = Smooth_Cyc( CYC_v, r )
%==========================================================================
% Objective: smooth a driving cycle
% Input: speed profile, smooth parameter
% Output: smooth speed, acceleration
%==========================================================================

CYC_v_smth = smooth(CYC_v,r); % smoothed speed

% get acceleration
CYC_acc = diff(CYC_v_smth);
CYC_acc = [0;CYC_acc];

end

