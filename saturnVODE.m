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
phi = x(5); % rad, 

end