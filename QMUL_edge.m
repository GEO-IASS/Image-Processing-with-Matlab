function [ im , image2 , image ] = QMUL_edge( imagename , filetype , filter )
%% Edge Detector

close all
clc

% To use type:
% [ im , image2 , image ] = QMUL_edge('Images/Lena512_Binary.pgm','pgm','Roberts1');
% [ im , image2 , image ] = QMUL_edge('Images/Lena512C_Binary.ppm','ppm','Roberts1');

switch filetype
    case 'pgm'
        image = QMUL_pgmread( imagename );    % for .pgm files
    case 'ppm'
        image = QMUL_ppmread( imagename );    % for .ppm files
end

switch filter
    case 'Roberts1'
        flt = [0  0 -1
            0  1  0
            0  0  0];
        
    case 'Roberts2'
        flt = [-1  0  0
            0  1  0
            0  0  0];
        
    case 'Sobel1'
        flt = [1  0 -1
            2  0 -2
            1  0 -1];
        
    case 'Sobel2'
        flt = [-1 -2 -1
            0  0  0
            1  2  1];
        
    case 'Prewitt1'
        flt = [1  0 -1
            1  0 -1
            1  0 -1];
        
    case 'Prewitt2'
        flt = [-1 -1 -1
            0  0  0
            1  1  1];
        
    case 'Laplacian1'
        flt = [0 1 0
            1 -4 1
            0 1 0];
        
    case 'Laplacian2'
        flt = [1 1 1
            1 -8 1
            1 1 1];
        
    case 'Laplacian3'
        flt = [-1 2 -1
            2 -4 2
            -1 2 -1];
        
    case 'Average'
        flt = (1/9)*[1 1 1
            1 1 1
            1 1 1];
        
    case 'Gaussian'
        flt = zeros(3);
        for i=1:3
            for j=1:3
                flt(i,j) = (1/(2*pi*2^2))*exp(-((i-2)^2+(j-2)^2)/(2*2^2));
            end
        end
        
        
end

[k,l,p] = size(image);

image2 = zeros(k+2,l+2,3);
for i=2:k+1
    for j=2:l+1
        image2(i,j,:) = uint8(image(i-1,j-1,:));
    end
end
image2 = uint8(image2);
im = image;

switch filetype
    
    case 'pgm'
        for m=2:k+1
            i=m-1;
            for n=2:l+1
                j=n-1;
                sum = 0;
                sum = sum + (flt(1,1).*double(image2(m-1,n-1)) + flt(1,2).*double(image2(m-1,n)) + flt(1,3).*double(image2(m-1,n+1)) + ...
                    flt(2,1).*double(image2(m,n-1))   + flt(2,2).*double(image2(m,n))   + flt(2,3).*double(image2(m,n+1))   + ...
                    flt(3,1).*double(image2(m+1,n-1)) + flt(3,2).*double(image2(m+1,n)) + flt(3,3).*double(image2(m+1,n+1)));
                im(i,j) = sum;
            end
        end
        
    case 'ppm'
        for m=2:k+1
            i=m-1;
            for n=2:l+1
                j=n-1;
                sumR = 0; sumG = 0; sumB = 0;
                sumR = sumR + (flt(1,1).*double(image2(m-1,n-1,1)) + flt(1,2).*double(image2(m-1,n,1)) + flt(1,3).*double(image2(m-1,n+1,1)) + ...
                    flt(2,1).*double(image2(m,n-1,1))   + flt(2,2).*double(image2(m,n,1))   + flt(2,3).*double(image2(m,n+1,1))   + ...
                    flt(3,1).*double(image2(m+1,n-1,1)) + flt(3,2).*double(image2(m+1,n,1)) + flt(3,3).*double(image2(m+1,n+1,1)));
                
                sumG = sumG + (flt(1,1).*double(image2(m-1,n-1,2)) + flt(1,2).*double(image2(m-1,n,2)) + flt(1,3).*double(image2(m-1,n+1,2)) + ...
                    flt(2,1).*double(image2(m,n-1,2))   + flt(2,2).*double(image2(m,n,2))   + flt(2,3).*double(image2(m,n+1,2))   + ...
                    flt(3,1).*double(image2(m+1,n-1,2)) + flt(3,2).*double(image2(m+1,n,2)) + flt(3,3).*double(image2(m+1,n+1,2)));
                
                sumB = sumB + (flt(1,1).*double(image2(m-1,n-1,3)) + flt(1,2).*double(image2(m-1,n,3)) + flt(1,3).*double(image2(m-1,n+1,3)) + ...
                    flt(2,1).*double(image2(m,n-1,3))   + flt(2,2).*double(image2(m,n,3))   + flt(2,3).*double(image2(m,n+1,3))   + ...
                    flt(3,1).*double(image2(m+1,n-1,3)) + flt(3,2).*double(image2(m+1,n,3)) + flt(3,3).*double(image2(m+1,n+1,3)));
                im(i,j,1) = sumR;
                im(i,j,2) = sumG;
                im(i,j,3) = sumB;
            end
        end
        
end

imshow(im)

% figure
% imshow(im+image);



