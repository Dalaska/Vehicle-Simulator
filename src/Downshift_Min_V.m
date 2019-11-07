function [ v_down_min ] = Downshift_Min_V(v_upshift_min_mps)
%==========================================================================
% Objective: obtain the minimun speed for each gear during down shifting
% Input:  minimun speed for each gear at up shifting 
% Output: minimun speed for each gear at down shifting 
%==========================================================================

mps2mph = 2.23694; % meter per sec 2 mile per hour

% add hysteresis
v_down_min = v_upshift_min_mps/mps2mph - 0.5;

end

