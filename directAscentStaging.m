function [] = directAscentStaging()
% Function to calculate the mass per stage of the
% direct ascent launch vehicle 

% Mass of third stage 

mL = directAscentPayload();
g0 = 9.81;
deltaV3 = 3200;
Isp3 = 421;

mStage3 = mL/exp(-deltaV3/(Isp3*g0));


end
