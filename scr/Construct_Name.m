function [ trip_name ] = Construct_Name( trip_log )
%==========================================================================
% Objective: construct the file name from trip log
% input: number of trip
% output: trip file name
%==========================================================================

cycleN = trip_log(1);
weight = trip_log(2);
GB = trip_log(3);
driverN = trip_log(4);
tripN = trip_log(5);


switch cycleN
    case 1
        nam1='EC';
    case 2
        nam1='HC';
    case 3
        nam1='MH';
    case 4
        nam1='SB';
    case 5
        nam1='SW';
    case 6
        nam1='CB';
end

switch weight
    case 8700
        nam2='8700';
    case 13000
        nam2='13000';
    case 15000
        nam2='15000';
    case 20500
        nam2='20500';
end

switch GB
    case 0
        nam3='B';
    case 1
        nam3='G';
end

if driverN<10
    nam4 = strcat('0',num2str(driverN));
else
    nam4 = num2str(driverN);
end

nam5 = num2str(tripN);

trip_name = strcat('data/',nam1,'_',nam2,'_',nam3,'_',nam4,'_',nam5)
end