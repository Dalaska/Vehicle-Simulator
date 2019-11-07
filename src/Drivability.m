function LSM = Drivability( VEH_v,DR_cyc )
%==========================================================================
% Objective: caculate the drivability metric
% Input: vehicle speed from simualation, vehicle speed from cycle
% Output: drivability metric
%==========================================================================

% select accelerating 
CYC_acc = diff(DR_cyc.data);
CYC_acc_smooth = smooth(CYC_acc,0.005); 

CYC_v_smooth = smooth(DR_cyc.time, DR_cyc.data); % smooth speed

% select accelerating events
acc_threshold = 0.02;
CYC_idx = (CYC_acc_smooth > acc_threshold);
CYC_v_select = CYC_v_smooth(CYC_idx);
VEH_v_select = VEH_v.data(CYC_idx);

% caculate the least mean square error of the desired and actual speed profile
LSM = sqrt(sum((max(CYC_v_select - VEH_v_select,0)).^2)/length(CYC_v_select));
end