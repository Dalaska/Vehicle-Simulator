function [ L100km ] = Lp100km( n )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    % convert mpg to L /100km
    
L = 3.78541;
dist = n*1.60934/100;
L100km = L/dist;

end

