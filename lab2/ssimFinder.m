clear;
close all;
clc;

addpath([pwd, filesep, 'functions'])

SATURATED = 1;
Vdd = 14;
arrA = [];
arrB1 = [];
bArr = [];

imgs = dir("images/Set1");
for k = 1:length(imgs)
    if ~startsWith(imgs(k).name,'.')
        tmpA = imread("images/Set1/"+imgs(k).name);
        arrA{end + 1} = tmpA;
        arrB1{end + 1} = rgb2hsv(tmpA);
    end
end
arrLength = length(arrA);

while Vdd>7
    b = 0.025;
    avg = 0;
    while avg==0 || avg>0.9
        sum = 0;
        prevAvg = avg;
        for k = 1:arrLength
            ImatrixOriginal = currentMat(arrA{k},Vdd);
            
            B2 = arrB1{k};
            B2(:,:,3) = B2(:,:,3)+b;%Brightness compensation
            C = hsv2rgb255(B2);        
            
            ImatrixModified = currentMat(C,Vdd);
            displayedRGBOriginal = displayed_image(ImatrixOriginal, Vdd, SATURATED)/255;
            displayedRGBModified = displayed_image(ImatrixModified, Vdd, SATURATED)/255;
            
            %% function used to see how much the two images look similar
            sum = sum + ssim(displayedRGBOriginal,displayedRGBModified);
        end
        avg = sum/arrLength;    
        b = b + 0.025;
    end
    b = b - 0.025;
    fprintf("Vdd: %d, b: %f, average SSIM: %f\n",Vdd,b,prevAvg);
    bArr(end + 1) = b;
    Vdd = Vdd - 1;
end