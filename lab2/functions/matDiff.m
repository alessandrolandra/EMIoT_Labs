function matDiff = matDiff(A,B)
%% %Compute the difference between two images
   %Difference is computed in the LAB space, Eucledian difference
   %A,B= Input images in RGB space
A=rgb2lab(A);
B=rgb2lab(B);

matDiff = 0;
for row=1:size(A,1)
	for col=1:size(A,2)
        matDiff = matDiff + sqrt(power(double((A(row,col,1)-B(row,col,1))),2) + power(double((A(row,col,2)-B(row,col,2))),2) + power(double((A(row,col,3)-B(row,col,3))),2));
    end
end

matDiff=(matDiff*100)/(size(A,1)*size(A,2)*sqrt(100*100 + 255*255 + 255*255))

end