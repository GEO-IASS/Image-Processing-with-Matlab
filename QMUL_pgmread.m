function [I,w,h,level] = QMUL_pgmread(path)
%*****************************************************
% Title: QMUL_pgmread
% Input Parameter: path of the pgm file
% Description: This file reads .pgm file
% PGM -> P2(ASCII), P5(Binary)
% PGM has one Gray Channel

% open the file in read mode
f= fopen(path,'r');
A = 0 ; % Ascii flag (P2)
% ignore the comments in the file
a = fscanf(f,'%s',1);
while(a(1)=='#')
    a = fscanf(f,'%s',1);
end

% check magic number
if ((strcmp(a,'P5')==0) &&(strcmp(a,'P2')==0))
    while(a(1)=='#')
        a = fscanf(f,'%s',1);
    end
%     display('it is not a ppm file.');
else
%     display('it is a pgm file.');
    if(strcmp(a,'P2'))
        A = 1;               % ASCII P2 A = 1/ else Binary P5 A = 0;
    end
    a = fscanf(f,'%s',1);
    while(a(1) == '#')
        b = fgets(f);        % throw away the comments line
        a= fscanf(f,'%s',1); % read first character of next line
    end
    w = str2num(a);          % width of image
    a= fscanf(f,'%s',1);
    
    while(a(1) == '#')
        b = fgets(f);
        a= fscanf(f,'%s',1);
    end
    h = str2num(a);          % hight of image
    a= fscanf(f,'%s',1);
    
    while(a(1) == '#')
        b = fgets(f);        % throw away the comments line
        a= fscanf(f,'%s',1);
    end
    level = str2num(a);      % colour levels
    
    I = zeros(h,w);
    if (A == 1) % P2
        for i = 1:h
            for j = 1:w
                I(i,j) = fscanf(f,'%i',1); % Red
                % %i means Signed Integer, Base determined from values
            end
        end
        
    else % P5
        % Skip one more char
        fread(f,1);
        % Now read the matrix
        Arr = uint8(fread(f));
        index = 0;
        for i = 1:1:h
            for j = 1:w
                index = index+1;
                I(i,j) = Arr(index);
            end
        end
    end
    
end

I = uint8(I);

% image = QMUL_pgmread('Baboon512_binary.pgm');
% imshow(I)

% image = QMUL_pgmread('Baboon512_ASCII.pgm');
% imagesc(I)
% colormap gray
