%==========================================================================
%                              Classify the trips   
%==========================================================================

% choose classfier base on speed
v_ind = floor(m_speed/5)-2; % speed index
v_ind = min(v_ind,7); % truncate if exeed 7
v_ind = max(v_ind,0); % truncate if less than 0

% choose coefficients
switch v_ind
    case 0 % 10-15 mph
        N =Nm0; % normalization parameter
        theta=theta_0; % classification coefficient
    case 1 % 15 -20 mph
        N =Nm1;
        theta=theta_1;
    case 2 % 20 -25 mph
        N =Nm2;
        theta=theta_2;
    case 3  % 25 -30 mph
        N =Nm3;
        theta=theta_3;
    case 4  % 30 -35 mph
        N =Nm4;
        theta=theta_4;
    case 5  % 35-45 mph
        N =Nm5;
        theta=theta_5;
    case 6  % 35-45 mph
        N =Nm6;
        theta=theta_6;
    case 7  % 45 up mph
        N =Nm6;
        theta=theta_6;
end

% normalized the feature vector
for m=1:size(ftr,2)
    x_test(m) = Normalize_Feature( ftr(m),N(m,1),N(m,2));
end

% driver score 
prob = Test( x_test,theta );


