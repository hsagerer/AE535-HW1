function [T, mdot, tB, n, D] = rocketSizing(m0, mStages, dv)

% Constants
ThrustRP1 = 6770e3;
ThrustLH2VA = 1033e3;
engThrust = [ThrustRP1,ThrustLH2VA, ThrustLH2VA];
Isp = [263,421,421];
TW(1) = 1.2;
TW(2) = 0.7;
TW(3) = 0.5;
g0 = 9.81;
engDiam = [3.1,2.7,2.7];
structCoef = [0.05,0.07,0.19];

% Rocket Sizing of the Direct Ascent Configuration
m(1) = mStages(1) + mStages(2) + mStages(3) + m0;
m(2) = mStages(2) + mStages(3) + m0;
m(3) = mStages(3) + m0;

% Ignition Thrusts
T = m.*g0.*TW;

% Thrust to Weight to Determine Engine # DA
n(1) = ceil((T(1)/ThrustRP1));
n(2) = ceil((T(2)/ThrustLH2VA));
n(3) = ceil((T(3)/ThrustLH2VA));

% Update thrust to be the actual value from number of engines
T = n.*engThrust;

% Flow Rate
mdot = T./(Isp.*g0);

% Propellant Mass from structural coefficient
% mp = m.*(1-exp(-dv./(g0.*Isp)));
ms = mStages.*structCoef;
mp = mStages-ms;

% Burn time
tB = mp./mdot;

% Engine diameter based on engine number
for i = 1:3
    switch n(i)
        case 1
            D(i) = 1*engDiam(i);
        case 2
            D(i) = 2*engDiam(i);
        case 5
            D(i) = (1+sqrt(2*(1+(1/sqrt(5)))))*engDiam(i);
        case 10
            D(i) = 3.813*engDiam(i);
    end
end

end
