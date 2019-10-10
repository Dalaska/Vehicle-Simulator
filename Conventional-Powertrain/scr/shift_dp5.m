clc
clear all
close all

%% load a cycle

load('EC_8700_B_01_1')

ds_rate = 5; % downsample
stream = downsample(stream,ds_rate); % sample frequency 10Hz

time = stream(:,1);
speed = stream(:,2);
gear = stream(:,12);
grade  = stream(:,7);
acceleration =  stream(:,3)*1; % reduce maxium so it can 
eng_trq_data = stream(:,6);
fuel_rate = stream(:,8);


figure() % plot speed profile
subplot(2,1,1)
plot(speed)
ylabel('speed [mph]')
% plot gear selection
subplot(2,1,2)
plot(gear)
ylabel('gear')
xlabel('time [sec]')

% select a small section
% n_start = 388;
% n_end = 575;
% time = time(n_start:n_end)-time(n_start);
% speed = speed(n_start:n_end);
% gear = gear(n_start:n_end);
% grade = grade(n_start:n_end);
% acceleration = acceleration(n_start:n_end);
% eng_trq_data = eng_trq_data(n_start:n_end);
% fuel_rate = fuel_rate(n_start:n_end);


figure() % plot speed profile
subplot(2,1,1)
plot(speed)
ylabel('speed [mph]')
% plot gear selection
subplot(2,1,2)
plot(gear)
ylabel('gear')
xlabel('time [sec]')

% output need: time, speed, acceleration

%% caculate torqe demand
% vehicle parameters
VEH_M = 8700;
VEH_Cdl = 1.8;           % Frontal Area [m^2]
VEH_Cr = 0.008;         % Coefficient of Rolling Resistance (unitless)
VEH_Rw = 0.357;            % Tire Radius [m]
g = 9.81;               % Acceleration Due to Gravity [m/s^2]

rpm2rad = 0.10472; % rpm to rad/s
rad2rpm = 1/rpm2rad;

TRAN_ratio_gear = [3.094,1.809, 1.406, 1.00, 0.711, 0.614]; % Transmission Gear Ratios
TRAN_gear = [1 2 3 4 5 6];% [ 1st   2nd   3rd   4th 5th 6th  ]
TRAN_ratio_diff = 5.05;
TRAN_eff = 0.92;
VEH_Rw = 0.3570; % wheel radius
rpm2rad = 0.10472; % rpm to rad/s
mps2mph = 2.23694; % meter per sec 2 mile per hour
mph2mps = 1/mps2mph;

% load Engine parameter
load D_ICE_8700_2.mat
ICE_maxT_w = ICE.maxT_w;
ICE_maxT_T = ICE.maxT_T;
ENG_Iei = 0.5; % engine iertia


%% road load

% convert speed to mph
speed_mps = speed*mph2mps;

% caculate the distance
distance_km = zeros(length(speed_mps),1);
for n = 2:length(speed_mps)
    distance_km(n) = trapz(time(1:n),speed_mps(1:n))/1000;
end

% get road load (tracktion force)
Fr = VEH_M*g*VEH_Cr; % rolling resistance
Fad =  VEH_Cdl*speed_mps.^2; % air drag
Fac = VEH_M*acceleration; % acceleration
Fg = VEH_M*g*0; % grade

% traction force
F_rl = Fr + Fad +Fac+Fg; 
figure()
hold on
plot(F_rl,'r','LineWidth',1)
plot(Fr)
plot(Fad)
plot(Fac)
plot(Fg)
legend('F_rl','Fr','Fad','Fac','Fg')

% traction torque
trq_rl = F_rl*VEH_Rw; % road load, wheel radius
trq_rl = max(trq_rl,0); % minimal is 0

%% gear at each stage, no transition
% gear values (s,g) % number of location, 6 number of gears 6
% input traction torque Trq(m)


% torque demand
len_s = length(speed_mps); % locations
eng_trq = zeros(len_s,6); %(s,g) use look up table
for m =1:len_s
    for n =1:6
        eng_trq(m,n) = trq_rl(m)/(TRAN_ratio_gear(n)*TRAN_ratio_diff); % look up table
    end
end


% engine speed
eng_rpm = zeros(len_s,6); %(s,g) use look up table
for m =1:len_s
    for n =1:6
        eng_rpm(m,n) = speed_mps(m)*(TRAN_ratio_gear(n)*TRAN_ratio_diff)/(VEH_Rw*rpm2rad); % look up table
    end
end

figure()
plot(ICE_maxT_w*rad2rpm, ICE_maxT_T)



% cost for fuel
J_fuel = zeros(len_s,6); %(s,g) use look up table
for m =1:len_s
    for n =1:6
        if (eng_rpm(m,n) > 500 ) && (eng_rpm(m,n) < 2700) % rpm range
            max_trq = interp1(ICE_maxT_w*rad2rpm, ICE_maxT_T, eng_rpm(m,n));
            if eng_trq(m,n) < max_trq
                J_fuel(m,n) = 3600*interp2(ICE.map_w*rad2rpm,ICE.map_T,ICE.map_m_dot', eng_rpm(m,n), eng_trq(m,n));
                % orignal unit is liter per hour, convert to liter per second
            else
                J_fuel(m,n)= 10000; % torque > max torque
            end
        else
            J_fuel(m,n)= 10001; % rpm out of range
        end 
    end
end




% cost for shifting
J_shift = zeros(6,6); %(n,n)

w = 2; % weighting

for m =1:6
    for n = 1:6
        if m == n
            J_shift(m,n) = 0;
        else if abs(m-n) == 1
                J_shift(m,n) = w;
             else
                J_shift(m,n) = 10000; % a large number for infeable
             end
        end
    end
end



% total cost for fuel, V(k,i)= min(d(i,j)+V(k+1,j))  # k is step, j is gear
J = zeros(len_s,6);
J(end,:) = [0 100000 100000 100000 100000 100000];
for m = 2:len_s-1
    n = len_s - m +1;
    for j=1:6 % gear previous step
        cost = zeros(1,6);
        for k = 1:6  % ger next step
            cost(k)= J_shift(j,k) + J(n,k);
            % cost of n-1 step, gear j,
            % fuel cost = n-1, J + minal of further cost     
            % add transition
        end
        J(n-1,j) = J_fuel(n-1,j) + min(cost);
    end   
end

% find the optimal path
shift = zeros(length(J),1);
fuel = zeros(length(J),1);

shift(1) = 1;
for n = 2:length(J)
    [M,I] = min(J(n,:));
    shift(n) = I;
    fuel(n) = J_fuel(n,I); % fuel rate
end

%output, shift, fuel rate, compare it with actual fuel rate

% for n = 1:length(fuel)
%     
% end
% fuel = min(fuel, 9000)
%% plot fuel rate
figure()
plot(fuel)

% minimal fuel 
fuel_sum = trapz(time,fuel)/3600; %fuel in liter


dist_end = distance_km(end)*1000; % distance in meter

MPG_SIM = (dist_end/1609)/(fuel_sum/3.785); % MPG from simulation

%% plots


% speed
figure()
hold on
plot(distance_km,speed,'LineWidth',1)
axis([0 distance_km(end) 0 50 ])
xlabel('Distance [km]');
ylabel('Vechile speed [mph]');

% road load
figure()
hold on
plot(distance_km,F_rl,'r','LineWidth',1)
plot(distance_km,Fr)
plot(distance_km,Fad)
plot(distance_km,Fac)
plot(distance_km,Fg)
axis([0 distance_km(end) -15000 15000 ])
xlabel('Distance [km]');
ylabel('Road load [N]');
legend('Total Road load','Rolling resistance','Aerodynamic drag','Acceleration resistance','Grade force')

figure()
subplot(2,1,1)
plot(distance_km,shift+0.1,'LineWidth',1)
axis([0 distance_km(end) 0 6.5 ])
xlabel('Distance [km]');
ylabel('Gear selection');
hold on 
plot(distance_km,gear,'LineWidth',1)

legend('dp','data')
subplot(2,1,2)
plot(distance_km,speed,'LineWidth',1)


'end'