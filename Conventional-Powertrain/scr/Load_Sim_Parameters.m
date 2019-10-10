%==========================================================================
% Objective: load simulation parameters
%==========================================================================

DR_P = 2; % Driver PID: P
DR_I = 0.001; % Driver PID: I
DR_FF = 0.5; % Driver feed forward gain
DR_LP = 0.995; % % Driver low pass filter
Stoptime = CYC_t(end); % simulation stop time
VEH_M2 = 8500; % vehicle mass
WOT = 0; % wide open throttle