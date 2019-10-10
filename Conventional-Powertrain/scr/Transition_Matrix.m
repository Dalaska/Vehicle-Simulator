function [ tran_mat ] = Transition_Matrix2( bin_v,bin_t,bin_tx, V1,T1,TR1 )
%==========================================================================
%  Objective: obtain the state transition matrix for the makrov model
%  Input: bin for vehicle speed, bin for current torque, bin for torque in
%  the next moment, vehicle speed, current torque, next torque
%  Output: state transition matrix
%==========================================================================

% the size of bins
n_v = length(bin_v)-1; % the bunary -1
n_t = length(bin_t)-1;
n_tx = length(bin_tx)-1;

% assertion
[ V1 ] = Assertion( V1,bin_v );
[ T1 ] = Assertion( T1,bin_t );
[ TR1 ] = Assertion( TR1,bin_tx );

[ bn_v  ] = Find_bin2( V1,bin_v ); % bin number v
[ bn_t  ] = Find_bin2( T1,bin_t );
[ bn_tx ] = Find_bin2( TR1,bin_tx );

% inicialize
tran_mat = zeros(n_v,n_t,n_tx);
t_end = size(V1,1);

% put into bins
for t=1:t_end-1
    
    % put into bins
    tran_mat(bn_v(t),bn_t(t),bn_tx(t)) = tran_mat(bn_v(t),bn_t(t),bn_tx(t))+1;
    
end


end

