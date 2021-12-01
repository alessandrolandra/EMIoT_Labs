clear all, close all
fid=fopen('./results/energy_under_tbe_wl2.txt');
line=fgetl(fid); %just consume the first line, not used
index=1;
while 1
   line=fgetl(fid);
   if ~ischar(line), break, end;
   line=split(line, ',');
   energy(index)=str2num(line{1,1});
   timeout(index)=str2num(line{2,1});
   index=index+1;
end
fclose(fid);
fid=fopen('./results/reportDelayW2.txt');
index=1;
while 1
   line=fgetl(fid);
   if ~ischar(line), break, end;
   line=split(line, ',');
   delay(index)=str2num(line{1,1});
   timeout2(index)=str2num(line{2,1});
   index=index+1;
end
fclose(fid);
figure
hold on
subplot(1,2,1)
plot(timeout,energy)
title('energy savings under Break Event Time')
ylabel('Energy (J)')
xlabel('Timeout (ms)')
subplot(1,2,2)
plot(timeout2,delay)
title('delays under Break Event Time')
ylabel('Delay (ms)')
xlabel('Timeout (ms)')
grid on
