%==========================================================================
%                              Inicialze parameters   
%
%========================================================================== 

%inicalize
acel_smooth = 0; % smoothed acceleration

% Prm_Attr_OL
p_prv = 0; % previous primitive
speed_prv = 0; % previous speed
time_prv = 0; % previous time
time_start = 0; % primitive start time
speed_start = 0; % primitive start speed

% Trip_Time_OL
trip_time =0; % trip time

% Trip_Dist_OL
trip_dist = 0; % trip distance

% Find_MicroTrips_OL
write_signal =0; % single for ending a microtirip
count_trip = 0; % count of microtrip
trip_state = 0;

P=0; % average driver score

% F1
b_mean = 0; % averge brake level
b_count =0; % count of brake evnets

% F2
c_mean=0; % average coast time
c_count=0; % number of coast events
p_prv_c=[0 0 0 0]; % previous event

% F3
decl_count = 0; % number of decleration event
ua_count = 0; % number of decleration event
time_sum = 0; % sum of search time
start_search =0; % start search state

% F4
energy = 0; % kinetic energy

mean_v =0; % average speed

% prameter for debugging
DB_p_list =[]; % event list
DB_scores=[]; % driver score list
DB_Micotrip = []; % microtrip list
DB_mt_entry = 0; % microtrip entry
DB_start_pos = 0; % micro trip start posiiton 
DB_stop_pos = 0; % micro trip stop posiiton 
