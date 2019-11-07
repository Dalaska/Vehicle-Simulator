function [ grid_v,grid_trq,grid_rsv_1d ] = Make_Grid_Trq(trq_reserve,k)
%==========================================================================
%  Objective: visualize the upshift map
%  Input: torque reserve, number of shift maps
%  Output: the grid for speed, torque, and torque reserve
%==========================================================================

bin_v = linspace(-0.01,28,10);
bin_t =  linspace(-0.01,6000,6); % min at -1.5, #6
grid_rsv_1d = zeros(k,300);

for n = 1:k % loop through every shift map
    trq_mat_2 = reshape(trq_reserve(n,:),[9,5]);
    % smooth the torque reserve matrix
    [ grid_rsv,grid_v,grid_trq ] = Smooth_Matrix( trq_mat_2,bin_v,bin_t );
    grid_rsv_1d(n,:) = reshape(grid_rsv,[1,300]);
end

grid_v = grid_v(1,:);
grid_trq = grid_trq(:,1);

end

