function [m0DA] = directAscentPayload()
% Function for finding the payload mass in a direct ascent trajectory   

mf = 11900; % CSM dry mass
deltaV = (0.9 + 2.2 + 2.5 + 0.9)*10^3; % deltaV of CSM, DA
Isp = 311; % ISP of Aerozine-50
g0 = 9.81; 

m0DA = mf/exp(-deltaV/(Isp*g0));

% fprintf('Payload Mass of Direct Ascent: %0.0f kg\n',m0DA);

end