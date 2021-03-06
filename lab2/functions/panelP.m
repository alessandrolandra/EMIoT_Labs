%% determines the real power required by a matrix of RGB cells to be displayed, starting from a CURRENT MATRIX and the Vdd
function panelP = panelP(I,Vdd)
    panelP = 0;
    for row=1:size(I,1)
	    for col=1:size(I,2)
            for channel=1:3 %loop around rgb channels
                panelP = panelP + I(row,col,channel);
            end
        end
    end
    panelP = Vdd*panelP;
end