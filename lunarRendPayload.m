function [] = lunarRendPayload()
% Function for finding the payload mass in a direct ascent trajectory   

Isp = 311;
g0 = 9.81; 

mf1 = 11900;
deltaV1 = 0.9;

mf2 = 11900 + 4280;
deltaV2 = 0.1 + 2.2 + 2.5;

deltaV3 = 0.9;

mpLOR1 = mf1/exp(-deltaV1/(Isp*g0));
mpLOR2 = mf2/exp(-deltaV2/(Isp*g0));
mpLOR3 = mpLOR2/exp(-deltaV3/(Isp*g0));

fprintf('Payload Mass of LOR1: %0.3f kg\n',mpLOR1);
fprintf('Payload Mass of LOR2: %0.3f kg\n',mpLOR2);
fprintf('Payload Mass of LOR3: %0.3f kg\n',mpLOR3);

end