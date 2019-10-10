function [ microtrip_score ] = OnlineDriverScore( time_all,speed_all,acel_all,throttle_all )

%% inicialize 
run('Inicialize_OL.m')

% load classifier coefficients
load('Classifier_Coefficients.mat')


microtrip_score = []; % microtrip score
f1_val = []; %feature 1 value,  
f2_val =[];  %feature 2 value,
f3_val =[];  %feature 3

prob = 0; % microtrip score at each time step
x_test = [0 0 0];
for m=1:size(time_all,1)
     
    % get signals
     time = time_all(m,1);
     speed = speed_all(m,1);
     acel = acel_all(m,1);
     throttle = throttle_all(m,1);
    
    % smooth accelerationg (moving average)
    [ acel_smooth ] = LowPassFilter_OL( acel_smooth,acel,0.83);
    % parameter 0.83 works for sample frequency 10Hz
    
    % parse event
    [ prm ] = Find_Prm_OL( speed,throttle,acel_smooth);
    
    % add attribute
    [ p_attr,speed_start,time_start ] = Prm_Attr_OL( prm,p_prv,...
        time,speed,speed_prv,time_prv,time_start,speed_start );
    
    % save the previous
    p_prv = prm; % update previous event
    speed_prv = speed; % update previous speed
    time_prv = time; % update previous time
    
    
    if p_attr(1)~=0 % a new event occures
        
        % save the event for debugging
         DB_p_list=[DB_p_list;[time, p_attr]];
         
        % finite state machine
        [ trip_state,DB_start_pos,DB_stop_pos,write_signal,DB_mt_entry ] =...
            Find_MicroTrips_OL( trip_state,p_attr,time,DB_start_pos,DB_stop_pos ); 
        
        
        % 3 situations:
        if (write_signal == 1) && (trip_state ==1)
            % situation I: old microtrip stopped, and new trip started:
            % 1.test on the old trip, 2. update new trip
            run('Test_OL.m');
            run('Extract_Ftr_OL.m');
        end
        if (write_signal == 1) && (trip_state ==0)
            % situation II: old trip stopped, new trip not start yet:
            % 1.update the trip, 2. test on the trip
            run('Extract_Ftr_OL.m');
            run('Test_OL.m');
        end
        if (write_signal == 0) && (trip_state ==1)
            % situation III: in a miro trip
            % updates the trip value
            run('Extract_Ftr_OL.m');
        end
    end
    
    % log intermedia values at each moment
    microtrip_score =[microtrip_score;prob*100];
%     f1_val = [f1_val;x_test(1)];
%     f2_val = [f2_val;x_test(2)];
%     f3_val = [f3_val;x_test(3)];
    
    % record the micro trip for debug
    %DB_Micotrip = [DB_Micotrip;[DB_mt_entry,trip_time,trip_dist,mean_v,...
    %    b_mean,c_mean,energy_index,prob]];
    % start time, end time, trip duration, trip distance, mean speed, mean
    % break, mean coast time, energy index, probability
end


end