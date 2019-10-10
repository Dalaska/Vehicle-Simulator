%==========================================================================
%  Objective:  Inicialize vehicle parameters
%==========================================================================

Powtrain_eff = 0.88; % powertrain effiency

%% Load engine parameters
load D_ICE_8700_2.mat
ICE_maxT_w = ICE.maxT_w;
ICE_maxT_T = ICE.maxT_T;
ENG_Iei = 0.5; % engine iertia

%% Load Torqe Converter parameters
load D_TC_8700.mat

%% Load transmission parameters
TRAN_ratio_gear = [3.094,1.809, 1.406, 1.00, 0.711, 0.614]; % Transmission Gear Ratios
TRAN_gear = [1 2 3 4 5 6];% [ 1st   2nd   3rd   4th 5th 6th  ]
TRAN_ratio_diff = 5.05; % final drive ratio
TRAN_eff = 0.92; % Transmission Efficiency

%% Load vehicle parameters
VEH_M = 8700;
VEH_Cdl = 1.8;           % Frontal Area [m^2]
VEH_Cr = 0.008;         % Coefficient of Rolling Resistance (unitless)
VEH_Rw = 0.357;            % Tire Radius [m]
g = 9.81;               % Acceleration Due to Gravity [m/s^2]
Fr = VEH_M*g*VEH_Cr;
BrakeTorqueGain = VEH_M*0.7*9.81*VEH_Rw; % brake gain

%% unit conversion
rpm2rad = 0.10472; % rpm to rad/s
rad2rpm = 1/rpm2rad;
mps2mph = 2.23694; % meter per sec 2 mile per hour
