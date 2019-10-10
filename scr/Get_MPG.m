function [ MPG_SIM,MPG_CYC,error ] = Get_MPG( CYC_t,CYC_v,CYC_fuel,VEH_v,ENG_fuel)
%==========================================================================
% Objective: obtain MGP from simulation
% Input: cycle time, cycle speed, fuel rate, vehicle speed, fuel rate
% Output: MPG from simulation, MPG from cycle, error 
%==========================================================================

fuel_SIM = trapz(ENG_fuel.time,ENG_fuel.data); %total fuel from simuation
fuel_CYC = trapz(CYC_t,CYC_fuel); %total fuel from cycle data

dis_SIM = trapz(VEH_v.Time,VEH_v.Data);% trip distance meter
dis_CYC = trapz(CYC_t,CYC_v);% trip distance meter

MPG_SIM = (dis_SIM /1609)/(fuel_SIM/3.785)*3600; % MPG from simulation

MPG_CYC = (dis_CYC/1609)/(fuel_CYC/3.785)*3600; % MPG from data

error = (MPG_SIM-MPG_CYC)/MPG_CYC; % error between the simulation and data

end