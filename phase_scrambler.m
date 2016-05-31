
function [ImScrambled] = phase_scrambler(path, Ima)



Im = mat2gray(double(imread(horzcat(path,Ima))));
%read and rescale (0-1) image

ImSize = size(Im);

RandomPhase = angle(fft2(rand(ImSize(1), ImSize(2))));
%generate random phase structure

for layer = 1:ImSize(3)
    ImFourier(:,:,layer) = fft2(Im(:,:,layer));       
%Fast-Fourier transform
    Amp(:,:,layer) = abs(ImFourier(:,:,layer));       
%amplitude spectrum
    Phase(:,:,layer) = angle(ImFourier(:,:,layer));   
%phase spectrum
    Phase(:,:,layer) = Phase(:,:,layer) + RandomPhase;
%add random phase to original phase
    ImScrambled(:,:,layer) =...
ifft2(Amp(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
%combine Amp and Phase then perform inverse Fourier
end

ImScrambled = real(ImScrambled); %get rid of imaginery part in image (due to rounding error)

name = Ima(1:end-4);
imwrite(ImScrambled,horzcat(name,'_scramble','.jpg'),'jpg');

%imshow(ImScrambled)