function [ E_f ] = Get_Fuel_Energy(fuel_rate, time )
%==========================================================================
% Objective: caculate the energy in total fuel consumption
% Input: fuel rate, time
% Output: energy in fuel
%==========================================================================

fuel = trapz(time,fuel_rate/3600); % fuel in Liter

% total energy from fuel
E_f = 35.8*fuel*1000000; % total engery in J

end