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