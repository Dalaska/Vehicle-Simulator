function [ CYC_v ] = Smooth_Speed( CYC_v )
%==========================================================================
% Objective: Smooth the cycle speed
% Input: the orignal cycle speed
% Output: the smoothed cycle speed
%==========================================================================

CYC_v = smooth(CYC_v,0.005 ); % smoothed speed

% if speed less than 0.2 override it with 0
for n = 1:length(CYC_v)
    if CYC_v(n)<0.2
        CYC_v(n) = 0;
    end
end

end

