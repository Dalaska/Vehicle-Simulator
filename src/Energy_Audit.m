function [ E_k,E_f,E_i,E_rr,E_ad,Enge_ef,E_kref ] = Energy_Audit( VEH_v,VEH_M,ENG_fuel,VEH_Cr,VEH_Cdl,ENG_t2,ENG_w,ICE,CYC_v,CYC_t )
%==========================================================================
% Objective: energy audit, calculate each component of the energy
% Input:  vehicle speed, mass, fuel rate, Cr, Cd, engine torque, speed
% Output: components of the the energy consumption
%==========================================================================

E_k  = Get_Kinetic_Energy2(VEH_v.data,VEH_v.time,VEH_M); % kinetic energy
E_f  = Get_Fuel_Energy(ENG_fuel.data, ENG_fuel.time ); % energy from fuel rate
E_i  = Get_Idle_Energy(VEH_v.data, ENG_fuel.data, ENG_fuel.time ); % energy from idleing
E_rr = Get_RR_Energy(VEH_v.data,VEH_v.time,VEH_M,VEH_Cr); % energy consumed by rolling resistance
E_ad = Get_AD_Energy(VEH_v.data,VEH_v.time,VEH_Cdl); % energy consumed by aerodynamic drag
Enge_ef = Get_Eng_Eff(ENG_t2.data,ENG_w.data,VEH_v.data,ICE);% engine efficiency get from maps
E_kref  = Get_Kinetic_Energy(CYC_v,CYC_t,VEH_M); % kinetic energy

end

