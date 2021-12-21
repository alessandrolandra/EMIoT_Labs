clear all, close all
%% %Example of a distortion produced by varying an RGB channel intensity
A = imread("../images/4.2.06.tiff");
[R,G,B] = imsplit(A);
B=B*0.90;
Anew=cat(3,R,G,B);

SkyR=zeros(50,50);
SkyG=zeros(50,50);
SkyB=zeros(50,50);

SkyR=uint8(147);
SkyG=uint8(194);
SkyB=uint8(204);

Sky=cat(3,SkyR,SkyG,SkyB);

figure
subplot(1,3,1)
imshow(A)
title('Original image')
subplot(1,3,2)
imshow(Sky)
title('Zoom on sky')
subplot(1,3,3)
imshow(Anew)
title('Distorted image')