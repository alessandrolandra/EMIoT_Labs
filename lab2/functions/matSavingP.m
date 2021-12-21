%% Power consumption saved in percentage (parameters order: original,new)
function matSavingP = matSavingP(A,B)
    matSavingP = (Pmat(A)-Pmat(B))*100/Pmat(A);
end

%% Power consumption evaluation in RGB
function Pmat = Pmat(A)
    w0 = 1.48169521*10^-6;
    wg = 1.77746705*10^-7;
    wb = 2.14348309*10^-7;
    wr = 2.13636845*10^-7;
    y = 0.7755;
    Pmat = 0;
    for row=1:size(A,1)
        for col=1:size(A,2)
            Pmat = Pmat + wr * power(double(A(row,col,1)),y) + wg * power(double(A(row,col,2)),y) + wb * power(double(A(row,col,3)),y);
        end    
    end
    Pmat = Pmat + w0;
end