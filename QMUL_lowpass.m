function [ G , im2 , image ] = QMUL_lowpass( imagename , filetype , kernel , sd )
%% Gaussian Filter

close all
clc

% To use type:
% [ G , im2 , image ] = QMUL_lowpass('Images/Lena512_Binary.pgm','pgm',5,2);
% [ G , im2 , image ] = QMUL_lowpass('Images/Lena512C_Binary.ppm','ppm',[5 5],2);

switch filetype
    case 'bmp'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'jpg'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'pgm'
        image = QMUL_pgmread( imagename );    % for .pgm files
    case 'ppm'
        image = QMUL_ppmread( imagename );    % for .ppm files
end

[ im , ~ ] = QMUL_noisePSNR(imagename,filetype,'gaussian',0.05);
[m n] = size(image);
%% MATLAB
G = fspecial('gaussian',kernel,sd);
im2 = imfilter(im,G,'same');
%% mine
% G = zeros(kernel);
% % % G1 = zeros(5,1);
% % % G2 = zeros(1,5);
% for i=1:kernel
%     for j=1:kernel
%         G(i,j) = (1/(2*pi*(sd^2)))*(exp(-((i-ceil(kernel/2))^2 + (j-ceil(kernel/2))^2)/(2*sd^2)));
%     end
% end
%% additional (no need for this one)
% for i=1:kernel
%     for j=1:kernel
%         G(j,i) = G(i,j)*(1/(sqrt(2*pi)*(sd)))*(exp(-(i^2)/(2*sd^2)));
%     end
% end
% G = G1*G2;
% % im2 = sum(G*double(im));

im2 = imfilter(im,G,'same');

figure
subplot(1,3,1); imshow(image); title('Original Image');
axis on;
subplot(1,3,2); imshow(im); title('Noisy Image');
axis on;
subplot(1,3,3); imshow(im2);
title(['Filtered Image using Gaussian Filter with Kernel=[',num2str(kernel), ...
    '] and \sigma= ',num2str(sd)]);
axis on;
