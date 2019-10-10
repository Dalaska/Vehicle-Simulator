function [ ENG_fuel ] = Lookup_Fuel( ENG_w,ENG_t,VEH_v,DR_acc,ICE )
%==========================================================================
% Objective: lookup fuel consumptions
% Input: engine speed, engine torque, vheicle speed, engine fule map
% Output: engine fuel rate
%==========================================================================

ENG_t_d = ENG_t.data;
ENG_w_d = ENG_w.data;
rad2rpm = 9.5490;

SIM_fule = zeros(length(ENG_w_d),1); % incialize fuel rate

for n=1:length(ENG_w_d)
    SIM_fule(n) = 3600*interp2(ICE.map_w*rad2rpm,ICE.map_T,ICE.map_m_dot',ENG_w_d(n),ENG_t_d(n));
    % unit is liter per second
    if isnan(SIM_fule(n))
        SIM_fule(n) = 0;
    end
end

% modification fuel rate if coasting or idling
for n=1:length(ENG_t_d)
    % coasting and braking
    if (ENG_t_d(n) < 1) && (ENG_w_d(n)>750)
        SIM_fule(n) = 0;
    end
    
    % idling
    if (VEH_v.data(n)<0.5)
        SIM_fule(n) = 2.4;
    end
end

% smooth the fuel rate
fuel_time  = ENG_w.time;
SIM_fule = smooth(fuel_time,SIM_fule,0.005,'loess');

ENG_fuel = ENG_w;
ENG_fuel.data = SIM_fule;
ENG_fuel.time = ENG_w.time;


end

