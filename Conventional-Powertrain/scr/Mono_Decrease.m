function [ shift_line ] = Mono_Decrease( shift_line )
%==========================================================================
%  Objective: make sure the shift speed in monotonical descreasing
%  Input: the shift line
%  Output: the monotonic decreased shift line
%==========================================================================

len = size(shift_line,2); % granity of speed for each gear

for k = 1: 5 %gear
 for n = 0:len-2
     if shift_line(k,len-n-1) > shift_line(k,len-n)
        shift_line(k,len-n-1) = shift_line(k,len-n);
     end
 end
end

end

