function [ trq_mat ] = Interpolate_Trq( trq_mat,bin_tx )
%==========================================================================
% Objective: lookup torque from a 2d map
% Input: torque map, bin of the torque at the next moment
% Output: the new torque map 
%==========================================================================

% inicialize 
n_v = size(trq_mat,1); % number of bins for speed
n_a = size(trq_mat,2); % number of bins for acceleration 
n_xa = size(bin_tx,2); % number of bins for acceleration at the next moment

% get trq from bin number
x = 1:n_xa;

for m = 1:n_v
    for n = 1:n_a
        if  trq_mat(m,n) == -1
            ; % do nothing
        else
            if size(x) == size(bin_tx)
                k = trq_mat(m,n)+1; % upper limit
                trq_mat(m,n) = interp1(x,bin_tx,k);
            else
                'WRONG'
            end
        end
    end
end
end

