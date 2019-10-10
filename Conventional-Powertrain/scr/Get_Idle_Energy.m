function  E_i  = Get_Idle_Energy(speed, fuel_rate, time )
%==========================================================================
%  Objective: caculate the energy consumption during idling
%  Input: vehicle speed, fuel rate, time
%  Output: energy consumption during idling
%==========================================================================

% selecting the idling event
idle_idx = speed < 0.5;
time_idle = time(idle_idx);
fuel_idle = fuel_rate(idle_idx);
fuel_idle = max(2.6,fuel_idle);

time_dif = diff(time_idle);
time_dif = min(time_dif,0.98);

time_cum = [0;cumsum(time_dif)];

fuel_liter = trapz(time_cum,fuel_idle/3600); % fuel Liter
E_i = 35.8*fuel_liter*1000000; % total engery in J

end