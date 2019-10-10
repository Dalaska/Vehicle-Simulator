%==========================================================================
%  Objective: evaluate the vehicle acceleration performance in the simulation 
%==========================================================================

% Inicliaze
V060 = []; % vehicle speed
T060 =[]; % time
Trq = []; % torque
G =[];
WOT =1; % wide open throttle

% est speed profile
CYC_t = 1:100;
CYC_v = ones(size(CYC_t))*100;
CYC_grade =zeros(size(CYC_t));
CYC_gear =zeros(size(CYC_t));
Stoptime = 100; % simulation stop time

num_maps = size(SL,1); % number of maps
for n = 1:num_maps
    % load shift line
    shift_up = SL(n,:);
    shift_down = SD(n,:);
    ShiftUp = reshape(shift_up, [5,17]);
    ShiftDown = reshape(shift_down, [6,17]);
    
    run('Load_Veh_Parameters.m') % Load vehicle parameters
    run('Load_Sim_Parameters.m') % Load simulation parameters
    sim('Main0_Sim_3_SpeedTransMap_NoDistFB')
    
    V060 = [V060,VEH_v.data]; % log vehicle speed 
    T060 = [T060,VEH_v.time]; % log time step
end

% plot speed trace
Plot_Acc_Speed(V060,T060,num_maps )


