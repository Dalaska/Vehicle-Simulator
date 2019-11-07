function [ shift,J ] = DP_get_shift2(speed_mps, trq_wheel, w )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% load Engine parameter
load D_ICE_8700_2.mat
ICE_maxT_w = ICE.maxT_w;
ICE_maxT_T = ICE.maxT_T;

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



% engine torque
len_s = length(speed_mps); % locations
eng_trq = zeros(len_s,6); %(s,g) use look up table
for m =1:len_s
    for n =1:6
        eng_trq(m,n) = trq_wheel(m)/(TRAN_ratio_gear(n)*TRAN_ratio_diff); % look up table
    end
end



% engine speed
eng_rpm = zeros(len_s,6); %(s,g) use look up table
for m =1:len_s
    for n =1:6
        eng_rpm(m,n) = speed_mps(m)*(TRAN_ratio_gear(n)*TRAN_ratio_diff)/(VEH_Rw*rpm2rad); % look up table
    end
end




%% cost for fuel
J_fuel = zeros(len_s,6); %(s,g) use look up table
for m =1:len_s
    for n =1:6
        if (eng_rpm(m,n) > 1400 ) && (eng_rpm(m,n) < 2500) % rpm range
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


% fix 
for n = 1:length(J_fuel)
    if (J_fuel(n,1)>900)&&(J_fuel(n,2)>900)&&(J_fuel(n,3)>900)&&...
            (J_fuel(n,4)>900)&&(J_fuel(n,5)>900)&&(J_fuel(n,6)>900)
        J_fuel(n,1)=0;
    end
end


% cost for shifting
J_shift = zeros(6,6); %(n,n)
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





% total cost for fuel, 
% V(k,i)= min(d(i,j)+V(k+1,j))  # k is step, j is gear
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
%fuel = zeros(length(J),1);

shift(1) = 1;
for n = 2:length(J)
    [M,I] = min(J(n,:));
    shift(n) = I;
    %fuel(n) = J_fuel(n,I); % fuel rate
end


end

