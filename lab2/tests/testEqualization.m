clear all, close all
%% %Test script that collects result coming from equalization applied to an entire set of images
set1="images/Set2/*.jpg";
Files=dir(set1);
Lenght=length(Files);
PwrsDiffs=zeros(1,Lenght);
DistDiffs=zeros(1,Lenght);
for k=1:Lenght
   image=Files(k).name;
   A=imread(image);
   p1=impwr(A);
   Anew=imgeqz(A);
   DistDiffs(k)=matDiff(A,Anew);
   p2=impwr(Anew);
   ps=(p2/p1)*100;
   PwrsDiffs(k)=100-ps;
end

%% %Compute Max and Min power saving
[Max,Imax]=max(PwrsDiffs);
[Min,Imin]=min(PwrsDiffs);
MaxName=Files(Imax).name;
MinName=Files(Imin).name;
Amax=imread(MaxName);
AnewMax=imgeqz(Amax);
Amin=imread(MinName);
AnewMin=imgeqz(Amin);

%% %Figure(1) plot results
figure
stem(DistDiffs,PwrsDiffs);
title('Power saving, distortion over the set')
ylabel('% Power saved')
xlabel('% Distortion')

%% %Figure(2) show max
figure
subplot(2,2,1)
imshow(Amax)
title('Original image')
subplot(2,2,2)
imshow(AnewMax)
title('Equalized image')
subplot(2,2,3)
imhist(Amax)
title('Original Histogram')
subplot(2,2,4)
imhist(AnewMax)
title('Equalized Histogram')

%% %Figure(3) show min
figure
subplot(2,2,1)
imshow(Amin)
title('Original image')
subplot(2,2,2)
imshow(AnewMin)
title('Equalized image')
subplot(2,2,3)
imhist(Amin)
title('Original Histogram')
subplot(2,2,4)
imhist(AnewMin)
title('Equalized Histogram')