function [ shift_line,VEH_v_mps] = Shift_by_Gear(k,v_min_mps,v_max_mps,grid_v,grid_trq,grid_rsv)
%==========================================================================
% Objective: generate shift map by each gear
% Input: the gear number, the minium and maxium speed for each gear, the
% grid of torque reserve
% Output: the shift line, the speed response to the shift line
%==========================================================================
run('Load_Veh_Parameters.m') % inicialize parameters

n_v = 30; % granity of speed
VEH_v_mps  = linspace(v_min_mps,v_max_mps,n_v); % mile per hour

n_trq = 35;
thrt = linspace(0.01,1,n_trq);

% inicalize
shift_line = ones(size(VEH_v_mps))*10;

%shiftline each gear

for n1 = 1:n_v % speed sweep
    n = n_v - n1+1;
    for m1 = 1:n_trq % torque sweep
        m = n_trq - m1 +1;
        % current gear
        cur_ratio = TRAN_ratio_gear(k)* TRAN_ratio_diff;
        cur_w_rads = (VEH_v_mps(n)/VEH_Rw)*cur_ratio;
        cur_w_rpm = cur_w_rads*rad2rpm;
        cur_eg_max_trq = interp1(ICE.maxT_w,ICE.maxT_T,cur_w_rads); % engine max torq
        cur_eg_trq = cur_eg_max_trq*thrt(m);
        cur_veh_torq =  cur_eg_trq * cur_ratio;
        cur_fuel = interp2(ICE.map_T, ICE.map_w, ICE.map_m_dot, cur_eg_trq, cur_w_rads);
        
        
        % next gear
        nx_w_rads = (VEH_v_mps(n)/VEH_Rw)*TRAN_ratio_gear(k+1)* TRAN_ratio_diff;
        nx_w_rpm = nx_w_rads*rad2rpm;
        nx_eg_trq = cur_eg_trq*TRAN_ratio_gear(k)/TRAN_ratio_gear(k+1);
        nx_eg_max_trq = interp1(ICE.maxT_w,ICE.maxT_T,nx_w_rads);
        nx_fuel = interp2(ICE.map_T, ICE.map_w, ICE.map_m_dot, nx_eg_trq, nx_w_rads);
        
        %% assertion
        if isnan(nx_fuel)
            nx_fuel = 9999;
        end
        %%
        cur_veh_torq = min(max(grid_trq),cur_veh_torq); % assertion
        trq_rev  = interp2(grid_v,grid_trq,grid_rsv,VEH_v_mps(n),cur_veh_torq);
        
        %%
        nx_req_trq = nx_eg_trq + trq_rev; % next required torque
        if  (nx_eg_max_trq > nx_req_trq) && (nx_fuel < cur_fuel)
            shift_line(n) = thrt(m);
            break;
        end
        
    end
end
shift_line = [0,shift_line,1];
VEH_v_mps = [min(VEH_v_mps),VEH_v_mps,max(VEH_v_mps)];
end

