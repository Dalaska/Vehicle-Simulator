function [ torq_at_wheel,v_mph ] = Get_Trq_at_Wheel( CYC_v,VEH_M,VEH_Cr,VEH_Cdl,VEH_Rw )
%==========================================================================
%  Objective: obtain the torque at wheel
%  Input: speed profile, vehicle mass, rolling resistance, aerodynamic
%  drag, wheel radius
%  Output: torq demand at wheel, vehicile speed in mph
%==========================================================================

% accleration and speed pair
[ speed_acc_list ] = Group_Speed_Acc( CYC_v );

% Get percentile
[ va_max,v_mph ] = Get_Acc_Percentile( speed_acc_list,90 ); % 90% percentile

% road load from accelration
[ torq_at_wheel ] = Torq_at_Wheel( va_max,v_mph,VEH_M,VEH_Cr,VEH_Cdl,VEH_Rw );

end

