function [ va_list ] = Group_Speed_Acc( speed )
%==========================================================================
%  Objective: group the data based on speed and acceleration
%  input: vehicle speed
%  output: speed and acceleration list
%==========================================================================

% smooth speed and accelerating
speed_smooth = smooth(speed,0.005); % smoothed speed

% get acceleration
acc = diff(speed_smooth);
acc = [0;acc];

% group speed and acceleration into a list
va_list = [speed_smooth,acc];

end

