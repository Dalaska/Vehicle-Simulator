function [ trip_dist ] = Trip_Dist_OL( trip_dist,p_attr )
%==========================================================================
%                        Trip_Dist_Online
% obtain the duration of a microtrip
%--------------------------------------------------------------------------
% inputs:
% p_attr: event attributes
% trip_dist: previous trip distance
%--------------------------------------------------------------------------
% outputs:
% trip_dist: updated trip distance
%==========================================================================

% trip distance
dist = 0.44704*p_attr(2)*(p_attr(3)+p_attr(4))/2;
% approximate trip distance:
        % (start_speed + end_speed)*trip_duration/2
        % convert distance from mile to meter

% approximate trip distance:
trip_dist = trip_dist + dist;

end

