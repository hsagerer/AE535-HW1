function [] = lunarRendPayload()
% Function for finding the payload mass in a direct ascent trajectory   

Isp = 311;
g0 = 9.81; 

mf1 = 11900;
deltaV1 = 0.9;

mf2 = 11900 + 4280;
deltaV2 = 0.1 + 2.2 + 2.5;

mpLOR1 = mf1/exp(-deltaV1/(Isp*g0));
mpLOR2 = mf2/exp(-deltaV2/(Isp*g0));

end