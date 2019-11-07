function [ t,tx ] = Acc_2_Torq( v,a,ax,VEH_M,VEH_Cr,VEH_Cdl,VEH_Rw)
%==========================================================================
%  Objective: caculate torque at wheel from acceleration
%  Input: vehicle speed, current acceleration 
%  Output: current torque, torque at the next moment
%==========================================================================

% Inicilzie
len = length(v);
t = zeros(len,1);
tx = zeros(len,1);

g = 9.81;
Fr = VEH_M*g*VEH_Cr; % rolling resist

for n = 1: len
    Fad = VEH_Cdl * v(n)^2; % aerodynamic drag
    t(n) = (Fr + Fad + VEH_M*a(n))*VEH_Rw; % current torque 
    tx(n) = (Fr + Fad + VEH_M*ax(n))*VEH_Rw; % current torque at the next moment
end

end

