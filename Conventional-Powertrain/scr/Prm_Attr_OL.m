function [ p_attr,speed_start,time_start ] = Prm_Attr_OL( prm,p_prv,time,speed,speed_prv,time_prv,time_start,speed_start )
%==========================================================================
%                               Prm_Attr_OL
% add attributes to a primitive
%--------------------------------------------------------------------------
% inputs:
% prm: primitive type
% p_prv: previous primitive
% time: time of the current event
% speed: speed of the current event
% speed_prv: speed of the previous event
% time_prv: time of the previous event
% time_start: starting time of an event
% speed_start: starting speed of an event
%--------------------------------------------------------------------------
% outputs:
% p_attr: attributes of a primitive
% speed_start: starting speed of an event
% time_start: starting time of an event
%-------------------------------------------------------------------------- 
%                           Tuning Parameters 
T_min_time = 0.5; % minimal duration for an event
%==========================================================================

% inicalize 
p_attr = [0 0 0 0];
if prm ~= p_prv % current and the previous event are not the same
    % find a new event
    speed_end = speed_prv; % end speed of a event
    duration = time_prv - time_start; % duration of a event
    
    % filter by the minimal duration
    if duration > T_min_time
        % create a new event
        p_attr = [p_prv,duration,speed_start,speed_end];
    end
    
    % inicialize
    time_start = time; % starting time of an event
    speed_start = speed; % starting speed of an event
    
end
end

