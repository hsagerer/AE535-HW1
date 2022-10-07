function [derivatives] = launchODE(time,parameters,mdot,Thrust_SL,Thrust_vac...
    ,Gimbal,verticalLaunch,fixedPitch,targetPitch)
%GRAVITYTURNODE ODE for a rocket launch subject to a gravity turn
%   Detailed explanation goes here
%   paramters :  [Mass, radius, speed, flight-path-angle, true anomaly]
%   mdot : propellant flow rate (assumed positive)
%   Thrust_SL : TOTAL rocket thrust at Sea level conditions
%   Thrust_vac : TOTAL rocket thrust at vacuum conditions
%   Gimbal : Engine gimbal angle (always make 0 for HW1)
%   verticalLaunch : enable vertical launch mode for equations of motions
%   fixedPitch : enable fixed pitch maneuver mode
%   targetPitch : pitch angle for fixed pitch mode [rad]
%If fixedPitch and verticalLaunch are false the code assumes gravity turn

if verticalLaunch && fixedPitch
    error('Cannot use both fix pitch mode and vertical launch mode')
end


%Constants
%Radius of Earth
Re = 6371e3;
%Gravity
g0=9.81;

%%% Give physical names to input parameters
%Mass
m = parameters(1);
%Radial position
r = parameters(2);
%Speed
v = parameters(3);
%Flight-path-angle
psi = parameters(4);
%True anomaly
nu = parameters(5);


%Assumptions for vertical launch


%%%Interpolate atmospheric pressure
h_ref = 1e3*[0:9 10:5:25 30:10:80]; 
P_ref = 1e4*[10.13 8.988 7.95 7.012 6.166 4.405 4.722 4.111 3.565 3.08 2.65...
    1.211 0.5529 0.2549 0.1197 0.0287 0.007978 0.002196 0.00052 0.00011];
Patm = interp1(h_ref,P_ref,parameters(2)-Re,'linear',0);

%Calculate thrust at new altitude
Thrust=Thrust_vac - Patm/P_ref(1)*(Thrust_vac-Thrust_SL);

%Assumptions for this problem
Drag=0;
Lift=0;
AOA=0;

%Mass
dmdt = -mdot;
%Radius
if verticalLaunch
    drdt = v;
else
    drdt = v*sin(psi);
end
%Speed
if fixedPitch
    dvdt = -g0*sin(psi) + Thrust/m*cos(targetPitch-psi) - Drag/m;
elseif verticalLaunch
    dvdt = -g0 + Thrust/m*cos(AOA+Gimbal) - Drag/m;
else
    dvdt = -g0*sin(psi) + Thrust/m*cos(AOA+Gimbal) - Drag/m;
end
%Flight path angle
if fixedPitch
    dpsidt = -(g0/v - v/r)*cos(psi)+Thrust/m*sin(targetPitch-psi)/v+Lift/m/v;
elseif verticalLaunch
    dpsidt = 0;
else
    dpsidt = -(g0/v - v/r)*cos(psi)+Thrust/m*sin(AOA+Gimbal)/m+Lift/m/v;
end
%True anomaly
if verticalLaunch
    dnudt = 0;
else
    dnudt = v*cos(psi)/r;
end

%Derivative vector
derivatives = [dmdt; drdt; dvdt; dpsidt; dnudt];

end


