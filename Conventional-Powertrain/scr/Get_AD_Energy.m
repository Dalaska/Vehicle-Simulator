function E_ad = Get_AD_Energy(speed,time,VEH_Cdl)
%==========================================================================
% Objective: caculate the energy consumed by aerodynamic drag
% Input: vehicle speed, time, lumped aerodynamic drag coefficient
% Output: energy consumed by aerodynamic drag
%==========================================================================

% Inicialize
F_cdl = zeros(size(time)); 
dis_accum = zeros(size(time));

for n=2:length(time)
    F_cdl(n) = VEH_Cdl*speed(n).^2; % aerodynamic drag
    dis_accum(n) = dis_accum(n-1) + 0.5*(speed(n)+speed(n-1))*(time(n)-time(n-1));
end

E_ad = trapz(dis_accum,F_cdl); % energy consumpted by aerodynamic drag

end