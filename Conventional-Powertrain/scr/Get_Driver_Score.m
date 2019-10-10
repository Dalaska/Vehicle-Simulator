function [ driver_score ] = Get_Driver_Score( trip_log )
%==========================================================================
%  Objective: obtain the driver score of a trip
%  Input: a log of selected trips
%  Output: a list of the driver score
%==========================================================================

driver_score = []; % inicalize the list of driver score

for n = 1:size(trip_log,1)
    
    % load trip data
    [ trip_name ] = Construct_Name( trip_log(n,:) );
    load(trip_name);
    
    % obtain the driver score
    [ ds ] = OnlineDriverScore( stream );
    
    driver_score = [driver_score; ds]; % the list of driver score
    
end

end

