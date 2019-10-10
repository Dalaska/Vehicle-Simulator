function [ bin_id ] = Find_bin2( data,bin )
%==========================================================================
%  Objective: find which bin the data belongs to
%  Input: data, bin
%  Output: the index of which bin the data belongs to
%==========================================================================

bin_id = zeros(size(data)); % inicalize

for m = 1:length(bin_id)    
    n = 1;
    while n < length(bin)-1
        if data(m) < bin(n+1)
            break;
        end
        n = n+1;
    end
    bin_id(m) = n;
end

end

