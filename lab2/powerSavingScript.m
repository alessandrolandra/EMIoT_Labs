clear;
close all;
clc;

A = imread("images/4.2.03.tiff");

B1 = rgb2lab(A);
B2 = B1;
B2(:,:,1) = B1(:,:,1)*0.8;%just reducing luminance in LAB
C = lab2rgb(B2);

D1 = rgb2hsv(A);
D2 = D1;
D2(:,:,3) = D1(:,:,3)*0.8;%just reducing luminance in HSV
E = hsv2rgb(D2);
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
fprintf("Power saving: %f%%\n",matSavingP(A,C));

fprintf("HSV\nImage distortion: %f%%\n",matDistP(B1,B3));
fprintf("Power saving: %f%%\n",matSavingP(A,E));

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
fprintf("Power saving: %f%%\n",Perc);

fprintf("Equalized and Thresholding\nImage distortion: %f%%\n",distOrEq_Th);
fprintf("Power saving: %f%%\n",Perc_Th);





%% Power consumption evaluation in RGB
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

%% Power consumption saved in percentage (parameters order: original,new)
function matSavingP = matSavingP(A,B)
    matSavingP = (Pmat(A)-Pmat(B))*100/Pmat(A);
end

%% Image distortion evaluation in LAB
function matDist = matDist(A,B)
	matDist = 0;
	for row=1:size(A,1)
		for col=1:size(A,2)
            matDist = matDist + sqrt(power(double((A(row,col,1)-B(row,col,1))),2) + power(double((A(row,col,2)-B(row,col,2))),2) + power(double((A(row,col,3)-B(row,col,3))),2));
		end
	end
end

%% Image distortion percentage evaluation in LAB
function matDistP = matDistP(A,B)
	matDistP = (matDist(A,B)/(size(A,1)*size(A,2)*sqrt(power(100,2) + power(255,2) + power(255,2))))*100;
end

function Anew = imgeqz(A)
    %% %Histogram Adaptive Equalization
       %A= RGB input imgage
       %Transform image into HSV space and perform equalization
    Ahsv=rgb2hsv(A);
    V=Ahsv(:,:,3);
    V=adapthisteq(V);
    Ahsv(:,:,3)=V;
    Anew=hsv2rgb(Ahsv);
    Anew=uint8(Anew.*255);
end

function Anew = thresholding(A,Ms,Ns)
    %% %Function that compute Thresholding on Saturation (S) and Brightness (V)
       %A = Image in RGB space
       %MsxNs= Size of a image's sub-region
    Ahsv=rgb2hsv(A);
    V=Ahsv(:,:,3);
    S=Ahsv(:,:,2);
    
    Vavg=0.0;
    Savg=0.0;
    Vtmp=zeros(Ms,Ns);
    Stmp=zeros(Ms,Ns);
    for i=1:Ms:(size(A,1)-Ms)
        for j=1:Ns:(size(A,2)-Ns)
            %% Brightness and Saturation average in the sub-region
            Vavg=0.0;
            Bavg=0.0;
            for row=0:(Ms-1)
                for col=0:(Ns-1)
                    Vavg=double(V(row+i,col+j))+Vavg;
                    Savg=double(S(row+i,col+j))+Savg;
                    Vtmp(row+1,col+1)=V(row+i,col+j);
                    Stmp(row+1,col+1)=S(row+i,col+j);
                end
            end
            Vavg=Vavg/(Ns*Ms);
            Savg=Savg/(Ns*Ms);
            %% Thresholding on High Brightness (V=(70%,100%])
            if (Vavg>0.70)
                Vtmp=(Vtmp.*0) + 0.70;
            end
            %% Thresholding on Low Brightness (V=(0%,20%])
            if (Vavg<=0.20)
                Vtmp=(Vtmp.*0);
            end
            %% Write back modifications to V and S
            for row=0:(Ms-1)
                for col=0:(Ns-1)
                    V(row+i,col+j)=Vtmp(row+1,col+1);
                    S(row+i,col+j)=Stmp(row+1,col+1);
                end
            end
        end
    end
    
    Ahsv(:,:,3)=V;
    Ahsv(:,:,2)=S;
    Anew=hsv2rgb(Ahsv);
    Anew=uint8(Anew.*255);
end