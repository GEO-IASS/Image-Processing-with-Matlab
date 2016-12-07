% function QMUL_pyr
tic
[ mvx1 , mvy1 , f11 , f21 , fp1 , I11 , I21 , Ip1 ] = QMUL_bma( 16 , 4 );
[ mvx2 , mvy2 , f12 , f22 , fp2 , I12 , I22 , Ip2 ] = QMUL_bma( 32 , 4 );
[ mvx3 , mvy3 , f13 , f23 , fp3 , I13 , I23 , Ip3 ] = QMUL_bma( 64 , 4 );
toc

figure
imshow(I21); title('Original Frame')
figure
imshow(Ip1); title('Predicted Frame at Level 0')
figure
imshow(Ip2); title('Predicted Frame at Level 1')
figure
imshow(Ip3); title('Predicted Frame at Level 2')