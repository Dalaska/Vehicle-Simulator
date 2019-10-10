function [ Trq_id ] = Trq_Mat3( TM,rate,bin_tx )
%==========================================================================
% Objective:  
% Input: transition matrix, the percentage needed to satify, the bin for
% toque at the next moment
% Output: the index of the bin that satify the percentage
%==========================================================================

n_v = size(TM,1); % speed bin
n_a = size(TM,2); % acceleration bin
n_xa = size(TM,3); % accleration at the next moment

% inicialize
Trq_id = zeros(n_v,n_a); % satisfcation matrix
for m = 1:n_v
    for n = 1:n_a
        v_id = reshape(TM(m,n,:),1,n_xa); % slice on v and trq
        
        n_total = sum(v_id);
        n_sat = floor(n_total*rate); % reach satisfy rate
        
        if n_sat > 0 % assertion if its empty
            n_ct = 0; % start counting
            for k = 1:n_xa
                n_ct = n_ct + v_id(k);
                if n_ct > n_sat
                    break;
                end
            end
            Trq_id(m,n) = k;
        else
            Trq_id(m,n) = -1; % mark as a special case / the cell is empty
        end
    end
end

% find the torque value from the id of the bins
[ trq_mat ] = Interpolate_Trq( Trq_id,bin_tx ); 

end

