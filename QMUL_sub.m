function subimage = QMUL_sub( imagename, filetype, direction, directionfactor )
close all

% To use type: subimage = QMUL_sub('Images/lena_bw.bmp', 'bmp', 'vertical' , 1);
% Direction factor can be: 'vertical', 'horizontal', 'both'.
% Direction factor is used for 'both' directions only: (1: 2x8 , 2: 4x4)

switch filetype
    case 'bmp'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'jpg'
        image = QMUL_readimage( imagename );  % for .bmp and .jpg files
    case 'pgm'
        image = QMUL_pgmread( imagename );  % for .pgm files
end

[width , height , p] = size( image );

switch direction
    case 'vertical'
        newwidth = width/2;
        newheight = height;
        im = uint8(zeros(newwidth, newheight));
        
        for i = 1:newheight
            for j = 1:newwidth
                im(i,j) = image(i,j*2);
            end
        end
        subimage = im(1:i,1:j);
        
    case 'horizontal'
        newwidth = width;
        newheight = height/2;
        im = uint8(zeros(newwidth, newheight));
        
        for i = 1:newheight
            for j = 1:newwidth
                im(i,j) = image(i*2,j);
            end
        end
        subimage = im(1:i,1:j);
        
    case 'both'
        switch directionfactor
            case 1  % both directions (2 vertical and 8 horizontal)
                newwidth = width/2;
                newheight = height/8;
                im = uint8(zeros(newwidth, newheight));
                
                for i = 1:newheight
                    for j = 1:newwidth
                        im(i,j) = image(i*8,j*2);
                    end
                end
                subimage = im(1:i,1:j);
                
            case 2  % both directions (4 vertical and 4 horizontal)
                newwidth = width/4;
                newheight = height/4;
                im = uint8(zeros(newwidth, newheight));
                
                for i = 1:newheight
                    for j = 1:newwidth
                        im(i,j) = image(i*4,j*4);
                    end
                end
                subimage = im(1:i,1:j);
                
        end
end

figure(1)
subplot(1,2,1); imshow(image); title('Original Image');
axis on;
subplot(1,2,2); imshow(subimage); title(['Subsampled Image by factor ',num2str(width/newwidth),'x',num2str(height/newheight)]);
axis on;
