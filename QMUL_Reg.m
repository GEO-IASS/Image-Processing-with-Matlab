function [ im , im2 , im3 , image ] = QMUL_Reg( imagename , filetype , kernel , sd )
%% DoG

close all
clc

% To use type:
% [ im , im2 , im3 , image ] = QMUL_Reg('Images/Lena512_Binary.pgm','pgm',100,1.6);
% [ im , im2 , im3 , image ] = QMUL_Reg('Images/Lena512C_Binary.ppm','ppm',100,1.6);

switch filetype
    case 'pgm'
        image = QMUL_pgmread( imagename );    % for .pgm files
    case 'ppm'
        image = QMUL_ppmread( imagename );    % for .ppm files
end

for i=0:12
%     clear im
%     clear im2
%     clear im3
    sd = 1.6;
    sd = sd*(2^(i/3));
    G = fspecial('gaussian',kernel,sd);
    im = imfilter(image,G,'same');
    
%     figure;
%     subplot(1,2,1); imshow(image)
    im2 = image - im;
    figure
    imshow(im2)
    im3 = image + im2;
%     subplot(1,2,2); 
figure;
    imshow(im3);
    clc
    disp('Program Paused');
    disp('Press a key to continue');
    pause;
end

