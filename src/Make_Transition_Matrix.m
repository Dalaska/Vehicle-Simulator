function [ tran_mat ] = Make_Transition_Matrix( CYC_v, bin_v, bin_t,bin_tx,next_n_sec )
%==========================================================================
% Objective: generate state transition matrix for the markov model 
% Input: speed profile, bin for vehicle speed, bins for current torque,
% bins torque in the next n seconds, the next n seconds
% Output: state transiion matrix
%==========================================================================
run('Load_Veh_Parameters.m') % load vehicle parameters

% inicalize
V = []; % vehicle speed
T =[]; % current torque 
TX = []; % torque in the next n second

% smooth the speed profile
[ CYC_v_smth,CYC_acc ] = Smooth_Cyc( CYC_v, 0.005 );


%% next n sec
next_n_sec = 10; % 1 sec
[ v,a,ax ] = Get_Next_Acc( CYC_v_smth,CYC_acc,next_n_sec );

% convert accelertion to troq at wheel
[ t,tx ] = Acc_2_Torq( v,a,ax,VEH_M,VEH_Cr,VEH_Cdl,VEH_Rw);

% save to long list
V = [V;v]; % vehicle speed
T =[T;t]; % current torque
TX = [TX;tx]; % torque in the next n second

TR = TX - T;
TR = max(1,TR); % minal torq 1

% do selection here
[ V1,T1,TR1 ] = Select_Valid( V,T,TR );
[ V2,T2,TX2 ] = Select_Valid( V,T,TX );

% get transition matrix (list)
% make transition matrx
[ tran_mat ] = Transition_Matrix2( bin_v,bin_t,bin_tx, V1,T1,TR1 );



end

