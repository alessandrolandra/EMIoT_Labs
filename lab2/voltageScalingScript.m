clear;
close all;
clc;

addpath([pwd, filesep, 'functions'])

SATURATED = 1;
Vdd0 = 15; % original Vdd is 15
Vdd = 12;

%% Empirically determined brightness compensation parameter (-> SSIM > 0.9)
b = (Vdd0-Vdd)/13;

A = imread("images/4.2.03.tiff");

B1 = rgb2hsv(A);
B2 = B1;
B2(:,:,3) = B1(:,:,3)+b;%Brightness compensation
C = hsv2rgb255(B2);

%% function used to see how much the two images look similar
% ssim(A,C)

D = dvsThresholding(A);
B3 = rgb2hsv(D);

% load from the examples
% load('currentSamples/sample_cell_current.mat');

ImatrixOriginal = currentMat(A,Vdd);
ImatrixModified = currentMat(C,Vdd);
ImatrixModifiedTh = currentMat(D,Vdd);
displayedRGBOriginal = displayed_image(ImatrixOriginal, Vdd, SATURATED);
displayedRGBModified = displayed_image(ImatrixModified, Vdd, SATURATED);
displayedRGBModifiedTh = displayed_image(ImatrixModifiedTh, Vdd, SATURATED);

% During the lesson he said not to use distortion...bah...
%image_RGB_distorted = displayed_image(I_cell_sample, Vdd, 2);

subplot(1,4,1)
imshow(A);
subplot(1,4,2)
image(displayedRGBOriginal/255);
subplot(1,4,3)
image(displayedRGBModified/255);
fprintf("Fixed brightness compensation parameter\nImage distortion: %f%%\n",matDistP(B1,B2));
fprintf("Power saving: %f%%\n\n",vsSavingP(ImatrixOriginal,ImatrixModified,Vdd)); % negative due to the fact that we are increasing the quality..
subplot(1,4,4)
image(displayedRGBModifiedTh/255);
fprintf("Thresholded brightness compensation parameter\nImage distortion: %f%%\n",matDistP(B1,B3));
fprintf("Power saving: %f%%\n\n",vsSavingP(ImatrixOriginal,ImatrixModifiedTh,Vdd)); % negative due to the fact that we are increasing the quality..