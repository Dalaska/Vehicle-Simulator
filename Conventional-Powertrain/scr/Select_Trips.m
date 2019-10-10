function [ trip_log_selected ] = Select_Trips( )
%==========================================================================
%  Objective: selected trips from the index
%  Input: NaN
%  Output: a new log of the selected trips
%==========================================================================

% load trip index
load('Trip_Log'); 
% index: cycle, weight, good/bad, driver#, trip#

% select trips that uses the 8700 vehicles,and the Eagle creek route
trip_log_selected = trip_log( (trip_log(:,1) == 1) & (trip_log(:,2) == 8700),: );

end

