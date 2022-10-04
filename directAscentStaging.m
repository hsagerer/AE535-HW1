function [] = directAscentStaging()
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

alpha = double(solve(EQN,a));

R = (alpha.*Isp.*g0 + 1)./(alpha.*Isp.*g0.*Epsilon);



dv3 = Isp(3)*g0*log((alpha*Isp(3)*g0 + 1)/(alpha*Isp(3)*g0*Epsilon(3)))

end
