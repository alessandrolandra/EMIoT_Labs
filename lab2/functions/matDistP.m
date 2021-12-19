%% Image distortion percentage evaluation in LAB
function matDistP = matDistP(A,B)
	matDistP = (matDist(A,B)/(size(A,1)*size(A,2)*sqrt(power(100,2) + power(255,2) + power(255,2))))*100;
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