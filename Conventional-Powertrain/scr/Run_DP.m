% run DP

speed_mps = stream(:,2);
acceleration_smooth = stream(:,3);

% caculated traction
[ trq_wheel ] = DP_get_traction_torq( speed_mps, acceleration_smooth );

% efficiency
trq_wheel = trq_wheel/0.95; % efficiency

w = 1; 
[ gear_dp, J ] = DP_get_shift2(speed_mps, trq_wheel, w);

% simulation

% driver score
[ microtrip_score ] = OnlineDriverScore2( stream );

% load shift line
shift_up = SL(n_shift_map,:);
shift_down = SD(n_shift_map,:);
ShiftUp = reshape(shift_up, [5,17]);
ShiftDown = reshape(shift_down, [6,17]);

% load driving data
CYC_t = stream(:,1);
CYC_v =  stream(:,2); %cylce_combined(:,2)*0.44704;% speed mph to mps (need smoothing) lwr;

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

%sim('Main0_Sim_3_SpeedTransMap_HasDistFB2')
%sim('Main0_Sim_3_SpeedTransMap_NoDistFB3_forDP')
sim('Main0_Sim_3_SpeedTransMap_HasDistFB3_forDP')

% fuel economy
[ ENG_t2 ] = Modify_Torq( ENG_t,ENG_w,VEH_v,DR_acc);
[ ENG_fuel ] = Lookup_Fuel( ENG_w,ENG_t,VEH_v,DR_acc,ICE );
[ MPG_SIM,MPG_CYC,error ] = Get_MPG( CYC_t,CYC_v,CYC_fuel,VEH_v,ENG_fuel); % get mpg
 
% Drivability
LSM = Drivability(VEH_v,DR_cyc);           

% results
% figure()
% hold on
% plot(CYC_t, CYC_v)
% plot(VEH_v.time,VEH_v.data)
% plot(TRAN_gear_OL*4)

MPG_SIM
LSM
