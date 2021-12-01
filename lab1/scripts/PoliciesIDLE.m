clear all, close all
fid1=fopen('./results/wl1_history0_200_IDLE.txt');
fid2=fopen('./report.txt');
index=1;
total_energy=str2num(fgetl(fid2));
while 1
   line1=fgetl(fid1);
   line2=fgetl(fid2);
   if ~ischar(line1), break, end;
   if ~ischar(line2), break, end;
   line1=split(line1, ',');
   line2=split(line2, ',');
   energy1(index)=str2num(line1{1,1});
   timeout(index)=str2num(line1{2,1});
   energy2(index)=str2num(line2{1,1});
   threshold(index)=str2num(line2{2,1});
   index=index+1;
end
figure
hold on
title('energy savings comparison: Timeout policy vs History predictor policy')
ylabel('Energy (J)')
xlabel('Timeout || Threshold (ms)')
plot(timeout,energy1)
plot(threshold,energy2)
legend({'History','Timeout'},'Location','southwest')
grid on