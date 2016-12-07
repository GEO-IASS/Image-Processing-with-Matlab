function [ im3 , im4 ] = QMUL_rect( imagename , filetype )
%% Rectangular Filter

close all
clc

% To use type:
% [ im3 , im4 ] = QMUL_rect('Images/Lena512_Binary.pgm','pgm');
% [ im3 , im4 ] = QMUL_rect('Images/Lena512C_Binary.ppm','ppm');

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

% G2 = fspecial('average',[5 5]);
% G3 = fspecial('average',[7 7]);

G2 = (1/25)*ones(5);
G3 = (1/49)*ones(7);

im3 = imfilter(im,G2,'same');
im4 = imfilter(im,G3,'same');

% im3 = G2*im;
% im4 = G3*im;

figure;
subplot(1,3,1); imshow(im);
title('Noisy Image');
axis on;

subplot(1,3,2); imshow(im3);
title('Filtered Image using Rectangular-Shaped Filter with Kernel=[5 5]');
axis on;

subplot(1,3,3); imshow(im4);
title('Filtered Image using Rectangular-Shaped Filter with Kernel=[7 7]');
axis on;