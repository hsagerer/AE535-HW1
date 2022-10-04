function [] = directAscentStaging()
% Function to calculate the mass per stage of the
% direct ascent launch vehicle 

% Mass of third stage 

mL = directAscentPayload();
g0 = 9.81;
deltaV3 = 3200;
Isp3 = 421;
Eps3 = 0.19;

R3 = exp(deltaV3/(Isp3*g0));
Gam3 = (1-Eps3*R3)/(R3-1);
mStage3 = mL/Gam3 + mL;

mL2 = mStage3;


end
