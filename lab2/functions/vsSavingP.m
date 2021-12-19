%% Power consumption saved in percentage after displaying (parameters order: original,new)
function vsSavingP = vsSavingP(A,B,Vdd)
    vsSavingP = (panelP(A,Vdd)-panelP(B,Vdd))*100/panelP(A,Vdd);
end