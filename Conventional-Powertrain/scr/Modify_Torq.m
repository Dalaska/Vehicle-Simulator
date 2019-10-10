function [ ENG_t ] = Modify_Torq( ENG_t,ENG_w,VEH_v,DR_acc)
%==========================================================================
%  Objective: modify engine torque when coasting and idling
%  input: engine torque, engine speed, vehicle speed, accleration peddle
%  output: modified engine torque
%==========================================================================

ENG_t2 =ENG_t.data;
for n =1:length(ENG_t2)
    % coasting
    if (ENG_t2(n) < 1) && (ENG_w.data(n)>750) % coasting criteria
        ENG_t2(n) = -0.02802*ENG_w.data(n) -27.54; % linear
    end
    
    % idling
    if (VEH_v.data(n)<0.5)
        ENG_t2(n) = 95;
    end
end
ENG_t.data = ENG_t2;
end

