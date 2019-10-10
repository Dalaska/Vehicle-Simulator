function [ SL,SD ] = Make_Up_Down_Shift_Map( v_max_mps,v_min_mps,grid_v,grid_trq,grid_rsv_1d,v_down_min_mps,v_down_max )
%==========================================================================
%  Objective: generate up shifting and down shifting map
%  Input: the maxium and minimum speed for the upshifting and downshifting
%  gear, the grid of torque reserves
%  Output: flatterned upshifting and downshifting map
%==========================================================================

SL = []; % a list of up shifting map
SD = []; % down shifting map
nn = size(v_max_mps,1);
for n = 1:nn
    v_max_mps_n = v_max_mps(n,:);
    grid_rsv_n = reshape(grid_rsv_1d(n,:),[15,20]);
    v_down_max_n = v_down_max(n,:);
    
    [ SL1 ] = Make_Up_Shift( v_max_mps_n,v_min_mps,grid_v,grid_trq,grid_rsv_n );
    [ SD1 ] = Make_Down_Shift( v_down_min_mps,v_down_max_n );
    
    % reshape it to save in 2d
    len = size(SL1,1)*size(SL1,2);
    len_d = size(SD1,1)*size(SD1,2);
    
    SL1_flat = reshape(SL1,[1,len]); % flattern the map to store it in a table
    SD1_flat = reshape(SD1,[1,len_d]);
    
    SL = [SL;SL1_flat]; % log up shifting map
    SD = [SD;SD1_flat]; % log down shifting map
end

end

