function[] = rocketSizing()
%Rocket Sizing of the Direct Ascent Configuration

ThrustRP1 = 6770e3;
ThrustLH2SL = 486.2e3;
ThrustLH2VA = 1033e3;

m0DA = directAscentPayload();
m0LOR = LORPayload();

[mStagesDA, dvDA] = stageMasses(m0DA);
[mStagesLOR, dvLOR] = stageMasses(m0LOR);

mDA(1) = mStagesDA(1) + mStagesDA(2) + mStagesDA(3) + m0DA;
mDA(2) = mStagesDA(2) + mStagesDA(3) + m0DA;
mDA(3) = mStagesDA(3) + m0DA;

mLOR(1) = mStagesLOR(1) + mStagesLOR(2) + mStagesLOR(3) + m0LOR;
mLOR(2) = mStagesLOR(2) + mStagesLOR(3) + m0LOR;
mLOR(3) = mStagesLOR(3) + m0LOR;

Isp = [283,311,421];
TW1 = 1.2;
TW2 = 0.7;
TW3 = 0.5;
g0 = 9.81;

% Direct Ascent Ignition Thrusts
igDA1 = mDA(1)*TW1;
igDA2 = mDA(2)*TW2;
igDA3 = mDA(3)*TW3;

igDA = [igDA1,igDA2,igDA3];

% LOR Ignition Thrusts
igLOR1 = mLOR(1)*TW1;
igLOR2 = mLOR(2)*TW2;
igLOR3 = mLOR(3)*TW2;

igLOR = [igLOR1,igLOR2,igLOR3];

% Direct Ascent Flow Rate

frDA1 = igDA1/(Isp(1)*g0);
frDA2 = igDA2/(Isp(2)*g0);
frDA3 = igDA3/(Isp(3)*g0);

frDA = [frDA1,frDA2,frDA3];

% LOR Flow Rate

frLOR1 = igLOR1/(Isp(1)*g0);
frLOR2 = igLOR2/(Isp(2)*g0);
frLOR3 = igLOR3/(Isp(3)*g0);

frLOR = [frLOR1,frLOR2,frLOR3];

% Propellant Mass and tB DA

mpDA1 = mDA(1)*(1-exp(-dvDA(1)/(g0*Isp(1))));
tBDA1 = mpDA1/frDA1;
mpDA2 = mDA(2)*(1-exp(-dvDA(2)/(g0*Isp(2))));
tBDA2 = mpDA2/frDA2;
mpDA3 = mDA(3)*(1-exp(-dvDA(3)/(g0*Isp(3))));
tBDA3 = mpDA3/frDA3;

tBDA = [tBDA1,tBDA2,tBDA3];
 
% Propellant Mass and tB LOR

mpLOR1 = mLOR(1)*(1-exp(-dvLOR(1)/(g0*Isp(1))));
tBLOR1 = mpLOR1/frLOR1;
mpLOR2 = mLOR(2)*(1-exp(-dvLOR(2)/(g0*Isp(2))));
tBLOR2 = mpLOR2/frLOR2;
mpLOR3 = mLOR(3)*(1-exp(-dvLOR(3)/(g0*Isp(3))));
tBLOR3 = mpLOR3/frLOR3;

tBLOR = [tBLOR1,tBLOR2,tBLOR3];

% Thrust to Weight to Determine Engine # DA

TDA1 = mDA(1)*TW1;
engineNumDA1 = ceil(TDA1/ThrustRP1);

TDA2 = mDA(2)*TW2;
engineNumDA2 = ceil(TDA2/ThrustLH2SL);

TDA3 = mDA(3)*TW3;
engineNumDA3 = ceil(TDA3/ThrustLH2VA);

engineNumDA = [engineNumDA1,engineNumDA2,engineNumDA3];

% Thrust to Weight to Determine Engine # LOR

TLOR1 = mLOR(1)*TW1;
engineNumLOR1 = ceil(TLOR1/ThrustRP1);

TLOR2 = mLOR(2)*TW2;
engineNumLOR2 = ceil(TLOR2/ThrustLH2SL);

TLOR3 = mLOR(3)*TW3;
engineNumLOR3 = ceil(TLOR3/ThrustLH2VA);

engineNumLOR = [engineNumLOR1,engineNumLOR2,engineNumLOR3];
end
