function [ im , im2 , image ] = QMUL_DoG( imagename , filetype , kernel , sd )
%% DoG

close all
clc

% To use type:
% [ im , im2 , image ] = QMUL_DoG('Images/Lena512_Binary.pgm','pgm',3,2);
% [ im , im2 , image ] = QMUL_DoG('Images/Lena512C_Binary.ppm','ppm',3,2);

switch filetype
    case 'pgm'
        image = QMUL_pgmread( imagename );    % for .pgm files
    case 'ppm'
        image = QMUL_ppmread( imagename );    % for .ppm files
end

% [ im , ~ ] = QMUL_noisePSNR(imagename,filetype,'gaussian',0.05);
% 
% G = zeros(kernel);
% for i=1:kernel
%     for j=1:kernel
%         G(i,j) = (1/(2*pi*(sd^2)))*(exp(-((i-ceil(kernel/2))^2 + (j-ceil(kernel/2))^2)/(2*sd^2)));
%     end
% end
% 
% G1 = zeros(kernel);
% for i=1:kernel
%     for j=1:kernel
%         G1(i,j) = (1/(2*pi*((sd+1)^2)))*(exp(-((i-ceil(kernel/2))^2 + (j-ceil(kernel/2))^2)/(2*(sd+1)^2)));
%     end
% end
% 
% DoG = G - G1;
% 
% im2 = imfilter(im,G,'same');
% im3 = imfilter(im,G1,'same');
% im4 = imfilter(im,DoG,'same');
% 
% figure
% subplot(1,5,1); imshow(image); title('Original Image');
% axis on;
% subplot(1,5,2); imshow(im); title('Noisy Image');
% axis on;
% subplot(1,5,3); imshow(im2);
% title(['Filtered Image using Gaussian Filter with Kernel=[',num2str(kernel), ...
%     '] and \sigma= ',num2str(sd)]);
% axis on;
% subplot(1,5,4); imshow(im3);
% title(['Filtered Image using Gaussian Filter with Kernel=[',num2str(kernel), ...
%     '] and \sigma= ',num2str(sd+1)]);
% axis on;
% subplot(1,5,5); imshow(im4);
% title('Filtered Image using DoG Filter');
% axis on;
% 
% figure
% imagesc(DoG)
% figure
% surf(DoG)

G = fspecial('gaussian',kernel,sd);
im = imfilter(image,G,'same');
% figure;
% imshow(im)
im2 = diff(im);
figure;
imshow(im2)

