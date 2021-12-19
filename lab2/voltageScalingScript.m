clear;
close all;
clc;

addpath([pwd, filesep, 'functions'])

SATURATED = 1;
Vdd = 12;

A = imread("images/4.2.03.tiff");

% load from the examples
%I_cell_matrix = load('currentSamples/sample_cell_current.mat');

I_cell_matrix = currentMat(A,Vdd);
image_RGB_saturated = displayed_image(I_cell_matrix, Vdd, SATURATED);

% During the lesson he said not to use distortion...bah...
%image_RGB_distorted = displayed_image(I_cell_sample, Vdd, 2);

subplot(2,1,1)
imshow(A);
subplot(2,1,2)
% originally was: image(image_RGB_saturated);
image(image_RGB_saturated);       % display saturated RGB image