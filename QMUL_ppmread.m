function [I,w,h,level] = QMUL_ppmread(path)
%*****************************************************
% Title: QMUL_ppmread
% Input Parameter: path of the ppm file
% Description: This file reads .ppm file
% PPM -> P3, P64
% PPM has 3 Channels (R,G,B)

% open the file in read mode
f= fopen(path,'r');
A = 0 ; % Ascii flag
% ignore the comments in the file
a = fscanf(f,'%s',1);
while(a(1)=='#')
    a = fscanf(f,'%s',1);
end

% check magic number
if ((strcmp(a,'P3')==0) &&(strcmp(a,'P6')==0))
    while(a(1)=='#')
        a = fscanf(f,'%s',1);
    end
%     display('It is not a ppm file.');
else
%     display('It is a ppm file.');
    if(strcmp(a,'P3'))
        A = 1;
    end
    a = fscanf(f,'%s',1);
    while(a(1) == '#')
        b = fgets(f);        % throw away the comments line
        a= fscanf(f,'%s',1); % read first character of next line
    end
    w = str2num(a);      % width of image
    a= fscanf(f,'%s',1);
    
    while(a(1) == '#')
        b = fgets(f);
        a= fscanf(f,'%s',1);
    end
    h = str2num(a);  % hight of image
    a= fscanf(f,'%s',1);
    
    while(a(1) == '#')
        b = fgets(f); % throw away the comments line
        a= fscanf(f,'%s',1);
    end
    level = str2num(a); % colour levels
    
    I = zeros(h,w,3);
    if (A == 1)
        for i = 1:h
            for j = 1:w
                I(i,j,1) = fscanf(f,'%i',1); % Red
                I(i,j,2) = fscanf(f,'%i',1); % Green
                I(i,j,3) = fscanf(f,'%i',1); % Blue
            end
        end
    else
        % Skip one more char
        fread(f,1);
        % Now read the matrix
        Arr = uint8(fread(f));
        index = 0;
        for i = 1:1:h
            for j = 1:w
                index = index+1;
                I(i,j,1) = Arr(index);
                index = index+1;
                I(i,j,2) = Arr(index);
                index = index+1;
                I(i,j,3) = Arr(index);
                
            end
        end
    end
    
end

I = uint8(I);

% imshow(uint8(I),[0 255])
% imagesc(uint8(I))
