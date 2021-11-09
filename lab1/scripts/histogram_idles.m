clear all, close all
fid=fopen('../dpm-simulator/example/wl_.txt');
index=1;
while 1
   line=fgetl(fid);
   if ~ischar(line), break, end;
   line=split(line,' ');
   
   t0=str2num(line{2,1});
   t1=str2num(line{3,1});
   idles(index)=t1-t0;
   index=index+1;
end
histogram(idles);
