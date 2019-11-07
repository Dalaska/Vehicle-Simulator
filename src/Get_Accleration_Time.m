function [ time ] = Get_Accleration_Time( CYC_v,CYC_t,v_start,v_end )
%==========================================================================
%  Objective: caculate the time need for the vehicle to accelerate from
%  a starting speed to a end speed
%  Input: speed profile, time, starting speed, ending speed
%  Output: the acceleration time
%==========================================================================

time =[];
start_state = 0;
for i = 1 : size(CYC_v,1) % i for index
    speed = CYC_v(i);
    switch start_state
        case 0 % state 0
            if  speed < v_start
                start_state = 1;
            end
        case 1 % state 1
            if  speed < v_start
                start_i = i;
            else if speed > v_end
                    end_i = i;
                    t = CYC_t(end_i) - CYC_t(start_i);
                    time = [time;t];
                    start_state = 0;
                end
            end
    end
end


end

