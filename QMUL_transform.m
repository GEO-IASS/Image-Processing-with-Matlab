function [ im , im2 , image ] = QMUL_transform( imagename , filetype , angle1 , angle2 )
%% Rotate
theta = pi*angle1/180;

close all
clc

% To use type:
% [ im , image ] = QMUL_transform('Images/Lena512_Binary.pgm','pgm',45,40);
% [ im , image ] = QMUL_transform('Images/Lena512C_Binary.ppm','ppm',45,40);

% switch filetype
%     case 'bmp'
%         image = QMUL_readimage( imagename );  % for .bmp and .jpg files
%     case 'jpg'
%         image = QMUL_readimage( imagename );  % for .bmp and .jpg files
%     case 'pgm'
%         image = QMUL_pgmread( imagename );    % for .pgm files
%     case 'ppm'
%         image = QMUL_ppmread( imagename );    % for .ppm files
% end

image = imread('Images/11-1.PNG');

%%
% [m,n,p]=size(im);
[m,n,p]=size(image);

mm = m*sqrt(2); % max width and height
nn = n*sqrt(2);

th = pi*angle1/180;

for k=1:mm
    for l=1:nn
        i = uint16((k-mm/2)*cos(theta)+(l-nn/2)*sin(theta)+m/2); % rotate around center of image
        j = uint16(-(k-mm/2)*sin(theta)+(l-nn/2)*cos(theta)+n/2);
        if i>0 && j>0 && i<=m && j<=n
            im(k,l,:)=image(i,j,:); % image
        end
    end
end


%% Skew (Shear)

theta2 = pi*angle2/180;
% [m,n,p] =size(im);

for i=1:512
    for j=1:512
        l = uint16((j + i*tan(theta2))); % rotate around center of image
        k = uint16(i);
%         if i>0 && j>0 && i<=m && j<=n
            im2(k,l,:)=image(i,j,:);     % image
%         end
    end
end

figure
subplot(1,3,1); imshow(image); title('Original Image');
axis on;
subplot(1,3,2); imshow(im); title(['Rotated Image by ', num2str(angle1), ' degrees']);
axis on;
subplot(1,3,3); imshow(im2); title(['Skewed Image by ', num2str(angle2), ' degrees']);
axis on;


