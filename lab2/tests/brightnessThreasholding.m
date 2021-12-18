%% %Power saving script
   %All High Tone pixels (L: [200-250]) are transformed into middle tone pixels (L: [150-200])
   %All Low Tone pixels (L: [0-50]) are turned off
clear all, close all
A=imread("house.tiff");
PwrO=impwr(A);

%% %Apply Equalization
%Anew=imgeqz(A);
Anew=A;
%% %Figure(1)
figure
subplot(1,2,1)
imshow(A)
title('Original')
subplot(1,2,2)
imshow(Anew)
title('Equalized')

%% %Apply Thresholding on Brightness and Saturation 
Anew_Th=thresholding(Anew,2,2);

%% %Figure(2)
figure
subplot(1,3,1)
imshow(A)
title('Original')
subplot(1,3,2)
imshow(Anew)
title('Equalized')
subplot(1,3,3)
imshow(Anew_Th)
title('Equalized and Thresholding')

%% %Power Saved Equalization
PwrM=impwr(Anew);
Perc=(PwrM/PwrO)*100;

%% %Power Saved Equalization+Thresholding
PwrM_Th=impwr(Anew_Th);
Perc_Th=(PwrM_Th/PwrO)*100;

%% %Evaluation of original vs equalized distortion
distOrEq=matDiff(A,Anew);

%% %Evaluation of original vs equalized+thresholded distortion
distOrEq_Th=matDiff(A,Anew_Th);
