function [ v_max_mps ] = Upshift_Max_V()
%==========================================================================
% Objective: set the maximum speed for each gear
% Input: NA
% Output: the maximum speed for each gear 
%==========================================================================

mps2mph = 2.23694; % meter per sec 2 mile per hour

v_max_mps_1 = [ 13.03, 15.16, 21.99, 30.91, 38.56]/mps2mph; % most effieicnt
v_max_mps_4 = [ 13.03, 24.00, 31.00, 44.00, 59.00]/mps2mph; % maximum power

v_max_mps =  zeros(6,5); % inicialize
for k = 1:5 % loop through each gear
    v_max_mps(:,k) = linspace(v_max_mps_1(k),v_max_mps_4(k),6)';
end

end

