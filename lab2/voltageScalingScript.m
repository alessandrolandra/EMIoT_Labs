clear;
close all;
clc;

addpath([pwd, filesep, 'functions'])

SATURATED = 1;
Vdd0 = 15; % original Vdd is 15
Vdd = 12;

%% Empirically determined brightness compensation parameter
b = (Vdd0-Vdd)/12;

A = imread("images/4.2.03.tiff");

B1 = rgb2hsv(A);
B2 = B1;
B2(:,:,3) = B1(:,:,3)+b;%Brightness compensation
C = hsv2rgb255(B2);

% load from the examples
% load('currentSamples/sample_cell_current.mat');

ImatrixOriginal = currentMat(A,Vdd);
ImatrixModified = currentMat(C,Vdd);
displayedRGBOriginal = displayed_image(ImatrixOriginal, Vdd, SATURATED);
displayedRGBModified = displayed_image(ImatrixModified, Vdd, SATURATED);

% During the lesson he said not to use distortion...bah...
%image_RGB_distorted = displayed_image(I_cell_sample, Vdd, 2);

subplot(1,3,1)
imshow(A);
subplot(1,3,2)
image(displayedRGBOriginal/255);
subplot(1,3,3)
image(displayedRGBModified/255);
fprintf("Image distortion: %f%%\n",matDistP(B1,B2));
fprintf("Power saving: %f%%\n\n",vsSavingP(ImatrixOriginal,ImatrixModified,Vdd)); % negative due to the fact that we are increasing the quality..