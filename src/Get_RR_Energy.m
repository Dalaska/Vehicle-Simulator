function E_rr = Get_RR_Energy(speed,time,VEH_M,VEH_Cr)
%==========================================================================
% Objective: caculate the energy consumed by rolling resistance
% Input: vehicle speed, time, mass, rolling resistance coefficient
% Output: energy consumed by rolling resistance
%==========================================================================

distance = trapz(time,speed);% trip distance meter
F_rr = VEH_M*9.81*VEH_Cr; % Rolling resistance force
E_rr = distance*F_rr ; % Energy consumed by rolling resistance

end