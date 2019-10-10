function [ v_min_mps ] = Upshift_Min_V( )
%==========================================================================
%  Objective: set minimum speed for up shifting
%  input: NA
%  output: minimum speed at each gear
%==========================================================================

mps2mph = 2.23694; % meter per sec 2 mile per hour

v1 = 10; % downshift speed @ 1st gear
[ v2 ] = rpm2mph( 1200, 3 ); % downshift speed @ 2nd gear
[ v3 ] = rpm2mph( 1200, 4 ); % downshift speed @ 3rd gear
[ v4 ] = rpm2mph( 1119, 5 ); % downshift speed @ 4th gear
[ v5 ] = rpm2mph( 1115, 6 ); % downshift speed @ 5th gear
v_min_mps = [  v1, v2, v3, v4, v5]/mps2mph; % goup to a vector, convert to mps

end

