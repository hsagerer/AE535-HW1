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
fprintf('LV Payload Mass of LOR: %0.0f kg\n',round(m0LOR,4,'significant'));