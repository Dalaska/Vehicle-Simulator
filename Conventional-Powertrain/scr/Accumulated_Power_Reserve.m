function[ average_accumulated_reserve ] = Accumulated_Power_Reserve( ENG_Max_t,ENG_t2,ENG_w,DR_dist )
%==========================================================================
% Objective: caculate the accumulated power reserve
% input: maxium engine torque available, engine torque, engine speed, trip
% distance
% output: average accumulated power reserve
%==========================================================================

% Accumulated power reserve
rad2rpm = 9.55;
eng_Max_t = ENG_Max_t.data;
eng_t = ENG_t2.data;
eng_w = ENG_w.data/rad2rpm;
time = ENG_w.time;
dr_dist = DR_dist.data(end); % trip distance

power_reserve = (eng_Max_t - eng_t).*eng_w; % power reserve
% caculate accumulated power reserve
accumulated_power_reserve = trapz(time,power_reserve); 
%  accumulated power reserve per distance
average_accumulated_reserve = accumulated_power_reserve/dr_dist/1000; 

end

