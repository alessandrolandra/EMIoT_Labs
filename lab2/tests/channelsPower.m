clear all,close all
%Channels power comparison
%Changing each channel intensity from 0 to 100%
K=0:0.1:1;
A = imread("../images/4.2.03.tiff");
[R,G,B] = imsplit(A);

%RED
R255=R+255;
%GREEN
G255=G+255;
%BLUE
B255=B+255;
%BLACK
R0=R*0;
G0=G*0;
B0=B*0;

%%
% RED EVALUATION
a=chI(R255)*255;
b=chI(G0)*255;
c=chI(B0)*255;
RedIntensities=[a,b,c];

%Power variations wrt Red channel variations
for i=1:size(K,2)
    PwrR(i)=impwr(cat(3,R255*K(i),G0,B0));
end

%%
% GREEN EVALUATION
a=chI(R0)*255;
b=chI(G255)*255;
c=chI(B0)*255;
GreenIntensities=[a,b,c];

%Power variations wrt Green channel variations
for i=1:size(K,2)
    PwrG(i)=impwr(cat(3,R0,G255*K(i),B0));
end

%%
% BLUE EVALUATION
a=chI(R0)*255;
b=chI(G0)*255;
c=chI(B255)*255;
BlueIntensities=[a,b,c];

%Power variations wrt Blue channel variations
for i=1:size(K,2)
    PwrB(i)=impwr(cat(3,R0,G0,B255*K(i)));
end

%%
% WHITE EVALUATION
a=chI(R255)*255;
b=chI(G255)*255;
c=chI(B255)*255;
WhiteIntensities=[a,b,c];

%Max power variation for an N*M image
PwrW(1)=impwr(cat(3,R255,G255,B255));
for i=2:size(K,2)
    PwrW(i)=PwrW(1);
end

figure
subplot(3,3,2)
imshow(cat(3,R0,G0,B0))
title('Black image (R=0,G=0,B=0)')
subplot(3,3,4)
imshow(cat(3,R255,G0,B0))
title('Red image (R=255,G=0,B=0)')
subplot(3,3,5)
imshow(cat(3,R0,G255,B0))
title('Green image (R=0,G=255,B=0)')
subplot(3,3,6)
imshow(cat(3,R0,G0,B255))
title('Blue image (R=0,G=0,B=255)')
subplot(3,3,8)
imshow(cat(3,R255,G255,B255))
title('White image (R=255,G=255,B=255)')

K=K*255;

figure
hold on, grid on
title('Power variations wrt channels intensity variations')
ylabel('Power')
xlabel('intensity variation')
plot(K,PwrR,'red')
plot(K,PwrG,'green')
plot(K,PwrB,'blue')
plot(K,PwrW,'black')
legend({'Red','Green','Blue','white (MAX)'},'Location','southeast')
hold off