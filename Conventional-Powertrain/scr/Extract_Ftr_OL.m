%==========================================================================
%                      % Extract Features
%==========================================================================

 %trip time
[ trip_time ] = Trip_Time_OL( p_attr,trip_time );

%  trip distance
[ trip_dist ] = Trip_Dist_OL( trip_dist,p_attr );

% average trip speed
mean_v =  2.23694* trip_dist/trip_time; % in mph

% F1 break level
[ b_mean,b_count ] = F1_Brake_OL( p_attr,b_mean,b_count );

% F2 coast time
 [ c_mean,c_count,p_prv_c ] = F2_Coast_OL( p_attr,c_mean,c_count,p_prv_c );
 
% F3 unneeded acceleration
%[ ratio_ua,ua_count,decl_count,time_sum,start_search] = F3_UnneedAccl_OL...
%    ( p_attr,ua_count,decl_count,time_sum,start_search );

% F4 kinetic energy
[ energy ] = F4_Energy_OL( p_attr,energy); 
energy_index = energy/trip_dist; % energy index
