clear all, close all
fid=fopen('../workloads/workload_3.txt');
index=1
while 1
   line=fgetl(fid);
   if ~ischar(line), break, end;
   line=split(line,' ');
   t0=str2num(line{1,1});
   t1=str2num(line{2,1});
   for i=index:t0
      times(i)=1;
   end
   for i=t0:t1
      times(i)=0;
   end
   index=t1;
end

figure
hold on
title('WORKLOAD1: FAST SENSING')
ylabel('Activity')
xlabel('Time (ms)')
stem(times)
grid on
hold off