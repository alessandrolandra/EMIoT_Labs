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

