clear;
close all;
clc;

addpath([pwd, filesep, 'functions'])

SATURATED = 1;
Vdd1 = 12;
Vdd2 = 12;
b = 0.1;

A = imread("images/4.2.03.tiff");

B1 = rgb2hsv(A);
B2 = B1;
B2(:,:,3) = B1(:,:,3)+b;%Brightness compensation
C = hsv2rgb255(B2);

% load from the examples
% load('currentSamples/sample_cell_current.mat');

ImatrixOriginal = currentMat(A,Vdd1);
ImatrixModified = currentMat(C,Vdd1);
displayedRGBOriginal = displayed_image(ImatrixOriginal, Vdd2, SATURATED);
displayedRGBModified = displayed_image(ImatrixModified, Vdd2, SATURATED);

% During the lesson he said not to use distortion...bah...
%image_RGB_distorted = displayed_image(I_cell_sample, Vdd, 2);

subplot(3,1,1)
imshow(A);
subplot(3,1,2)
image(displayedRGBOriginal/255);
subplot(3,1,3)
image(displayedRGBModified/255);
fprintf("Image distortion: %f%%\n",matDistP(B1,B2));
fprintf("Power saving: %f%%\n\n",vsSavingP(ImatrixOriginal,ImatrixModified,Vdd2));