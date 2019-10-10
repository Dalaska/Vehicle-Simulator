function [ torq_at_wheel ] = Torq_at_Wheel( va_max,v_mph,VEH_M,VEH_Cr,VEH_Cdl,VEH_Rw )
%==========================================================================
%  Objective: convert vehicle acceleration to torque
%  Input: maximum acceleration at each speed, vehicle speed, vehicle mass 
%  and other vehicle parameters
%  Output: the torque at wheel
%==========================================================================

g = 9.81;
mps2mph = 2.2369; % meter per second to mile per hour

v_mph = (1:25)*mps2mph;

% a function, road load from accelration
Fr = VEH_M*g*VEH_Cr;
Fad = zeros( size( v_mph));
for m = 1:size(v_mph,2)
    v_mps = v_mph(m)/mps2mph;
    Fad(m) = VEH_Cdl*v_mps^2+Fr;
end
Frl= Fad + Fr; % road load
Fa = va_max*VEH_M; % initial force

torq_at_wheel = (Frl+Fa')*VEH_Rw; % caculate torque at wheel

end

