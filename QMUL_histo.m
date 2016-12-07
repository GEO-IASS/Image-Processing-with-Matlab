function [ image, hist, normhist ] = QMUL_histo( imagename, filetype )
% [image,hist,normhist] = QMUL_histo('Images/lena_bw.bmp','bmp');

close all

switch filetype
    case 'bmp'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'jpg'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'ppm'
        image = QMUL_ppmread( imagename );  % for .ppm files
    case 'pgm'
        image = QMUL_pgmread( imagename );  % for .pgm files
end

[w,h] = size(image);
hist = zeros(1,256);

for i=1:h
    for j=1:w
        temp = image(j,i);
        hist(temp+1) = hist(temp+1) + 1;
    end
end

normhist = hist/(max(hist));

subplot(1,3,1); imshow(image);
title('Image')

subplot(1,3,2); bar(hist,'b');
title('Histogram')
axis([0 255 0 (max(hist)+0.01*max(hist))])

subplot(1,3,3); bar(normhist,'b');
title('Normalized Histogram')
axis([0 255 0 (max(normhist)+0.01*max(normhist))])
