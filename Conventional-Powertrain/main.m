%==========================================================================
%                     Power Train Simulation
%                           Jan 12 2017
% 1. Evaluate the accelerating performance of the shift maps from different
% driver score.
% 2. Evaluate the impact of fuel economy and drivability in simulation
% using the speed profile an aggressive, medium, and relaxed driving cycle.
%==========================================================================
clc
clear all
close all

load('D_shifts') % load shift maps

% evaluate 0-60 acceleration time
run('Acceleration_Test.m')

%% fuel economy
% Inicializate
mpg = zeros(6,3);
lms = zeros(6,3);
driver_score = linspace(1,0,6);

V_mph =[];
GEAR =[];
counter = 0;

for x = 1:3 % loop through 3 drive cycles
    % choose situation 1 relaxed, 2 aggressive
    switch x
        case 1
            trip_log = [1,8700,0,9,1];  %  0.19
        case 2
            trip_log = [1,8700,0,1,2];  %  0.51
        case 3
            trip_log = [1,8700,1,1,3];  %  0.89
    end
    
    % track simulation results
    INFO = []; % trip results
    INFO_Gear = [];
    INFO_meta = []; % meta trip data
    indx = 0; % simulation indx
    
    
    % inicialize vehicle parameters
    run('Load_Parameters2.m')
    
    % load trip data
    [ CYC_t,CYC_v,CYC_grade,CYC_gear,CYC_trq,CYC_fuel,CYC_w ] = Load_TripS( 1,trip_log );
    
    CYC_v = smooth(CYC_v,0.005 );
    for n_shift_map = 1:6 % loop through shift maps
        n_shift_map
        counter = counter+1;
        
        % load shift line
        shift_up = SL(n_shift_map,:);
        shift_down = SD(n_shift_map,:);
        ShiftUp = reshape(shift_up, [5,17]);
        ShiftDown = reshape(shift_down, [6,17]);
        
        % Run simulation
        run('Load_Parameters2.m') % inicialize parameters
        run('Load_Sim_Parameters2.m')
        
        VEH_M2 =8700;
        sim('Main0_Sim_3_SpeedTransMap_HasDistFB2')
        %sim('Main0_Sim_3_SpeedTransMap_HasDistFB')
        
        %% Get engine fuel rate
        [ ENG_t2 ] = Modify_Torq( ENG_t,ENG_w,VEH_v,DR_acc);
        [ ENG_fuel ] = Lookup_Fuel( ENG_w,ENG_t,VEH_v,DR_acc,ICE );
        [ MPG_SIM,MPG_CYC,error ] = Get_MPG( CYC_t,CYC_v,CYC_fuel,VEH_v,ENG_fuel); % get mpg
        
        %% Drivability
        LSM = Drivability(VEH_v,DR_cyc);
        
        dr_dist = DR_dist.data(end);
        
        % new drivability % sum of power reserve
        [ AAPR ] = Accumulated_Power_Reserve( ENG_Max_t,ENG_t2,ENG_w,DR_dist );
        
        % gear eff, every engine eff
        [ gear_eff ] = Gear_Efficiency( ENG_w,ENG_t2,TRAN_gear,ICE );
        
        %% Energy Audit
        [ E_k,E_f,E_i,E_rr,E_ad,Enge_ef,E_kref ] = Energy_Audit( VEH_v,VEH_M,ENG_fuel,VEH_Cr,VEH_Cdl,ENG_t2,ENG_w,ICE,CYC_v,CYC_t );
        
        %% Log resutls
        indx = indx + 1;
        info = [indx,MPG_SIM,E_k,E_f,E_i,E_rr,E_ad,Enge_ef,LSM,AAPR,dr_dist];
        INFO = [INFO;info];
        INFO_Gear = [INFO_Gear;gear_eff]; % meta data, just to keep track
        
        if x == 1
            % log speed
            if counter == 1
                nm = length(VEH_v.time);
                T_time = VEH_v.time;
               CYC_t_1 = CYC_t;
               CYC_v_1 = CYC_v;

            end
            V_mph = [V_mph,VEH_v.data(1:nm)];
            GEAR = [GEAR,TRAN_gear_OL.data(1:nm)];
        end
        % monitor vehicle parameters
        %         vis = 0;
        %         if vis ==1
        %             Visual_Component2(VEH_v,VEH_roadload,VEH_p_torq,VEH_n_torq,TRAN_w_in,TRAN_w_out,TRAN_t_in,TRAN_t_out,TRAN_gear,ENG_w,ENG_t,ENG_dmnd_torq,ENG_Max_t,TC_SR,TC_Kfactor,TC_TR,TC_lock,TC_impeller_t,TC_turbine_t,TC_imp_w,TC_turb_w);
        %             Visual_Fuel(CYC_t,CYC_w,CYC_trq,CYC_fuel,ENG_w,ENG_t2,ENG_fuel); % fuel rate
        %             Visual_EngineMap( ENG_w,ENG_t2,CYC_w,CYC_trq,ICE ); % engine operating region
        %             Visual_ShiftDebug(TRAN_gear,TRAN_gear_OL,DR_acc,veh_speed,up_speed,down_speed) % debug shift
        %             Visual_Tracking( DR_cyc,VEH_v,DR_acc,DR_brk);% track vehicle speed
        %             Visual_Shift( DR_cyc,VEH_v,DR_acc,TRAN_gear,TRAN_gear_OL,ENG_torq_req,ENG_Max_t,ENG_w,VEH_p_torq)% shif schduele
        %             Visual_ShiftLine_vt( ShiftUp,ShiftDown );% shift map
        %         end
    end
    
    mpg(:,x) = INFO(:,2); % mpg results
    lms(:,x) = INFO(:,9); % fuel economy results
    
    % energy audit, put relevent together
    energy_k(:,x) = INFO(:,3); % kinetic energy
    energy_ad(:,x) = INFO(:,7); % air drag
    energy_rr(:,x) = INFO(:,6); % rolling resistance
    energy_eff(:,x) = INFO(:,8); % engine efficiency
    
    
end

% plot simulation results
Plot_Sim_Results( V060,T060,driver_score,lms,mpg );


% ============= save('Main3_results.mat') =============

% the figures in Main3_figures




