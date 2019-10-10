function [ updated ] = LowPassFilter_OL( previous,input,a)
%==========================================================================
%                               LowPassFilter_OL
% 1st order low pass filter
% 
% inputs:
% previous: the previous value
% input: the new value
% a: forgetting factor range 0-1. toward 0 more forgetting effect
%
% output:
% updated: the filtered value                     
%==========================================================================

updated = a*previous + (1-a)*input;

end

