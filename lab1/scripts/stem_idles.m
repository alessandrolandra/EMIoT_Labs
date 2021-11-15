%SCRIPT USED TO REPORT HOW MANY IDLE TIMES ARE LESS THEN THE BREAK EVENT TIME
%USEFUL TO UNDERSTAND WHY DO WE HAVE A MINIMUM OF THE FUNCTION IN THAT PARTICULAR TIMEOUT
%IDLE TIMES = TO '0' ARE NOT CONSIDERED
clear all, close all
fid=fopen('../workloads/workload_2.txt');
tbe=0.8;
for i=1:1
   idles(i)=0; 
end

while 1
   line=fgetl(fid);
   if ~ischar(line), break, end;
   line=split(line,' ');
   t0=str2num(line{1,1});
   t1=str2num(line{2,1});
   if ((t1-t0)<tbe & (t1-t0)>0)
       idles(t1-t0)=idles(t1-t0)+1;
       fprintf("Idle less then Tbe. START=%d END=%d DIFF=%d\n",t0,t1,(t1-t0));
   end
end
stem(idles)