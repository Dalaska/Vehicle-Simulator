function [ torq_reserve,trq_mat_2d ] = Get_Trque_Reserve2( trip_log )
%==========================================================================
% Objective: caculate the torque reserve, torque demand in the next n
% second without down shifting
% Input: index of selected trip
% Output: torque reserve for each trip
%==========================================================================

% discretized speed, torque, the next speed
bin_v = linspace(-0.01,28,10);
bin_t =  linspace(-0.01,6000,6); % min at -1.5, #6
bin_tx = linspace(-0.01,4000,201); % next acceleration fine resolution
next_n_sec = 20; % 2 second, reserve herizon next /10 sec

run('Load_Veh_Parameters.m') %

torq_reserve =[]; % inicalize torque reserve
for n = 1:size(trip_log,1)
    
    % load trip
    [ trip_name ] = Construct_Name( trip_log(n,:) );
    load(trip_name);
    [ CYC_t,CYC_v,CYC_grade,CYC_gear,CYC_trq,CYC_fuel,CYC_w ] = Load_Trip( stream );
    
    % transition matrix
    [ tran_mat_tot ] = Make_Transition_Matrix( CYC_v, bin_v, bin_t,bin_tx,next_n_sec );
    
    % get trque reserve
    [ trq_mat_2d ] = Trq_Mat3( tran_mat_tot,0.9,bin_tx);
    
    % flattern
    len = size(trq_mat_2d,1)*size(trq_mat_2d,2);
    trq_mat_flat = reshape(trq_mat_2d,[1,len]);
    torq_reserve = [torq_reserve;trq_mat_flat];
    
end


end

