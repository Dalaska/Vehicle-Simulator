function [ v_down_max ] = Downshift_Max_V( v_down_min_mps,v_max_mps )
%==========================================================================
% Objective: maximum speed of each gear in the downshift map
% Input: the minium speed for each gear in the downshift map, the maxium
% speed for each gear in the upshift map
% Output: the maximum speed of each gear in the downshift map
%==========================================================================

offset = 1; % hysteresis
v_down_max = zeros(size(v_max_mps)); % inicalize
k = size(v_max_mps,1);

for n = 1:k
    % maxium speed in the downshift map is a offset form the maxium speed 
    % in the upshift map
    % if the offset value is lower than the minimum speed, choose the
    % minimum speed
    v_down_max(n,:) = max(v_max_mps(n,:)-offset,v_down_min_mps);
end

end

