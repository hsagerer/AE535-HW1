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

x0 = [];
tstart = 0;
tstep = 0.01;
tend = 1;
time = tstart:tstep:tend;
[T,X] = ode45(@saturnVODE, time, x0);

