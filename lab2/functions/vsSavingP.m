%% Power consumption saved in percentage considering Vdd (parameters order: original,new)
function vsSavingP = vsSavingP(IA,VddA,IB,VddB)
    vsSavingP = (panelP(IA,VddA)-panelP(IB,VddB))*100/panelP(IA,VddA);
end