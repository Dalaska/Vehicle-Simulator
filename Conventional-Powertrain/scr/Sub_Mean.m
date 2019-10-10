function [ x_sub ] = Sub_Mean( x,x_mean )
%==========================================================================
%  Objective: substract the mean
%  input: x the valaue
%         x_mean: the mean value of the vector
%  output: x_sub: subtract the mean
%==========================================================================

% Inicailize 
x_sub = zeros(size(x));

for n = 1:size(x,1)
    % subtract the meam
    x_sub(n,:) = x(n,:) - x_mean;
end

end

