function [ v_mph ] = rpm2mph( eng_rpm, gear )
%==========================================================================
%  Objective: convert rpm to mph
%  input: engine rpm
%          transmission gear
%  output: vechile speed in mph
%==========================================================================

VEH_Rw = 0.3570; % wheel radius
TRAN_ratio_gear = [3.094,1.809, 1.406, 1.00, 0.711, 0.614]; % Transmission Gear Ratios
TRAN_ratio_diff = 5.05; % final drive ratio
rpm2rad = 0.10472; % rpm to rad/s
mps2mph = 2.23694; % meter per sec 2 mile per hour

% vehicle speed in mph
v_mph = eng_rpm*VEH_Rw*rpm2rad*mps2mph/TRAN_ratio_gear(gear)/TRAN_ratio_diff;


end

