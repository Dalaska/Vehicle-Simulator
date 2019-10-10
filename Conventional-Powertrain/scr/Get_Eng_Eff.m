function [ eng_eff_mean ] = Get_Eng_Eff( ENG_t,ENG_w,speed,ICE )
%==========================================================================
% Objective: caculate average engine efficiency 
% Input: engine torque, engine speed, engine model
% Output: average engine efficiency
%==========================================================================

rad2rpm = 9.5490; % convert rad/s to rpm
eng_eff = zeros(length(ENG_w),1); % inicalize

for n=1:length(ENG_w)
    eng_eff(n) = interp2(ICE.map_w*rad2rpm,ICE.map_T,ICE.map_eff',ENG_w(n),ENG_t(n));
    % unit is liter per second
    if isnan(eng_eff(n))
        eng_eff(n) = 0;
    end
end

% select data that are not idling
idx = speed> 0.5;
eng_eff = eng_eff(idx);

% average engine efficiency
eng_eff_mean = mean(eng_eff);

end
