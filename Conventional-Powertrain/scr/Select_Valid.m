function [ v,trq,trq_next ] = Select_Valid( v,trq,trq_next )
%==========================================================================
% Objective: filter the current torque demand < 0
% Input: speed, current torque, torque at the next moment
% Output: filtered data
%==========================================================================

v_trq_trqx =[v,trq,trq_next]; % speed, current torque, torque at the next moment

% filter, current torque demand need to be greater than 0
v_trq_trqx = v_trq_trqx(v_trq_trqx(:,2)>0,:);

% get each compoment
v = v_trq_trqx(:,1);
trq = v_trq_trqx(:,2);
trq_next = v_trq_trqx(:,3);

end

