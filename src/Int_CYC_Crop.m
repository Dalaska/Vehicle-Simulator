function [ stream ] = Int_CYC_Crop( stream )
%==========================================================================
% Objective: select the valid part of a driving cycle
% Input: input data
% Output: the valid part of the daa
%==========================================================================

% find the boundary of gear
gear = stream(:,12); % gear

% start when at the first gear
for n = 1:length(gear) 
    if gear(n) ==1
        start_n =n;
        break;
    end
end
start_n;

% end when gear switched to neutral
for n = 2:length(gear)
    if gear(n-1)==1 && gear(n)<1
        end_n =n;
        break
    end
    end_n =n; % update the stop point
end
end_n;
stream = stream(start_n:end_n,:);

end

