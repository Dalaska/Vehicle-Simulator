function [ x_mean ] = Get_Mean( x )
%==========================================================================
%  Objective: caculate the mean of a vector
%  input: the orignal vector
%  output: the mean value of the vector
%==========================================================================
% inicalize the mean
x_mean = zeros(1,size(x,2));

for n = 1:size(x,2)
    t = x(:,n); % torq
    if  ~isnan( mean(t(t>0)))
        x_mean(n) = mean(t(t>0));
    end
end

end

