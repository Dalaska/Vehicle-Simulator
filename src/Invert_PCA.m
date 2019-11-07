function [ x_reconstruct ] = Invert_PCA( x_pc,pc_cof,x_submean )
%==========================================================================
%  Objective: Inverted PCA
%  Input: the value after dimension reduction, principle component
%  coeffieient, the value subtracted by the mean
%  Output: the reconstructed valued
%==========================================================================

for n = 1:size(x_pc,2)
    x_reconstruct(n,:) = x_pc(n)*(pc_cof)'+x_submean; % reconstruction
end

end

