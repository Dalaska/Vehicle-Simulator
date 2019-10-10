
%driving_cycle = ['cycle_a';'cycle_m';'cycle_g'];
%driving_cycle = ['cycle_a';'cycle_a';'cycle_a'];
%shift_maps = [1,3,6]; % [1,3,6] 1 is most relaxed, 6 is the most aggressive

n_trip = size(driving_cycle,1);
% inicilize, all the info you care
all_lsm = zeros(1,n_trip);
all_mpg = zeros(1,n_trip);

for n = 1:n_trip
    
    % load driving data
    load(driving_cycle(n,:));
    [ CYC_t,CYC_v,CYC_grade,CYC_gear,CYC_trq,CYC_fuel,CYC_w ] = Load_Trip3( stream );
    
    % driver score
    [ microtrip_score ] = OnlineDriverScore2( stream );
    
    % load shift maps
    n_shift_map = shift_maps(n); % 1 is most agressive, 6 is the most relaxed
    
    shift_up = SL(n_shift_map,:);
    shift_down = SD(n_shift_map,:);
    ShiftUp = reshape(shift_up, [5,17]);
    ShiftDown = reshape(shift_down, [6,17]);
    
    
    % Run simulation
    run('Load_Parameters2.m') % inicialize parameters
    run('Load_Sim_Parameters2.m')
    
    DR_P = 5; % Driver PID: P
    DR_I = 0.009; % Driver PID: I
    DR_FF = 0.9; % Driver feed forward gain
    DR_LP = 0.995; % % Driver low pass filter
    VEH_M2 = 8700; % vehicle mass

    sim('Main0_Sim_3_SpeedTransMap_HasDistFB2')
    
    % fuel economy
    [ ENG_t2 ] = Modify_Torq( ENG_t,ENG_w,VEH_v,DR_acc);
    [ ENG_fuel ] = Lookup_Fuel( ENG_w,ENG_t,VEH_v,DR_acc,ICE );
    [ MPG_SIM,MPG_CYC,error ] = Get_MPG( CYC_t,CYC_v,CYC_fuel,VEH_v,ENG_fuel); % get mpg
    
    % Drivability
    LSM = Drivability(VEH_v,DR_cyc);
    
    all_lsm(n) = LSM;
    all_mpg(n) = MPG_SIM;
    
    % log speed and gear
    if n==1
        CYC_t1 = CYC_t; CYC_v1 = CYC_v; VEH_v1 = VEH_v;
        gear1 = TRAN_gear_OL;
    else if n==2
            CYC_t2 = CYC_t; CYC_v2 = CYC_v; VEH_v2 = VEH_v;
            gear2 = TRAN_gear_OL;
        else if n==3
                CYC_t3 = CYC_t; CYC_v3 = CYC_v; VEH_v3 = VEH_v;
                gear3 = TRAN_gear_OL;
            end
        end
    end  
    
end

%visualize
% figure()
% hold on
% plot( CYC_t, CYC_v,'LineWidth',1)
% %plot( VEH_v,'LineWidth',1)
% plot(VEH_v1)
% plot(VEH_v2)
% plot(VEH_v3)
% legend('target','1','3','6')

