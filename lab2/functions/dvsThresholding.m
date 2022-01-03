function Anew = dvsThresholding(A,Vdd)
%% %Function that compute Thresholding on Brightness (V)
   %A = Image in RGB space
Ahsv=rgb2hsv(A);
V=Ahsv(:,:,3);

bArr = [0.175,0.175,0.2,0.2,0.2,0.225,0.25];
startingB = bArr(15-Vdd);
bHIGH = startingB + 0.1;
bMIDDLE = startingB;
bLOW = startingB - 0.1;

for row=1:size(A,1)
    for col=1:size(A,2)
        if (V(row,col)>0.7)
            V(row,col) = V(row,col) + bHIGH;
        elseif (V(row,col)>0.3)
            V(row,col) = V(row,col) + bLOW;
        else
            V(row,col) = V(row,col) + bMIDDLE;
        end        
    end
end

Ahsv(:,:,3)=V;
Anew=hsv2rgb255(Ahsv);
end