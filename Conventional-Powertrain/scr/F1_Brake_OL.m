function [ b_mean,b_count ] = F1_Brake_OL( p_attr,b_mean,b_count )
%==========================================================================
%                        F1_Brake_Level
% definition:
%         average deceleration rate in brake events
% approximation of decelerating: change_of_speed/event_duration
%--------------------------------------------------------------------------
% inputs:
% p_list: list of primitives
%--------------------------------------------------------------------------
% output:
% b_mean: average acceleration of brake
% brake_list: detialed list of brake events
%--------------------------------------------------------------------------
%                           Tuning Parameters
T_dv = 5; %thredhold for minal change of speed, significant change
T_max = 4.5; % thredhold for truncate maxium decleration
%==========================================================================

% inicialize
dv = p_attr(3)-p_attr(4);
if (p_attr(1) == 4) && (dv > T_dv)
    % (event is decelerating) and (change of speed is greater than the thredhod)
    
    % approximation of decelerating: change_of_speed/event_duration
    decel = dv/p_attr(2);
    
    % truncate max value
    decel = min(decel,T_max);
       
    % record brake event
    b_mean = (b_mean*b_count + decel)/(b_count+1); % recursive average
    b_count =b_count+1;
end

end

% caculate the mean brake




