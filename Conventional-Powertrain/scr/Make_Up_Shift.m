function [ ShiftUp ] = Make_Up_Shift( v_max_mps,v_min_mps,grid_v,grid_trq,grid_rsv )
%==========================================================================
% Objective: generate the up shifting map
% Input: the maxium and minimun speed for each gear, the grid of the 
% torque reserve 
% Output: the upshifting line
%==========================================================================

SL = []; % inicialize the upshifting line
V =[]; 
for n =1:5
    [ shift_line,VEH_v_mps ] = Shift_by_Gear(n,v_min_mps(n),v_max_mps(n),grid_v,grid_trq,grid_rsv);
    SL = [SL;shift_line];
    V = [V;VEH_v_mps];
end

[ SL ] = Mono_Decrease( SL ); % make sure the shift line is monotonical descreasing

ShiftUp = zeros(5,17);
ENG_torq = linspace(0,1,17);  % inicialize engine torque

dummy = linspace(0,0.1,32);
for n = 1:5 % gear
    for m = 1:17 % torque
        ShiftUp(n,m) = interp1(SL(n,:) + dummy,V(n,:),ENG_torq(m));
    end
end

%%
for n =2:5
    for m =1:17
        ShiftUp(n,m) = max(ShiftUp(n,m),ShiftUp(n-1,m)+1.5);
    end
end



end

