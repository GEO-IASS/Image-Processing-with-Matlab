function [ mim , mhist ] = QMUL_histmodel( imagename, filetype, imagename2, filetype2 )
% [ mim , mhist ] = QMUL_histmodel('Images/Lena512_Binary.pgm','pgm','Images/Peppers512_binary.pgm','pgm');

close all

[ ~, hist, normhist ] = QMUL_histo( imagename, filetype );
[ ~, hist2, normhist2 ] = QMUL_histo( imagename2, filetype2 );
[ ~, image, cumulativedist ] = QMUL_eq( imagename, filetype );
[ ~, image2, cumulativedist2 ] = QMUL_eq( imagename2, filetype2 );


[w,h] = size(image);
[w2,h2] = size(image2);

% make a new equalized image
mim = image2;

dif = zeros(256,256);
for i = 1 : 256
    for j = 1:256
        dif(j,i) = cumulativedist2(i) - cumulativedist(j);
    end
end
dif = abs(dif);

diff = zeros(256,2);

for i = 1: 256
    [C,I]=min(dif(:,i));
    diff(i,1) = C; % index
    diff(i,2) = I; % value
end

h = waitbar(0,'Mapping pixels, Please wait...');
for i=1:h2
    waitbar(i/250)
    for j = 1:w2
        mim(i,j) = diff(mim(i,j)+1,2);
    end
end
close(h);

% mim = uint8(mim);

% calculating histogram for equalize image
mhist = zeros(1,256);
for i=1:h
    for j=1:w
        temp = mim(j,i);
        mhist(temp+1) = mhist(temp+1) + 1;
    end
end

figure
subplot(2,3,1); imshow(image);
subplot(2,3,2); imshow(image2);
subplot(2,3,3); imshow((mim));
subplot(2,3,4); bar(hist,'b'); axis([0 255 0 (max(hist)+0.01*max(hist))]);
subplot(2,3,5); bar(hist2,'b'); axis([0 255 0 (max(hist2)+0.01*max(hist2))]);
subplot(2,3,6); bar(mhist,'b'); axis([0 255 0 (max(mhist)+0.01*max(mhist))]);
