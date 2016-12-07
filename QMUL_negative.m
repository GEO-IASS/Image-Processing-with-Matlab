function [ im , image ] = QMUL_negative( imagename , filetype )

close all
clc

% To use type:
% [ im , image ] = QMUL_negative('Images/Lena512_Binary.pgm','pgm');
% [ im , image ] = QMUL_negative('Images/Lena512C_Binary.ppm','ppm');

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

im = image;

im = 255 - im;

figure
subplot(1,2,1); imshow(image); title('Original Image');
axis on;
subplot(1,2,2); imshow(im); title('Negative Image');
axis on;
