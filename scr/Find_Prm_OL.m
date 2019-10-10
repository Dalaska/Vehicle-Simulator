function [ prm ] = Find_Prm_OL( speed,throttle,acel)
%==========================================================================
%                               Find_Prm_Online
% find primitives (driving events)
%
% inputs:
% speed
% throttle
% acel
%
% output:
% prm (types of primitives)
% 0.idel 1.accelerate 2.sustain 3.coasting 4.braking
%-------------------------------------------------------------------------- 
%                           Tuning Parameters 
T_tsd = 10; % throttle threshold
a_tsd = 0.2; % acceleration threshold
b_tsd = -0.5; % braking threshold
%==========================================================================

 
% rule based supervior
for n=1:length(speed)
    if  acel > a_tsd % accelerating is greater than threshold
        prm = 1; % accelerate
    end
    
    if  acel < b_tsd % deccelerating is smaller than threshold
        prm = 4; % decelerate
    end
    
    if (acel > b_tsd ) && (acel < a_tsd )
        % accelerating is in between the thresholds
        if  (throttle(n) > T_tsd) % throttle is greater than 10%
            prm = 2; % sustain
        else
            prm = 3; % coasting
        end
    end
    
    if (throttle <1) && (speed < 1)  
        % speed and threttle are essencially 0
        prm = 5; % idling
    end
    
end


end

