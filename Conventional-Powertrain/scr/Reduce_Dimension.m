function [ x_1d ] = Reduce_Dimension( x )
%==========================================================================
%  Objective: dimension reduction using PCA
%  Input: orignal vector
%  Output: reduced dimension to 1d
%==========================================================================

x_mean = mean(x); % cacualte the mean

[ x_submean ] = Sub_Mean( x,x_mean ); % subtract the mean

[ x_reduced,explained,pc_cof_tmax ] = Dim_Reduct( x_submean ); % reduce dimension

% new vector demsion reduced to 1d
x_1d = (x_reduced - min(x_reduced))/(max(x_reduced)-min(x_reduced));

end

