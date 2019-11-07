function [ c_mean,c_count,p_prv_c ] = F2_Coast_OL( p_attr,c_mean,c_count,p_prv_c )
%==========================================================================
%                        F2_Coast_OL
% definition:
%         average coasting time before decelerating
%--------------------------------------------------------------------------
% inputs:
% p_attr: primitive attributes
% c_mean: the mean coasting time
% c_count: counting of coasting events
% p_prv_c: previous event
%--------------------------------------------------------------------------
% outputs:
% c_mean: the average coasting time
% c_count: counting of coasting events
% p_prv_c: previous event
%--------------------------------------------------------------------------
%                           Tuning Parameters
T_c_minv = 8; % minimal change of speed in a break event
T_c_max = 10; % maxium duration
%==========================================================================

if (p_attr(1) == 4) && ((p_attr(3) - p_attr(4)) > T_c_minv)
 % (event is decelerating) and (change of speed is greater than threshold)
    if (p_prv_c(1) ~= 4)
        if (p_prv_c(1) == 3) % previous is coasting       
            c_time = min(p_prv_c(2),T_c_max); 
            % truncate coasting time if exeed the maxium
        else
            c_time = 0; % coast time is 0
        end
        
        % record brake event
        c_mean = (c_mean*c_count + c_time)/(c_count+1); % recursive averge
        c_count =c_count+1;
    end
    
end
p_prv_c = p_attr; % update the previous event

end




