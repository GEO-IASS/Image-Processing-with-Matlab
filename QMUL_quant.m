function qim = QMUL_quant( imagename, filetype, qlevel )
% qim = QMUL_quant('Images/lena_bw.bmp','bmp',(2, 8, 32, 128));

switch filetype
    case 'bmp'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'jpg'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'ppm'
        image = QMUL_ppmread( imagename );  % for .ppm files
    case 'pgm'
        image = QMUL_pgmread( imagename );  % for .pgm files
end

qim = image;

for i=0:qlevel
    qim( (qim >= floor((i)*255/qlevel)) & (qim < floor((i+1)*255/qlevel)) ) = floor(i*255/qlevel);
end


figure(1)
subplot(1,2,1); imshow(image); title('Original Image');
axis on;
subplot(1,2,2); imshow(qim); title(['Quantized Image by ', num2str(qlevel), ' levels']);
axis on;
