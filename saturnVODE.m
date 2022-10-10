% Based off of LaunchODE.m provided on Canvas

% verticalLaunch and fixedPitch are boolean values, where vertical launch
% does a gravity turn and fixedPitch does a fixed pitch maneuver
function [xdot] = saturnVODE(t,x,mdot,T_SL,T_vac...
    ,Gimbal,verticalLaunch,fixedPitch,targetPitch)

% Make sure only vertical launch or fixed pitch are selected
if verticalLaunch & fixedPitch
    error('Cannot use both vertical launch and fixed pitch');
end

% Set constants
Re = 6371e3;    % m, Radius of earth
g0=9.81;        % m/s^2, gravitational acceleration

% Split up x vector for easy interpretation
m = x(1);   % kg, masss
v = x(2);   % m/s, velocity
r = x(3);   % m, distance from center of Earth
psi = x(4); % rad, flight angle
phi = x(5); % rad, true anomaly

% Atmospheric Pressure Interpolation from Appendix
h_ref = 1e3*[0:9 10:5:25 30:10:80]; 
P_ref = 1e4*[10.13 8.988 7.95 7.012 6.166 4.405 4.722 4.111 3.565 3.08 2.65...
    1.211 0.5529 0.2549 0.1197 0.0287 0.007978 0.002196 0.00052 0.00011];
Patm = interp1(h_ref,P_ref,parameters(2)-Re,'linear',0);

end