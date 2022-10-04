function [stageMasses,deltaVs] = stageMasses(mL)
% Function to calculate the mass per stage of the
% direct ascent launch vehicle 
     
syms a

g0 = 9.81;
deltaV = 10500;

Isp = [283,311,421];
Epsilon = [0.05,0.07,0.19];

for i = 1:3
    R(i) = (a.*Isp(i).*g0 + 1)./(a.*Isp(i).*g0.*Epsilon(i));
    eqn(i) = Isp(i).*g0.*log(R(i));
end

EQN = eqn(1) + eqn(2) + eqn(3) == deltaV;

alpha = double(vpasolve(EQN,a));

R = (alpha.*Isp.*g0 + 1)./(alpha.*Isp.*g0.*Epsilon);
G = (1-R.*Epsilon)./(R-1);

m03 = mL*((1+G(3))/G(3));
m02 = m03*((1+G(2))/G(2));
m01 = m02*((1+G(1))/G(1));

stageMasses = [m01,m02,m03];

dv1 = Isp(1)*g0*log((alpha*Isp(1)*g0 + 1)/(alpha*Isp(1)*g0*Epsilon(1)));
dv2 = Isp(2)*g0*log((alpha*Isp(2)*g0 + 1)/(alpha*Isp(2)*g0*Epsilon(2)));
dv3 = Isp(3)*g0*log((alpha*Isp(3)*g0 + 1)/(alpha*Isp(3)*g0*Epsilon(3)));

deltaVs = [dv1,dv2,dv3];
totaldV = sum(deltaVs);

end
