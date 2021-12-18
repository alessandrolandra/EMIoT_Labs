function chi = chI(A)
%Compute the average intensity of a color channel
%   A is a single channel image, if A is RGB, then call this function 3
%   times, 1 for each channel. Ex A (RGB image), blueI=chI(A(:,:,1))
chi=0.0;
N=size(A,1);
M=size(A,2);
for row=1:N
    for col=1:M
        chi=double(A(row,col))+chi;
    end
end
chi=chi/(N*M*255);
end