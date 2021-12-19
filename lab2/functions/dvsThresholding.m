function Anew = dvsThresholding(A)
%% %Function that compute Thresholding on Brightness (V)
   %A = Image in RGB space
Ahsv=rgb2hsv(A);
V=Ahsv(:,:,3);

bHIGH = 0.5;
bLOW = 0.1;

for row=1:size(A,1)
    for col=1:size(A,2)
        %% Thresholding on High Brightness (V=(70%,100%])        
        if (V(row,col)>0.7)
            V(row,col) = V(row,col) + bHIGH;
        %% Thresholding on Low Brightness (V=(0%,20%])
        elseif (V(row,col)>0.3)
            V(row,col) = V(row,col) + bLOW;
        end        
    end
end

Ahsv(:,:,3)=V;
Anew=hsv2rgb255(Ahsv);
end