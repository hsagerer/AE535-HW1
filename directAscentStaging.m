function [] = directAscentStaging()
% Function to calculate the mass per stage of the
% direct ascent launch vehicle 

% Mass of third stage 

syms a

mL = directAscentPayload();
g0 = 9.81;
deltaV = 10500;

Isp = [283,311,421];
Epsilon = [0.05,0.07,0.19];

for i = 1:3
    eqn(i) = Isp(i)*g0*log((a*Isp(i)*g0 + 1)/(a*Isp(i)*g0*Epsilon(i)));
end

EQN = eqn(1) + eqn(2) + eqn(3);

alpha = double(solve(EQN,a))

R = (alpha.*Isp.*g0 + 1)./(alpha.*Isp.*g0.*Epsilon)

figure();
plot(-1:0.03:1,subs(EQN,a,-1:0.03:1));
hold on;
plot([-1,1],[deltaV,deltaV]);
hold off;

end
