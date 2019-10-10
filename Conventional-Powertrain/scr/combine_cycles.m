function [ time_all, speed_all ] = combine_cycles( CYC_v1, CYC_v2, CYC_v3, CYC_t1, CYC_t2, CYC_t3 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
time_all = [CYC_t1;
            CYC_t2 + CYC_t1(end);
            CYC_t3 + CYC_t2(end) + CYC_t1(end)];
        
speed_all = [CYC_v1;CYC_v2;CYC_v3];


end

