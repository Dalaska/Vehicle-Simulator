function [ gear_eff ] = Gear_Efficiency( ENG_w,ENG_t2,TRAN_gear,ICE )
%==========================================================================
%  Objective: caculate the average engine efficiency for each gear
%  Input: engine speed, engine torque, transmission gar, ICE engine
%  Output: average efficiency at each gear
%==========================================================================

rad2rpm = 9.55;
eng_w = ENG_w.data;

eng_eff = zeros(length(eng_w),2); % inicialize
eng_t = ENG_t2.data;
tran_gear = TRAN_gear.data;

for i=1:length(eng_w)
    % find engine efficincy from map
    eng_eff(i,1) = interp2(ICE.map_w*rad2rpm,ICE.map_T,ICE.map_eff',eng_w(i),eng_t(i));
    % unit is liter per second
    if isnan(eng_eff(i,1))
        eng_eff(i,2) = 0;
    end
    eng_eff(i,2) = tran_gear(i);
end

% select the efficency at each gear 
g2 = eng_eff((eng_eff(:,2) ==2)&(eng_eff(:,1) >0),1);
g3 = eng_eff((eng_eff(:,2) ==3)&(eng_eff(:,1) >0),1);
g4 = eng_eff((eng_eff(:,2) ==4)&(eng_eff(:,1) >0),1);
g5 = eng_eff((eng_eff(:,2) ==5)&(eng_eff(:,1) >0),1);
g6 = eng_eff((eng_eff(:,2) ==6)&(eng_eff(:,1) >0),1);

% caculate the avergy gear efficincy
gear_eff = [mean(g2),mean(g3),mean(g4),mean(g5),mean(g6)];

end

