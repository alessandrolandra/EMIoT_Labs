clear all;
close all;

w0 = 1.48169521*10^-6;

A = imread("images/4.2.03.tiff");
Pimg = w0 + Ppxl(A);

imshow(A)
B = rgb2lab(A);
B(:,:,1) = B(:,:,1)*0.9;
C = lab2rgb(B);
figure
imshow(C)

matDiff(A,C)

function Ppxl = Ppxl(A)
    wg = 1.77746705*10^-7;
    wb = 2.14348309*10^-7;
    wr = 2.13636845*10^-7;
    y = 0.7755;
    Ppxl = 0;
    for row=1:size(A,1)
        for col=1:size(A,2)
            Ppxl = Ppxl + wr * power(double(A(row,col,1)),y) + wg * power(double(A(row,col,2)),y) + wb * power(double(A(row,col,3)),y);
        end    
    end
end

function matDiff = matDiff(A,B)
	matDiff = 0;
	for row=1:size(A,1)
		for col=1:size(A,2)
            matDiff = matDiff + sqrt(power(double((A(row,col,1)-B(row,col,1))),2) + power(double((A(row,col,2)-B(row,col,2))),2) + power(double((A(row,col,3)-B(row,col,3))),2));
		end
	end
end