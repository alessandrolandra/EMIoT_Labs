%%% ***SIMULATION SECTION*** %%%
%%1)RUN main.m before this script
%%2)RUN simulink simulation BEFORE this script and AFTER main.m

%% LOAD profile
sim_period = 1:1:120;
% LOAD are activated periodically every 120 s
figure
hold on, grid on
title('Load profile, 120s period')
ylabel('Current (A)')
xlabel('Time (s)')
plot(sim_period,micI(1:120),'red')
plot(sim_period,airI(1:120),'green')
plot(sim_period,methI(1:120),'blue')
plot(sim_period,tempI(1:120),'cyan')
plot(sim_period,mcI(1:120),'black')
plot(sim_period,zbI(1:120),'magenta')
legend({'Microphone','Air quality','Methane','Temperature','Memory & Control','ZigBee'},'Location','northeast')
hold off

%% PV delivery vs Battery Delivery
sim_duration=1:1:size(Gcurve);
figure
hold on, grid on
ylabel('Power (W)')
xlabel('Time (s)')
subplot(2,1,1)
plot(sim_duration,PVpower,'green')
title('PV production')
subplot(2,1,2)
plot(sim_duration,batteryPower,'red')
title('Battery production')
hold off

%% Battery state of charge
figure
hold on, grid on
subplot(2,1,1)
plot(sim_duration,battSOC,'black')
title('State of charge')
ylabel('State of charge')
xlabel('Time (s)')
subplot(2,1,2)
plot(sim_duration,battVoltage,'blue')
title('Voltage')
ylabel('Voltage (V)')
xlabel('Time (s)')
hold off

%% Efficiencies (PV DC/DC and Battery DC/DC)
figure
hold on, grid on
title('DC/DCs efficiency')
ylabel('Efficiency')
xlabel('Time (s)')
plot(sim_duration,efficiencyBattery,'red')
plot(sim_duration,efficiencyPV,'green')
legend({'Battery DC/DC','PV DC/DC'},'Location','northeast')
hold off


%% backup
battEff1=efficiencyBattery;
PVeff1=efficiencyPV;
battSOC1=battSOC;
battVol1=battVoltage;
duration1=sim_duration;

%% Evaluation with different scheduling.
% 1)Lunch this section
% 2)Lunch again simulink simulation
% 3)After previous steps (1 and 2) y can proceed with sections below
%ALL delays are 0 --> every load request happen in parallel increase the average peak current request
air_delay = 0; 
methane_delay = 0; 
temp_delay = 0; 
mic_delay = 0;
mc_delay = 0; 
transmit_delay = 0;

%% Compare different approaches
sim_duration=1:1:size(Gcurve);

figure
hold on, grid on
title('Load profile, 120s period')
ylabel('Current (A)')
xlabel('Time (s)')
plot(sim_period,micI(1:120),'red')
plot(sim_period,airI(1:120),'green')
plot(sim_period,methI(1:120),'blue')
plot(sim_period,tempI(1:120),'cyan')
plot(sim_period,mcI(1:120),'black')
plot(sim_period,zbI(1:120),'magenta')
legend({'Microphone','Air quality','Methane','Temperature','Memory & Control','ZigBee'},'Location','northeast')
hold off
figure
hold on, grid on
title('LIFETIME comparison')
ylabel('Voltage (V)')
xlabel('Time (s)')
plot(duration1,battVol1,'red')
plot(sim_duration,battVoltage,'green')
legend({'Schedule 0','Schedule1'},'Location','northeast')
hold off


%% backup & New config
battEff2=efficiencyBattery;
PVeff2=efficiencyPV;
battSOC2=battSOC;
battVol2=battVoltage;
duration2=sim_duration;

air_delay = 0; 
methane_delay = 30; 
temp_delay = 66; 
mic_delay = 72;
mc_delay = 60; 
transmit_delay = 72;


%% Compare (Run simulink again..)
sim_duration=1:1:size(Gcurve);

figure
hold on, grid on
title('Load profile, 120s period')
ylabel('Current (A)')
xlabel('Time (s)')
plot(sim_period,micI(1:120),'red')
plot(sim_period,airI(1:120),'green')
plot(sim_period,methI(1:120),'blue')
plot(sim_period,tempI(1:120),'cyan')
plot(sim_period,mcI(1:120),'black')
plot(sim_period,zbI(1:120),'magenta')
legend({'Microphone','Air quality','Methane','Temperature','Memory & Control','ZigBee'},'Location','northeast')
hold off
figure
hold on, grid on
title('LIFETIME comparison, best scheduling')
ylabel('Voltage (V)')
xlabel('Time (s)')
plot(duration2,battVol2,'red')
plot(duration3,battVol3,'blue')
plot(sim_duration,battVoltage,'green')
legend({'1 PV cell','2 PV cells in parallel','3 PV cells in parallel'},'Location','northeast')
hold off

figure
hold on, grid on
title('PV efficiency comparison')
ylabel('Efficiency')
xlabel('Time (s)')
plot(duration1,PVeff1,'red')
plot(sim_duration,efficiencyPV,'blue')
legend({'1 PV cell','2 PV cells in series'},'Location','northeast')
hold off




