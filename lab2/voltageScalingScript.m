clear;
close all;
clc;

addpath([pwd, filesep, 'functions'])

SATURATED = 1;
Vdd0 = 15; % original Vdd is 15
Vdd = 12;

%% Empirically determined brightness compensation parameter (-> SSIM > 0.9) from Vdd = 14 downto 8
bArr = [0.175,0.175,0.2,0.2,0.2,0.225,0.25];
b = bArr(15-Vdd);

imgs = dir("images/Set1");
%imgs = dir("images/Set2");
n = 1;
for k = 1:length(imgs)
    if ~startsWith(imgs(k).name,'.')
        A = imread("images/Set1/"+imgs(k).name);
        %A = imread("images/Set2/"+imgs(k).name);

        B1 = rgb2hsv(A);
        L1 = rgb2lab(A);
        B2 = B1;
        B2(:,:,3) = B1(:,:,3)+b;%Brightness compensation
        C = hsv2rgb255(B2);
        L2 = rgb2lab(C);
        
        D = dvsThresholding(A,Vdd);
        B3 = rgb2hsv(D);
        L3 = rgb2lab(D);
        
        ImatrixOriginal = currentMat(A,Vdd);
        ImatrixModified = currentMat(C,Vdd);
        ImatrixModifiedTh = currentMat(D,Vdd);
        displayedRGBOriginal = displayed_image(ImatrixOriginal, Vdd, SATURATED);
        displayedRGBModified = displayed_image(ImatrixModified, Vdd, SATURATED);
        displayedRGBModifiedTh = displayed_image(ImatrixModifiedTh, Vdd, SATURATED);
        
        fprintf("Figure %d\n\n",n);
        figure
        subplot(2,2,1)        
        imshow(A);
        title("Original");
        subplot(2,2,2)        
        image(displayedRGBOriginal/255);
        title("DVS only");
        fprintf("No brightness compensation\nPower saving: %f%%\n\n",vsSavingP(ImatrixOriginal,Vdd0,ImatrixOriginal,Vdd));
        subplot(2,2,3)
        image(displayedRGBModified/255);
        title("Fixed brightness comp");
        fprintf("Fixed brightness compensation parameter\nImage distortion: %f%%\n",matDistP(L1,L2));
        fprintf("Power saving: %f%%\n\n",vsSavingP(ImatrixOriginal,Vdd0,ImatrixModified,Vdd)); % negative due to the fact that we are increasing the quality..
        subplot(2,2,4)        
        image(displayedRGBModifiedTh/255);
        title("Thresholded brightness comp");
        fprintf("Thresholded brightness compensation parameter\nImage distortion: %f%%\n",matDistP(L1,L3));
        fprintf("Power saving: %f%%\n\n--------\n\n",vsSavingP(ImatrixOriginal,Vdd0,ImatrixModifiedTh,Vdd)); % negative due to the fact that we are increasing the quality..
        n = n + 1;
    end
end

