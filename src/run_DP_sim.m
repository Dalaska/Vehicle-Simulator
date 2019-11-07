mph2mps = 0.44704; % unit conversion
load('D_shifts'); % load shift maps
w = 1; % weight for shifting
n_trip = size(driving_cycle,1);
% inicilize, all the info you care
all_lsm = zeros(1,n_trip);
all_mpg = zeros(1,n_trip);

for n = 1:1
    load(driving_cycle(n,:));
    %down sample
    ds_rate = 10;
    stream = downsample(stream,ds_rate); 
      
    speed_mps = stream(:,2)*mph2mps;
    acceleration_smooth = stream(:,3);
    
    % caculated traction
    [ trq_wheel ] = DP_get_traction_torq( speed_mps, acceleration_smooth );
    
    % efficiency
    trq_wheel = trq_wheel/0.95; % efficiency
    
    
    [ gear_dp, J ] = DP_get_shift2(speed_mps, trq_wheel, w);
    
    % simulation
    
    % driver score
    [ microtrip_score ] = OnlineDriverScore2( stream );
    
    n_shift_map = 1;
    % load shift line
    shift_up = SL(n_shift_map,:);
    shift_down = SD(n_shift_map,:);
    ShiftUp = reshape(shift_up, [5,17]);
    ShiftDown = reshape(shift_down, [6,17]);
    
    % load driving data
    CYC_t = stream(:,1);
    CYC_v =  stream(:,2)*mph2mps; %cylce_combined(:,2)*0.44704;% speed mph to mps (need smoothing) lwr;
    
    % place holder
    CYC_grade = zeros(size(CYC_t));
    CYC_trq = zeros(size(CYC_t));
    CYC_fuel = zeros(size(CYC_t));
    CYC_w = zeros(size(CYC_t));
    
    % Run simulation
    run('Load_Parameters2.m') % inicialize parameters
    run('Load_Sim_Parameters2.m')
    
    %============ use dp ==============
    Enable_Shift = 0;
    %CYC_gear = gear_cycle; % gear_dp;
    CYC_gear = gear_dp;
    %==================================
    
    DR_P = 5; % Driver PID: P
    DR_I = 0.009; % Driver PID: I
    DR_FF = 0.9; % Driver feed forward gain
    DR_LP = 0.995; % % Driver low pass filter
    VEH_M2 = 8700; % vehicle mass
    %sim('Main0_Sim_3_SpeedTransMap_HasDistFB2')
    %sim('Main0_Sim_3_SpeedTransMap_NoDistFB3_forDP')
    sim('Main0_Sim_3_SpeedTransMap_HasDistFB3_forDP')
    
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
        gear1 = TRAN_gear;
    else if n==2
            CYC_t2 = CYC_t; CYC_v2 = CYC_v; VEH_v2 = VEH_v;
            gear2 = TRAN_gear;
        else if n==3
                CYC_t3 = CYC_t; CYC_v3 = CYC_v; VEH_v3 = VEH_v;
                gear3 = TRAN_gear;
            end
        end
    end  
     
end