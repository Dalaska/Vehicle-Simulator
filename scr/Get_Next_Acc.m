function [ v,a,ax ] = Get_Next_Acc( CYC_v_smooth,CYC_acc,i )
%==========================================================================
%  Objective: obtain the maxium acceleration demand in the next i second
%  Input: the smoothed vehicle speed, vehicle acceleration, next i second
%  Output: speed, current acceleration, the maxium acceleration in the next
%  i second
%==========================================================================
% i the next 3 second
n_cyc = length(CYC_v_smooth);

% inicalize
v =  zeros(n_cyc - i,1);
a =  zeros(n_cyc - i,1);
ax = zeros(n_cyc - i,1);

for n = 1:n_cyc - i
    v(n) = CYC_v_smooth(n);
    a(n) = CYC_acc(n);
    ax(n) = max(CYC_acc(n:n+i));
end


end

