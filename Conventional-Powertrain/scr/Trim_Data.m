function [ v_mps,trq_nm,rsv ] = Trim_Data( trq_flat)
%==========================================================================
%  Objective: select the valid data, only bins that has data
%  Input: flatterned torque reserve data
%  Output: vehicle speed, vehicle torque, and torque reserve
%==========================================================================

% only select one has data, value >-1
trq_flat = trq_flat(trq_flat(:,3)>-0.5,:);

v_mps = trq_flat(:,1); % speed in mps
trq_nm = trq_flat(:,2); % trque in Nm
rsv = trq_flat(:,3); %  torque reserve

end

