clear all, close all
%% Irradiance over time
load('gmonths.mat');
figure
hold on, grid on
title('Irradiance over time')
ylabel('Irradiance (W/mˆ2)')
xlabel('Time (s)')
plot(Gmonth(:,1),Gmonth(:,2))
hold off

%% V,I values from digitizer
Vi1000=readtable('PVcell/Digit1000.txt');
Vi1000=table2array(Vi1000);
Vi750=readtable('PVcell/Digit750.txt');
Vi750=table2array(Vi750);
Vi500=readtable('PVcell/Digit500.txt');
Vi500=table2array(Vi500);
Vi250=readtable('PVcell/Digit250.txt');
Vi250=table2array(Vi250);

figure
hold on, grid on
title('I,V values digitized from datasheet')
ylabel('Current (A)')
xlabel('Voltage (V)')
plot(Vi1000(:,1),Vi1000(:,2),'red')
plot(Vi750(:,1),Vi750(:,2),'green')
plot(Vi500(:,1),Vi500(:,2),'black')
plot(Vi250(:,1),Vi250(:,2),'blue')
legend({'1000W/mˆ2','750W/mˆ2','500/mˆ2','250W/mˆ2'},'Location','northeast')
hold off

%% MPP (P,V) 
P1000=Vi1000(:,1) .* Vi1000(:,2); 
P750=Vi750(:,1)  .* Vi750(:,2);
P500=Vi500(:,1)  .* Vi500(:,2);
P250=Vi250(:,1)  .* Vi250(:,2);

figure
hold on, grid on
title('(P,V) MPP diagram')
ylabel('Power (W)')
xlabel('Voltage (V)')
plot(Vi1000(:,1),P1000,'red')
plot(Vi750(:,1),P750,'green')
plot(Vi500(:,1),P500,'black')
plot(Vi250(:,1),P250,'blue')
legend({'1000W/mˆ2','750W/mˆ2','500/mˆ2','250W/mˆ2'},'Location','northeast')
hold off

%% Vectors for PV model (G,Impp,Vmpp)
G = [250,500,750,1000];
%
[tmp,i] = max(P250);
V(1)=Vi250(i,1);
I(1)=Vi250(i,2);
%
[tmp,i] = max(P500);
V(2)=Vi500(i,1);
I(2)=Vi500(i,2);
%
[tmp,i] = max(P750);
V(3)=Vi750(i,1);
I(3)=Vi750(i,2);
%
[tmp,i] = max(P1000);
V(4)=Vi1000(i,1);
I(4)=Vi1000(i,2);

%% PV DC/DC Efficiency values, from digitizer
Epv=readtable('PV_DCDCconv/DigitPVconv.txt');
Epv=table2array(Epv);
Vpv=Epv(:,1);
Epv=Epv(:,2) / 100;
figure
hold on, grid on
title('Efficiency PV DC/DC converter')
ylabel('Efficiency')
xlabel('Input Voltage (V)')
plot(Vpv,Epv)
hold off


%% Battery DC/DC Eficiency values, from digitizer
Ebatt=readtable('Battery_DCDCconv/DigitBatteryConv.txt');
Ebatt=table2array(Ebatt);
Ibatt=Ebatt(:,1);
Ebatt=Ebatt(:,2) / 100;

figure
hold on, grid on
title('Efficiency Battery DC/DC converter')
ylabel('Efficiency')
xlabel('Input Current (A)')
plot(Ibatt,Ebatt)
hold off

%% Battery model state of charge
SoC1=readtable('Battery/RED_digit.txt');
SoC1=table2array(SoC1);
SoC2=readtable('Battery/GREEN_digit.txt');
SoC2=table2array(SoC2);
%mAh-->Ah
SoC1(:,1) = SoC1(:,1) ./ 1000;
SoC2(:,1) = SoC2(:,1) ./ 1000;
figure
hold on, grid on
title('Voltage,Discharge Capacity values digitized from datasheet')
ylabel('Voltage (V)')
xlabel('Discharge Capacity (Ah)')
plot(SoC1(:,1),SoC1(:,2),'red')
plot(SoC2(:,1),SoC2(:,2),'green')
legend({'0.5C','1C'},'Location','northeast')
hold off
%Transform the Discharge capacity into a SoC, that is a percentage
i=size(SoC1);
i=i(1);
soc_min=SoC1(i,1);
SoC1(:,1) = 1 - (SoC1(:,1) ./ soc_min);
i=size(SoC2);
i=i(1);
soc_min=SoC2(i,1);
SoC2(:,1) = 1 - (SoC2(:,1) ./ soc_min);
figure
hold on, grid on
title('Voltage,State of charge')
ylabel('Voltage (V)')
xlabel('State of Charge')
plot(SoC1(:,1),SoC1(:,2),'red')
plot(SoC2(:,1),SoC2(:,2),'green')
legend({'0.5C','1C'},'Location','northeast')
hold off
% interpolation with 10 samples
NewX=0:0.1:1;
NewY1=interp1(SoC1(:,1),SoC1(:,2),NewX);
NewY2=interp1(SoC2(:,1),SoC2(:,2),NewX);
figure
hold on, grid on
title('Voltage,State of charge INTERPOLATED')
ylabel('Voltage (V)')
xlabel('State of Charge')
plot(NewX,NewY1,'red')
plot(NewX,NewY2,'green')
legend({'0.5C','1C'},'Location','northeast')
hold off
% R samples, 1C=3200mA, 0.5C=1600mA
Rsoc = (NewY1 - NewY2)/1.600;
Rsoc_poly=Rsoc_func(NewX, Rsoc);
% Voc
Voc = NewY1 + Rsoc*1.600;
Voc_poly=Voc_func(NewX, Voc);
%% load configurations
config







