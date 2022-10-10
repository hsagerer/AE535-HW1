%% AERO 535 - Assignment 1
%  Carter Briggs, Cole Helsel, Hunter Sagerer
close all;  clear;  clc;

%% Direct Ascent Calculations
% Files Included:
% 
% <include>directAscentPayload.m<\include>
% 

m0DA = directAscentPayload();
fprintf('LV Payload Mass of Direct Ascent: %0.0f kg\n',round(m0DA,4,'significant')); 

%% Lunar Rendezvous Calculations
% Files Included:
% 
% <include>LORPayload.m<\include>
% 

m0LOR = LORPayload();
fprintf('LV Payload Mass of LOR: %0.0f kg\n\n',round(m0LOR,4,'significant'));

%% Stage Masses
% Files Included:
% 
% <include>stageMasses.m<\include>
% 

[mDA, dvDA] = stageMasses(m0DA);
[mLOR, dvLOR] = stageMasses(m0LOR);

for i = 1:3
    fprintf('Direct Ascent Stage %d Mass: %0.3f x 10^6 kg\n',i,round(mDA(i)/1E6,4,'significant'));
end
fprintf('Direct Ascent Total Mass: %0.3f x 10^6 kg\n\n',round((sum(mDA)+m0DA)/1E6,4,'significant'));

for i = 1:3
    fprintf('LOR Stage %d Mass: %0.3f x 10^6 kg\n',i,round(mLOR(i)/1E6,4,'significant'));
end
fprintf('LOR Total Mass: %0.3f x 10^6 kg\n\n',round((sum(mLOR)+m0LOR)/1E6,4,'significant'));

%% Rocket Sizing
% Files Included:
% 
% <include>rocketSizing.m<\include>
% 

[TDA, mdotDA, tbDA, nDA, DDA] = rocketSizing(m0DA, mDA, dvDA);
[TLOR, mdotLOR, tbLOR, nLOR, DLOR] = rocketSizing(m0LOR, mLOR, dvLOR);

fprintf('Arc\tStg\tThrust [kN]\tFlow Rt [kg/s]\t tB [s] \tn\tdiam [m]\n');
for i = 1:3
    fprintf('DA \t %d \t %d \t\t %0.2f \t\t %0.2f \t%d\t%0.2f\n',i,TDA(i)/1000,mdotDA(i), tbDA(i),nDA(i),DDA(i));
    fprintf('LOR\t %d \t %d \t\t %0.2f \t\t %0.2f \t%d\t%0.2f\n',i,TLOR(i)/1000,mdotLOR(i), tbLOR(i),nLOR(i),DLOR(i));
end

%% Flight Simulation
% Files Included: 
%
% <include>saturnVODE.m
%

options = odeset('AbsTol',1e-10,'RelTol',1e-12);

% Constants
Re = 6371e3;    % m, Radius of earth
g0 = 9.81;      % m/s^2, gravitational acceleration
T_F1_SL = 6770e3;
T_F1_Vac = 7770e3;
T_J2_SL = 486.2e3;
T_J2_Vac = 1033e3;

% Vertical Lift-off
x0 = [sum(mLOR)+m0LOR;
      0;
      Re;
      pi/2;
      0];
tstart = 0;
tstep = 0.01;
tend = 12;
timeS1 = tstart:tstep:tend;
[T1,X1] = ode45(@(t,x) saturnVODE(t,x,mdotLOR(1),5*T_F1_SL,5*T_F1_Vac,pi/2),...
   timeS1,x0,options);
% [T1,X1] = ode45(@(t,x) launchODE(t,x,mdotLOR(1),5*T_F1_SL,5*T_F1_Vac...
%     ,0,true,false,0),timeS1,x0,options);

% Pitch Over, Gravity Turn
x0 = X1(end,:);
x0(4) = deg2rad(89);
tstart = tend;
tend = tbLOR(1);
timeS2 = tstart:tstep:tend;
[T2,X2] = ode45(@(t,x) saturnVODE(t,x,mdotLOR(1),5*T_F1_SL,5*T_F1_Vac,NaN),...
   timeS2,x0,options);
% [T2,X2] = ode45(@(t,x) launchODE(t,x,mdotLOR(1),5*T_F1_SL,5*T_F1_Vac...
%     ,0,false,false,0),timeS2,x0,options);

% 2nd stage constant pitch
cp = 17.54185;    % Constant pitch angle, degrees
x0 = X2(end,:);
x0(1) = mLOR(2) + mLOR(3) + m0LOR;
tstart = tend;
tend = tbLOR(2)+tend;
timeS3 = tstart:tstep:tend;
[T3,X3] = ode45(@(t,x) saturnVODE(t,x,mdotLOR(2),5*T_J2_SL,5*T_J2_Vac,...
    deg2rad(cp)),timeS3,x0,options);
% [T3,X3] = ode45(@(t,x) launchODE(t,x,mdotLOR(2),5*T_J2_SL,5*T_J2_Vac...
%     ,0,false,true,deg2rad(cp)),timeS3,x0,options);

% 3rd stage constant pitch
x0 = X3(end,:);
x0(1) = mLOR(3) + m0LOR;
tstart = tend;
tend = tbLOR(3)+tend;
timeS4 = tstart:tstep:tend;
[T4,X4] = ode45(@(t,x) saturnVODE(t,x,mdotLOR(3),T_J2_SL,T_J2_Vac,...
    deg2rad(cp)),timeS4,x0,options);
% [T4,X4] = ode45(@(t,x) launchODE(t,x,mdotLOR(3),T_J2_SL,T_J2_Vac...
%     ,0,false,true,deg2rad(cp)),timeS4,x0,options);

% Combine
T = [T1;T2;T3;T4];
X = [X1;X2;X3;X4];

% Post process
vel = X(:,2);
T = T(vel<=7300);
X = X(vel<=7300,:);
mass = X(:,1);
vel = X(:,2);
r = X(:,3);
psi = X(:,4);
phi = X(:,5);
alt = r-Re;
range = Re.*phi;
% fprintf('Final Vel: %0.2f km/s\n',vel(end)/1000);
fprintf('Final Alt: %0.3f km\n',alt(end)/1000);
acc = (diff(vel))/tstep;
acc(end+1) = 0;
tpitch = max(timeS1);
tmeco = max(timeS2);
tseco = max(timeS3);

% Plot altitude vs. time
figure();
plot(T,alt/1000,'-b','linewidth',2);
hold on;
plot([tpitch,tpitch],[0,1.2*max(alt/1000)],'--k','linewidth',2);
plot([tmeco,tmeco],[0,1.2*max(alt/1000)],'--k','linewidth',2);
plot([tseco,tseco],[0,1.2*max(alt/1000)],'--k','linewidth',2);
hold off;
xlabel('Time [s]');
ylabel('Altitude [km]');
xticks(0:60:max(T));
xlim([0,max(T)]);
ylim([0,1.1*max(alt/1000)]);

% Plot altitude vs. range
figure();
plot(range/1000,alt/1000,'-b','linewidth',2);
hold on;
plot([tpitch,tpitch],[0,1.2*max(alt/1000)],'--k','linewidth',2);
plot([tmeco,tmeco],[0,1.2*max(alt/1000)],'--k','linewidth',2);
plot([tseco,tseco],[0,1.2*max(alt/1000)],'--k','linewidth',2);
hold off;
xlabel('Range [km]');
ylabel('Altitude [km]');
xlim([0,max(range./1000)]);
ylim([0,1.1*max(alt/1000)]);

% Plot acceleration vs. time
figure();
plot(T,acc/g0,'-b','linewidth',2);
hold on;
plot([tpitch,tpitch],[0,1.2*max(acc/g0)],'--k','linewidth',2);
plot([tmeco,tmeco],[0,1.2*max(acc/g0)],'--k','linewidth',2);
plot([tseco,tseco],[0,1.2*max(acc/g0)],'--k','linewidth',2);
hold off;
xlabel('Time [s]');
ylabel('Acceleration [Gs]');
xticks(0:60:max(T));
xlim([0,max(T)]);
ylim([0,1.1*max(acc/g0)]);