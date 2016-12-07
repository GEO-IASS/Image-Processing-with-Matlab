function [ eqim , image , cumulativedist ] = QMUL_eq( imagename, filetype )
% Best eq results @ [ eqim , image , cumulativedist ] = QMUL_eq('Images/Baboon512C_Binary.ppm','ppm');

% To use type: [ eqim , image , cumulativedist ] = QMUL_eq('Images/Baboon512_binary.pgm','pgm');

close all

[ image, hist, ~ ] = QMUL_histo( imagename, filetype );

[w,h] = size(image);
eqim = image;

% normalize image for example divide by 512*512
nhist = hist/(w*h);

% equalize, add each pixel value with its previous values
eq = zeros(1,256);
eq(1) = nhist(1);
for i=2:1:256
    for j=i:-1:2
        eq(i) = eq(i) + nhist(j);
    end
end

% multiply by the highest gray-level value (L-1) 255
cumulativedist = zeros(1,256);
for i=1:256
    cumulativedist(i) = eq(i)*255;
end

% make a new equalized image
for i=1:h
    for j=1:w
        eqim(j,i) = cumulativedist(image(j,i)+1); % image has 0s, index from 1
    end
end

% calculating histogram for equalize image
eqhist = zeros(1,256);
for i=1:h
    for j=1:w
        temp = eqim(j,i);
        eqhist(temp+1) = eqhist(temp+1) + 1;
    end
end

% figure
subplot(2,2,1); imshow(image); title('Original Image'); axis on
subplot(2,2,2); imshow(eqim); title('Equalized Image'); axis on
subplot(2,2,3); bar(hist,'b'); title('Histogram of the Original Image'); axis([0 255 0 (max(hist)+0.01*max(hist))]);
subplot(2,2,4); bar(eqhist,'b'); title('Histogram of the Equalized Image'); axis([0 255 0 (max(eqhist)+0.01*max(eqhist))]);
