function [ va_max,v_mph ] = Get_Acc_Percentile( va_list,x )
%==========================================================================
%  Objective: get the x% of the maximun acceleration at each speed
%  Input: list of speed and acceleration, percentile
%  Output: x% of maxium acceleration at each speed, vehicle speed
%==========================================================================

mps2mph = 2.2369; % meter per second to mile per hour

speed_range = 25;
v_mph = (1:25)*mps2mph;

va_list(:,1) = round(va_list(:,1));

% positive acc
va_list = va_list(va_list(:,2)>0.1,:);

va_max = zeros(speed_range,1);

dumpy = [[1:speed_range]', zeros(speed_range,1) ];
va_list = [va_list;dumpy];

for n=1:speed_range
    i = (va_list(:,1)==n);
    
    % percentile
    va_max(n) = prctile(va_list(i,2),x);
    
    if  isnan(va_max(n))
        va_max(n) = -1;
    end
end

end

