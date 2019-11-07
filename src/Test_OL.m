%==========================================================================
%                        Test the microtrip   
%--------------------------------------------------------------------------
%                           Tuning Parameters
T_dist_min = 100; % minimal trip distance
T_min_v = 10; % minimal average speed
%==========================================================================

%  filter the trip
if (trip_dist>T_dist_min) && (mean_v > T_min_v) 
    % (trip dist > a limit) and (trip time > a limit)
    
    m_speed = mean_v; % mean speed of the microtrip
    
    % create a feature
     ftr = [b_mean,c_mean,energy_index];
    
    % classify the microtrip
    run('Classify_OL.m')
    
    % cacualate average driver score recursively
    P = (P*count_trip+prob)/(count_trip+1);
    count_trip = count_trip +1;
    
    % record the micro trip for debug
    DB_Micotrip = [DB_Micotrip;[DB_mt_entry,trip_time,trip_dist,mean_v,...
        b_mean,c_mean,energy_index,prob]];
    % start time, end time, trip duration, trip distance, mean speed, mean
    % break, mean coast time, energy index, probability
end

% inicailize
trip_time =0;
trip_dist = 0;
% F1
b_mean = 0;
b_count =0;
% F2
c_mean=0;
c_count=0;
p_prv_c=[0 0 0 0];
decl_count = 0; 
% F3
ua_count = 0;
mean_v = 0;
% F4
energy=0;