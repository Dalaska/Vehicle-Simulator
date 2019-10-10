function [ ShiftDown ] = Make_Down_Shift( v_start,v_end )
%==========================================================================
% Objective: generate the down shift map
% Input: starting speed of each gear, ending speed of each gear
% Output: the downshift map
%==========================================================================
mps2mph = 2.23694; % meter per sec 2 mile per hour

r =0.9; % downshift when torque demand is greater than r

ShiftDown = zeros(6,17); % inicilize

top = round(size(ShiftDown,2)*r); % the boundary for downshifting

% generate the down shift
for m = 2: 6  % loop through gear
    ShiftDown(m,1:top) = v_start(m-1)*mps2mph;
    ShiftDown(m,top+1:end) = v_end(m-1);
end


end

