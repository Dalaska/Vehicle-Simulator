function [ CYC_t,CYC_v,CYC_grade,CYC_gear,CYC_trq,CYC_fuel,CYC_w ] = Load_TripS( n,trip_log )
%==========================================================================
% Objective: generate the down shift map
% input: the number of trip, index of trip
% output: driving data
%==========================================================================

trip_name = Construct_Name2(n,trip_log );
load(trip_name); % load trip
[ CYC_t,CYC_v,CYC_grade,CYC_gear,CYC_trq,CYC_fuel,CYC_w ] = Load_Trip2( stream );

end

