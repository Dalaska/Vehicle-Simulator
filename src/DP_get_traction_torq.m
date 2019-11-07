function [ trq_wheel ] = DP_get_traction_torq( speed_mps, acceleration )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% vehicle parameters
VEH_M = 8700;
VEH_Cdl = 1.8;           % Frontal Area [m^2]
VEH_Cr = 0.008;         % Coefficient of Rolling Resistance (unitless)
VEH_Rw = 0.357;            % Tire Radius [m]
g = 9.81;               % Acceleration Due to Gravity [m/s^2]

rpm2rad = 0.10472; % rpm to rad/s
rad2rpm = 1/rpm2rad;

% get road load (tracktion force)
Fr = VEH_M*g*VEH_Cr; % rolling resistance
Fad =  VEH_Cdl*speed_mps.^2; % air drag
Fac = VEH_M*acceleration; % acceleration
Fg = 0; % grade
F_rl = Fr + Fad + Fac + Fg; % traction force

% traction torque 
trq_wheel = F_rl*VEH_Rw; % road load, wheel radius
trq_wheel = max(trq_wheel,0); % minimal is 0

for n = 1: length(trq_wheel)
    if speed_mps(n) < 1
        trq_wheel(n) = 0;
    end
end

% figure()
% hold on
% plot(F_rl,'LineWidth',1)
% plot(Fr,'LineWidth',1)
% plot(Fad,'LineWidth',1)
% plot(Fac,'LineWidth',1)
% legend('Total road load','Rolling resistance','Aerodynamic drag','Acceleration resistance')
% xlabel('Time')
% ylabel('Traction force [N]')
% axis([])

end

