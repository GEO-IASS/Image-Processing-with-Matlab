function [ im , image2 , image ] = QMUL_edgeTheta( imagename , filetype , angle )
%% Edge Detector at different angles

close all
clc

% To use type:
% [ im , image2 , image ] = QMUL_edgeTheta('Images/Lena512_Binary.pgm','pgm',45);
% [ im , image2 , image ] = QMUL_edgeTheta('Images/Lena512C_Binary.ppm','ppm',45);

switch filetype
    case 'pgm'
        image = QMUL_pgmread( imagename );    % for .pgm files
    case 'ppm'
        image = QMUL_ppmread( imagename );    % for .ppm files
end

switch angle
    case 0
        flt = [-1 -1 -1
            2 2 2
            -1 -1 -1];
        
    case -45
        flt = [2 -1 -1
            -1 2 -1
            -1 -1 2];
        
    case 90
        flt = [-1 2 -1
            -1 2 -1
            -1 2 -1];
        
    case 45
        flt = [-1 -1 2
            -1 2 -1
            2 -1 -1];
        
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

figure
imshow(im)
title(['Detected Edges at ', num2str(angle), ' degrees']);
