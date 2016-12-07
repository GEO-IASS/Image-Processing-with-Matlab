function [ mvx , mvy , f1 , f2 , fp , I1 , I2 , Ip ] = QMUL_bma( N , R )

%  N = 20; R = 16;
% To use type: [ mvx , mvy , f1 , f2 , fp , I1 , I2 , Ip ] = QMUL_bma(16,4);

close all
clc
%f1: anchor frame; f2: target frame, fp: predicted image;
%mvx,mvy: store the MV image
%widthxheight: image size; N: block size, R: search range

I1 = rgb2gray(imread('Images/im1.png'));
I2 = rgb2gray(imread('Images/im2.png'));
Ip = uint8(zeros(size(I1)));
[height width] = size(I1);
% N = 16;
% R = 20;

f1 = uint8(zeros(2*R+height,2*R+width));
f2 = f1;
fp = f1;

[nheight,nwidth] = size(f1);

mvx = zeros(floor(nheight/N),floor(nwidth/N));
mvy = zeros(floor(nheight/N),floor(nwidth/N));

for i=1:height
    for j=1:width
        f1(i+R:height+R,j+R:width+R) = I1(i,j);
        f2(i+R:height+R,j+R:width+R) = I2(i,j);
    end
end

% imshow(I1)
% hold on
for i=R+1:N:nheight-R-N
    for j=R+1:N:nwidth-R-N  %for every block in the anchor frame
        
        MAD_min=256*N*N;
        
        for k=-R:1:R
            for l=-R:1:R  %for every search candidate
                MAD=sum(sum(abs(f1(i:i+N-1,j:j+N-1)-f2(i+k:i+k+N-1,j+l:j+l+N-1))));

                % calculate MAD for this candidate
                if MAD<MAD_min
                    MAD_min=MAD;
                    dy=k; dx=l;
                end
            end
        end
%         quiver(j+k,i+l,l,k,'k','LineWidth',1)
        
        fp(i:i+N-1,j:j+N-1)= f2(i+dy:i+dy+N-1,j+dx:j+dx+N-1);
        %put the best matching block in the predicted image
        iblk = floor(((i-1)/N)+1);
        jblk = floor(((j-1)/N)+1); %block index
        mvx(iblk,jblk) = dx;
        mvy(iblk,jblk) = dy; %record the estimated MV
%         imshow(I1)
%         hold on
%         quiver(j+mvy(iblk,jblk),i+mvx(iblk,jblk),mvx(iblk,jblk),mvy(iblk,jblk),'k','LineWidth',1)
    end
end

Ip = fp(R+1:nheight-R, R+1:nwidth-R);

figure
imshow(I1); title('I1')
figure
imshow(I2); title('I2')
figure
imshow(Ip); title('Ip')

% for i = R+1:N:nheight-R
%     for j = R+1:N:nheight-R
%         hold on
%         iblk = floor(((i-1)/N)+1);
%         jblk = floor(((j-1)/N)+1);
%         annotation('arrow',[(i+N/2)/nheight (mvx(iblk,jblk)/nheight)+(i+N/2)/nheight],[(j+N/2)/nheight (mvy(iblk,jblk)/nwidth)+(j+N/2)/nheight])
%     end
% end
% 
MSE = sum(sum(sum((f2 - fp).^2)))./numel(f2);
disp(['MSE = ', num2str(MSE)])

L = 255;

PSNR = 10*log10(L^2/MSE);
disp(['PSNR = ', num2str(PSNR)])
