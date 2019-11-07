function [ a ] = Assertion( a,bin_a )
%==========================================================================
%  Objective: make sure the value is within the boundary of the bin
%  input: the orignal value, value of a bin
%  output: the truncated value
%==========================================================================

a = max(a, min(bin_a)); % ensure the minimal value is greater than the boundary
a = min(a, max(bin_a)); % ensure the maxium value is smaller than the boundary

end

