function [ grid_rsv,grid_v,grid_trq ] = Smooth_Matrix( trq_mat,bin_v,bin_t )
%==========================================================================
%  Objective: smooth the matrix
%  Input: the maxtrix, speed bin, torque bin
%  Output: grid of torque reserve, speed, and torque
%==========================================================================

% get torq resv matrix
[ trq_flat ] = Flat_Mat( trq_mat,bin_v,bin_t );

% filter the negative value
trq_flat = trq_flat(trq_flat(:,3)>-0.5,:);

% select the valid data
[ v_mps,trq_nm,rsv  ] = Trim_Data( trq_flat );

%grid fit
[grid_rsv,grid_v,grid_trq] = gridfit(v_mps,trq_nm,rsv,20,15);
min_rev = 20;
grid_rsv = max(grid_rsv,min_rev);


end

