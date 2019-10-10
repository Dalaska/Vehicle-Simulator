function [ max_trq,v_mph ] = Get_Max_Trq_Demand(trip_log )
%==========================================================================
%  Objective: obtain maxium torque demand from a trip
%  Input: index of the selected trip
%  Output: maxmium torque demand, vehicle speed in mph
%==========================================================================
run('Load_Veh_Parameters.m') % load vehicle parameters

% inicilaize
max_trq= []; % list of maxium toruqe

for n = 1:size(trip_log,1)
    % load trip
    [ trip_name ] = Construct_Name( trip_log(n,:) );
    load(trip_name);
    [ CYC_t,CYC_v,CYC_grade,CYC_gear,CYC_trq,CYC_fuel,CYC_w ] = Load_Trip( stream );
    
    % get acceleration, input percentile
    [ torq_at_wheel,v_mph ] = Get_Trq_at_Wheel( CYC_v,VEH_M,VEH_Cr,VEH_Cdl,VEH_Rw );
    max_trq = [max_trq;torq_at_wheel]; % log the torque value
end

end

