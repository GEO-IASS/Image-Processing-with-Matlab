%% YUV to RGB and back conversion

function [ YUV, RGB ] = QMUL_format_converter( imagename, filetype )
% To use type:
% [YUV,RGB] = QMUL_format_converter('Images/Lena512C_Binary.ppm','ppm');

switch filetype
    case 'bmp'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'jpg'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'ppm'
        image = QMUL_ppmread( imagename );    % for .ppm files
end

%% RGB to YUV

im = double(image);
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

% RGB To YUV
Y =  0.257*R + 0.504*G + 0.098*B + 16;
U =  0.439*R + 0.368*G - 0.071*B + 128;
V = -0.148*R - 0.291*G + 0.439*B + 128;

YUV = zeros(size(image));
YUV(:,:,1) = (Y);
YUV(:,:,2) = (U);
YUV(:,:,3) = (V);

%% YUV Back To RGB
R1 = -2.2432*(Y-16) + 3.9768*(U-128) + 1.1439*(V-128);
G1 =  2.9011*(Y-16) - 2.0272*(U-128) - 0.9755*(V-128);
B1 =  1.1668*(Y-16) - 0.0031*(U-128) + 2.0169*(V-128);

RGB = zeros(size(image));
RGB(:,:,1) = (R1);
RGB(:,:,2) = (G1);
RGB(:,:,3) = (B1);

%% Display the results
figure(1)
subplot(2,2,1); imshow(image); title('Original RGB Image');
axis on;
subplot(2,2,2); imshow(uint8(Y)); title('Y');
axis on;
subplot(2,2,3); imshow(uint8(U)); title('U');
axis on;
subplot(2,2,4); imshow(uint8(V)); title('V');
axis on;
figure(2)
imshow(uint8(RGB)); title('Converted YUV to RGB image');
axis on;
