function [] = directAscentPayload()
% Function for finding the payload mass in a direct ascent trajectory   

mf = 11900; % CSM dry mass
deltaV = 0.9 + 2.2 + 2.5 + 0.9; % deltaV of CSM, DA
Isp = 311; % ISP of Aerozine-50
g0 = 9.81; 

mpDA = mf/exp(-deltaV/(Isp*g0));

fprintf('Payload Mass of Direct Ascent: %0.3f kg\n',mpDA);

end