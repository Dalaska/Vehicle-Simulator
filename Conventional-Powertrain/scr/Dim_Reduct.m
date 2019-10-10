function [ x_redued,explained,pc_cof ] = Dim_Reduct( x_sub )
%==========================================================================
%  Objective: reduce feature dimension
%  input: vector subtracted the mean
%  output: vector reduced dimension, variance explain ratio, principle component
%==========================================================================

% Calculate the pca coefficent
coeff = pca(x_sub); 
[COEFF,latent,explained] = pcacov(x_sub); 
pc_cof = COEFF(:,1); % principle component coefficient
x_redued = x_sub*pc_cof; % reduced dimension

end

