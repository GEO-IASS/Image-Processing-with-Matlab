function upimage = QMUL_up( imagename, filetype, scalefactor )
close all

% To use type: upimage = QMUL_up('Images/lena_bw.bmp', 'bmp', 4.5);
% To use type: upimage = QMUL_up('Images/Baboon512_binary.pgm','pgm',3.6);
% upimage = QMUL_up('Images/lena_bw.bmp', 'filetype', scalefactor);
% scalefactor could be any integer or non-integer number (even less than 1)

switch filetype
    case 'bmp'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'jpg'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'pgm'
        image = QMUL_pgmread( imagename );  % for .pgm files
end

[width , height] = size( image );

newwidth = width*scalefactor;
newheight = height*scalefactor;

im = uint8(zeros(newwidth, newheight));

for i = 1:scalefactor:newheight
    for j = 1:scalefactor:newwidth
        im(floor(i),floor(j)) = image(ceil(i/scalefactor),ceil(j/scalefactor));
        
%         im(ceil(i:(i+scalefactor-1)),ceil(j:(j+scalefactor-1))) = im(floor(i),floor(j));
        im(floor(i:(i+scalefactor)),floor(j:(j+scalefactor))) = im(floor(i),floor(j));
    end
end

upimage = im;

figure(1)
subplot(1,2,1); imshow(image); title('Original Image');
axis on;
subplot(1,2,2); imshow(upimage); title(['Upsampled Image by factor ',num2str(newwidth/width)]);
axis on;

