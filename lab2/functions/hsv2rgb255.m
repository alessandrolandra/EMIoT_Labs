function B = hsv2rgb255(A)
    B = hsv2rgb(A);
    B = uint8(B.*255);
end