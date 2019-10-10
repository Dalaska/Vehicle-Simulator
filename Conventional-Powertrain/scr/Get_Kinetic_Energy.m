function [ E_k ] = Get_Kinetic_Energy2(speed, time,VEH_M )
%==========================================================================
% Objective: caculate the kinetic engergy consumption
% Input: vehicle speed, time, vehicle mass
% Output: kinetic engergy
%==========================================================================

E_k = 0; % inicalize 
for n=2:length(time)
    % accumulate kinetic energy when vehicle speed increase
    if speed(n)<speed(n-1)
        E_k = E_k + 0.5*VEH_M*(speed(n-1)^2 - speed(n)^2) ;
    else
        E_k =E_k;
    end
end

end

