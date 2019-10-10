function [ energy ] = F4_Energy_OL( p_attr,energy)
%==========================================================================
%                            F4_Energy_Online
% definition: 
%           kinetic_energy
%-------------------------------------------------------------------------- 
% inputs:
% p_attr: event attributes
% energy: previous kinetic energy
%--------------------------------------------------------------------------
% output:
% energy: kinetic energy
%==========================================================================

% kenatic energy
if (p_attr(4) - p_attr(3))>0 % change of speed
    % if speed increase, add to kenatic energy
    energy = energy + (p_attr(4)^2-p_attr(3)^2);
end



end

