clear;
close all;
clc;

addpath([pwd, filesep, 'functions'])

A = imread("images/4.2.03.tiff");

B1 = rgb2lab(A);
B2 = B1;
B2(:,:,1) = B1(:,:,1)*0.8;%just reducing luminance in LAB
C = lab2rgb255(B2);

D1 = rgb2hsv(A);
D2 = D1;
D2(:,:,3) = D1(:,:,3)*0.8;%just reducing luminance in HSV
E = hsv2rgb255(D2);
B3 = rgb2lab(E);%needed to compute distortion

%% Figure LAB L reduced, HSV V reduced
figure
subplot(1,3,1)
imshow(A)
title('Original')
subplot(1,3,2)
imshow(C)
title('L reduced')
subplot(1,3,3)
imshow(E)
title('V reduced')

fprintf("LAB\nImage distortion: %f%%\n",matDistP(B1,B2));
fprintf("Power saving: %f%%\n\n",matSavingP(A,C));

fprintf("HSV\nImage distortion: %f%%\n",matDistP(B1,B3));
fprintf("Power saving: %f%%\n\n",matSavingP(A,E));

%Apply Equalization 
Aeq=imgeqz(A);

%Apply Thresholding on Brightness and Saturation 
Aeq_Th=thresholding(Aeq,2,2);

%% Figure Equalization and Thresholding
figure
subplot(1,3,1)
imshow(A)
title('Original')
subplot(1,3,2)
imshow(Aeq)
title('Equalized')
subplot(1,3,3)
imshow(Aeq_Th)
title('Equalized and Thresholding')

%% Histogram Equalization and Thresholding
figure
subplot(1,3,1)
imhist(A)
title('Original')
subplot(1,3,2)
imhist(Aeq)
title('Equalized')
subplot(1,3,3)
imhist(Aeq_Th)
title('Equalized and Thresholding')

%% %Power Saved Equalization
Perc=matSavingP(A,Aeq);

%% %Power Saved Equalization+Thresholding
Perc_Th=matSavingP(A,Aeq_Th);

%% %Evaluation of original vs equalized distortion
distOrEq=matDistP(A,Aeq);

%% %Evaluation of original vs equalized+thresholded distortion
distOrEq_Th=matDistP(A,Aeq_Th);

fprintf("Equalized\nImage distortion: %f%%\n",distOrEq);
fprintf("Power saving: %f%%\n\n",Perc);

fprintf("Equalized and Thresholding\nImage distortion: %f%%\n",distOrEq_Th);
fprintf("Power saving: %f%%\n\n",Perc_Th);
