clear;
close all;
clc;

A = imread("images/4.2.03.tiff");
imshow(A)

B1 = rgb2lab(A);
B2 = B1;
B2(:,:,1) = B1(:,:,1)*0.8;%just reducing luminance in LAB
C = lab2rgb(B2);
figure
imshow(C)

fprintf("Image distortion: %f%%\n",matDistP(B1,B2));
fprintf("Power saving: %f%%\n",matSavingP(A,C));

D1 = rgb2hsv(A);
D2 = D1;
D2(:,:,3) = D1(:,:,3)*0.8;%just reducing luminance in HSV
E = hsv2rgb(D2);
B3 = rgb2lab(E);%needed to compute distortion
figure
imshow(E)

fprintf("Image distortion: %f%%\n",matDistP(B1,B3));
fprintf("Power saving: %f%%\n",matSavingP(A,E));

%Power consumption evaluation in RGB
function Pmat = Pmat(A)
    w0 = 1.48169521*10^-6;
    wg = 1.77746705*10^-7;
    wb = 2.14348309*10^-7;
    wr = 2.13636845*10^-7;
    y = 0.7755;
    Pmat = 0;
    for row=1:size(A,1)
        for col=1:size(A,2)
            Pmat = Pmat + wr * power(double(A(row,col,1)),y) + wg * power(double(A(row,col,2)),y) + wb * power(double(A(row,col,3)),y);
        end    
    end
    Pmat = Pmat + w0;
end

function matSavingP = matSavingP(A,B)
    matSavingP = (Pmat(A)-Pmat(B))*100/Pmat(A);
end

%Image distortion evaluation in LAB
function matDist = matDist(A,B)
	matDist = 0;
	for row=1:size(A,1)
		for col=1:size(A,2)
            matDist = matDist + sqrt(power(double((A(row,col,1)-B(row,col,1))),2) + power(double((A(row,col,2)-B(row,col,2))),2) + power(double((A(row,col,3)-B(row,col,3))),2));
		end
	end
end

%Image distortion percentage evaluation in LAB
function matDistP = matDistP(A,B)
	matDistP = (matDist(A,B)/(size(A,1)*size(A,2)*sqrt(power(100,2) + power(255,2) + power(255,2))))*100;
end