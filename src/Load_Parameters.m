%==========================================================================
%  Objective: Inicialize parameters
%==========================================================================

% system
cycle_num =1; % complite cycle how many times
try Stoptime = length(CYC_t);
end

%% driver parameter
DR_LP = 0.2; % driver low pass filter

sample_time = 0.1;
DR_P =1;
DR_I = 0.0001;
DR_FF = 1;

%% Engine Torque Response
SystemSampleTime = 0.001;
Engine.TorqResponseFltrNum=[0.1666*SystemSampleTime 0.1666*SystemSampleTime];
Engine.TorqResponseFltrDen=[1 2*Engine.TorqResponseFltrNum(1)-1];
Init.EngineTorque = 100;
Powtrain_eff = 0.88; % powertrain effiency

%% load Engine parameter
load D_ICE_8700_2.mat
ICE_maxT_w = ICE.maxT_w;
ICE_maxT_T = ICE.maxT_T;
ENG_Iei = 0.5; % engine iertia

%% load Torqe Converter
load D_TC_8700.mat

%% load Transmission
TRAN_ratio_gear = [3.094,1.809, 1.406, 1.00, 0.711, 0.614]; % Transmission Gear Ratios
TRAN_gear = [1 2 3 4 5 6];% [ 1st   2nd   3rd   4th 5th 6th  ]
TRAN_ratio_diff = 5.05;
TRAN_eff = 0.92;                % Transmission Efficiency

%% Load vehicle
VEH_M = 8700;
VEH_Cdl = 1.8;           % Frontal Area [m^2]
VEH_Cr = 0.008;         % Coefficient of Rolling Resistance (unitless)
VEH_Rw = 0.357;            % Tire Radius [m]
g = 9.81;               % Acceleration Due to Gravity [m/s^2]
Fr = VEH_M*g*VEH_Cr;

BrakeTorqueGain = VEH_M*0.7*9.81*VEH_Rw;
Enable_Shift = 1;
Enable_Lag = 0;

%% unit conversion
rpm2rad = 0.10472; % rpm to rad/s
rad2rpm = 1/rpm2rad;
mps2mph = 2.23694; % meter per sec 2 mile per hour
