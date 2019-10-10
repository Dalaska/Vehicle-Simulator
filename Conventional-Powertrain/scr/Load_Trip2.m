function[ CYC_t,CYC_v,CYC_grade,CYC_gear,CYC_trq,CYC_fuel,CYC_w ] = Load_Trip2( stream )
%==========================================================================
% Objective: load the driving data
% input: the combined data
% output: each value as a vector
%==========================================================================

% select the valid part 
stream  = Int_CYC_Crop( stream );

% orignial sample rate
CYC_t0 = stream(:,1); % time
CYC_t0 = CYC_t0 - CYC_t0(1);
CYC_trq0 = stream(:,6); % torque
CYC_w0 = stream(:,5); % engine speed
CYC_fuel0 = stream(:,8); % fuel

%down sample
ds_rate = 10;
stream = downsample(stream,ds_rate);  

CYC_gear = stream(:,12); % gear
CYC_trq = stream(:,6); % torque
CYC_fuel = stream(:,8); % fuel
CYC_w = stream(:,5); % engine speed

CYC_t = stream(:,1); % time
CYC_t = CYC_t - CYC_t(1);

CYC_v = stream(:,2)*0.44704;% speed mph to mps (need smoothing) lwr
CYC_v(end) = 0;
CYC_v(end-1) = 0;

CYC_grade = stream(:,7); % grade
CYC_grade(end) = 0;
CYC_grade(end-1) = 0;

end