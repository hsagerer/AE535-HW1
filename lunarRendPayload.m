function [] = lunarRendPayload()
% Function for finding the payload mass in a direct ascent trajectory   

Isp = 311;
g0 = 9.81; 

mf1 = 11900;
deltaV1 = 0.9;

mf2 = 4280;
deltaV2 = 0.1 + 2.2 + 2.5;

deltaV3 = 0.9;

moLOR1 = mf1/exp(-deltaV1/(Isp*g0));
moLOR2 = (4280)/exp(-deltaV2/(Isp*g0));
moLOR3 = (moLOR2 + moLOR1)/exp(-deltaV3/(Isp*g0));

fprintf('Payload Mass of LOR1: %0.3f kg\n',moLOR1);
fprintf('Payload Mass of LOR2: %0.3f kg\n',moLOR2);
fprintf('Payload Mass of LOR3: %0.3f kg\n',moLOR3);

end