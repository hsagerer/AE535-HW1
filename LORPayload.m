function [m0LOR] = LORPayload()
% Function for finding the payload mass in a direct ascent trajectory   

Isp = 311;
g0 = 9.81; 

mf1 = 11900;
deltaV1 = 0.9*10^3;

mf2 = 4280;
deltaV2 = (0.1 + 2.2 + 2.5)*10^3;

deltaV3 = 0.9*10^3;

m0LOR1 = mf1/exp(-deltaV1/(Isp*g0));
m0LOR2 = (mf2)/exp(-deltaV2/(Isp*g0));
m0LOR3 = (m0LOR2 + m0LOR1)/exp(-deltaV3/(Isp*g0));

% fprintf('Payload Mass of LOR1: %0.3f kg\n',m0LOR1);
% fprintf('Payload Mass of LOR2: %0.3f kg\n',m0LOR2);
% fprintf('Payload Mass of LOR3: %0.0f kg\n',m0LOR3);

m0LOR = m0LOR3;

end