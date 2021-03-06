clear;
close all;
clc;

addpath([pwd, filesep, 'functions'])

SATURATED = 1;
Vdd0 = 15; % original Vdd is 15
Vdd = 11;

%% Empirically determined brightness compensation parameter (-> SSIM > 0.9) from Vdd = 14 downto 8
bArr = [0.175,0.175,0.2,0.2,0.2,0.225,0.25];
b = bArr(15-Vdd);

imgs = dir("images/Set1");
%imgs = dir("images/Set2");
n = 1;
fixedDistSum = 0;
fixedPSSum = 0;
thresholdedDistSum = 0;
thresholdedPSSum = 0;
for k = 1:length(imgs)
    if ~startsWith(imgs(k).name,'.')
        A = imread("images/Set1/"+imgs(k).name);
        %A = imread("images/Set2/"+imgs(k).name);

        B1 = rgb2hsv(A);
        L1 = rgb2lab(A);
        B2 = B1;
        B2(:,:,3) = B1(:,:,3)+b;%Brightness compensation
        C = hsv2rgb255(B2);
        
        D = dvsThresholding(A,Vdd);
        
        ImatrixOriginal = currentMat(A,Vdd);
        ImatrixModified = currentMat(C,Vdd);
        ImatrixModifiedTh = currentMat(D,Vdd);
        displayedRGBOriginal = displayed_image(ImatrixOriginal, Vdd, SATURATED);
        LdisplayedOri = rgb2lab(displayedRGBOriginal/255);
        displayedRGBModified = displayed_image(ImatrixModified, Vdd, SATURATED);
        LdisplayedM = rgb2lab(displayedRGBModified/255);
        displayedRGBModifiedTh = displayed_image(ImatrixModifiedTh, Vdd, SATURATED);
        LdisplayedMTh = rgb2lab(displayedRGBModifiedTh/255);
        
        fprintf("Figure %d\n\n",n);
        figure
        subplot(2,2,1)        
        imshow(A);
        title("Original");
        subplot(2,2,2)        
        image(displayedRGBOriginal/255);
        dvsDist = matDistP(L1,LdisplayedOri);
        title("DVS only");
        fprintf("No brightness compensation\nImage distortion: %f%%\n",dvsDist);
        fprintf("Power saving: %f%%\n\n",vsSavingP(ImatrixOriginal,Vdd0,ImatrixOriginal,Vdd));
        subplot(2,2,3)
        image(displayedRGBModified/255);
        title("Fixed brightness comp");
        fixedDist = matDistP(L1,LdisplayedM);
        fixedDistSum = fixedDistSum + fixedDist;
        fixedPS = vsSavingP(ImatrixOriginal,Vdd0,ImatrixModified,Vdd);
        fixedPSSum = fixedPSSum + fixedPS;
        fprintf("Fixed brightness compensation parameter\nImage distortion: %f%%\n",fixedDist);
        fprintf("Power saving: %f%%\n\n",fixedPS); % can be also negative, due to the fact that we are increasing the quality..
        subplot(2,2,4)        
        image(displayedRGBModifiedTh/255);
        title("Thresholded brightness comp");
        thresholdedDist = matDistP(L1,LdisplayedMTh);
        thresholdedDistSum = thresholdedDistSum + thresholdedDist;
        thresholdedPS = vsSavingP(ImatrixOriginal,Vdd0,ImatrixModifiedTh,Vdd);
        thresholdedPSSum = thresholdedPSSum + thresholdedPS;
        fprintf("Thresholded brightness compensation parameter\nImage distortion: %f%%\n",thresholdedDist);
        fprintf("Power saving: %f%%\n\n--------\n\n",thresholdedPS); % can be also negative, due to the fact that we are increasing the quality..
        n = n + 1;
    end
end
fprintf("Fixed brightness compensation parameter\nAverage distortion: %f%%\nAverage power saving: %f%%\n",fixedDistSum/n,fixedPSSum/n);
fprintf("Thresholded brightness compensation parameter\nAverage distortion: %f%%\nAverage power saving: %f%%\n",thresholdedDistSum/n,thresholdedPSSum/n);