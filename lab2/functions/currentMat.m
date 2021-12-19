%% determines the real current required by a matrix of RGB cells to be displayed
function currentMat = currentMat(A,Vdd)
    for row=1:size(A,1)
	    for col=1:size(A,2)
            currentMat(row,col) = currentCell(A(row,col,:),Vdd);
        end
    end
end