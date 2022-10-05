function[] = rocketSizing()
%Rocket Sizing of the Direct Ascent Configuration

[mStagesDA, dvDA] = stageMasses(m0DA);
[mLOR, dvLOR] = stageMasses(m0LOR);
mDA(1) = mStagesDA(1) + mStagesDA(2) + mStagesDA(3) + m0DA;
mDA(2) = mStagesDA(2) + mStagesDA(3) + m0DA;
mDA(3) = mStagesDA(3) + m0DA;


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

end
