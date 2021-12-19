function B = lab2rgb255(A)
    B = lab2rgb(A);
    B = uint8(B.*255);
end