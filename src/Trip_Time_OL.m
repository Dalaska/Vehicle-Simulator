function [ trip_time ] = Trip_Time_OL( p_attr,trip_time )
%==========================================================================
%                        Trip_Time_Online
% obtain the duration of a microtrip
%--------------------------------------------------------------------------
% inputs:
% p_attr: event attributes
% trip_time: previous trip duration
%--------------------------------------------------------------------------
% outputs:
% trip_time: updated trip duration
%--------------------------------------------------------------------------
%                      Tuning Parameters
T_max_idle = 10; % idle penality max
%==========================================================================

% if the last event is idle add
if p_attr(1) ==5
    trip_time = trip_time + min(p_attr(2),T_max_idle);
    % truncate idle time if exeed the maxium limit
end
trip_time = trip_time + p_attr(2); % accumulate trip time
end

