function [ im , image ] = QMUL_noisePSNR( imagename , filetype , noisetype , variance )
% clear all
close all
clc

% To use type:
% [ im , image ] = QMUL_noisePSNR('Images/Lena512_Binary.pgm','pgm','gaussian',0.01);
% [ im , image ] = QMUL_noisePSNR('Images/Lena512_Binary.pgm','pgm','salt & pepper',0.01);
% [ im , image ] = QMUL_noisePSNR('Images/Lena512C_Binary.ppm','ppm','salt & pepper',0.01);
% [ im , image ] = QMUL_noisePSNR('Images/Lena512C_Binary.ppm','ppm','gaussian',0.01);

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

switch noisetype
    case 'gaussian'
        im = imnoise(im, 'gaussian', 0, variance);
    case 'salt & pepper'
        im = imnoise(im, 'salt & pepper', variance);
end

% for i=1:100
%     for j=1:100
%         im(ceil(512*rand),ceil(512*rand)) = 255;
%     end
% end
% for i=1:100
%     for j=1:100
%         im(ceil(512*rand),ceil(512*rand)) = 0;
%     end
% end


%% display

MSE = sum(sum(sum((image - im).^2)))./numel(image);
disp(['MSE = ', num2str(MSE)])

R = 255;

PSNR = 10*log10(R^2/MSE);
disp(['PSNR = ', num2str(PSNR)])

figure
subplot(1,2,1); imshow(image); title('Original Image');
axis on;
subplot(1,2,2); imshow(im); title('Noisy Image');
axis on;
