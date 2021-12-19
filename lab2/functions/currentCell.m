%% determines the real current required by an RGB cell to be displayed
function currentCell = currentCell(rgbCell,Vdd)
    p1 = 4.251*10^-05;
    p2 = -3.029*10^-4;
    p3 = 3.024*10^-5;
    currentCell = double(rgbCell(1))*(p1*Vdd/255 + p2/255);
    currentCell = currentCell + double(rgbCell(2))*(p1*Vdd/255 + p2/255);
    currentCell = currentCell + double(rgbCell(3))*(p1*Vdd/255 + p2/255);
    currentCell = currentCell + p3;
end