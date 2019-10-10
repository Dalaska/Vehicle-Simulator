function [ trq_flat ] = Flat_Mat( trq_mat,bin_v,bin_a )
%==========================================================================
%  Objective: flatten the maxtrix
%  Input:   trq_mat
%           speed bin
%           acceleration bin
%  Output: the flaten matrix
%==========================================================================


n_v = size(trq_mat,1); % number of speed 
n_a = size(trq_mat,2); % number of acceleration
trq_flat = zeros(n_v*n_a,3); % inicilize the flatterned matrix

p = 1;
for m = 1:n_v
    for n = 1:n_a  
        trq_flat(p,1) = (bin_v(m)+bin_v(m+1))/2; % find the middle point
        trq_flat(p,2) = (bin_a(n)+bin_a(n+1))/2;
        trq_flat(p,3) =  trq_mat(m,n);
        p = p+1;
    end
end

end

