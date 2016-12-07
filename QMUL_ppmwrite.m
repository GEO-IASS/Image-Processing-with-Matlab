function QMUL_ppmwrite(I,w,h,level,mode)
%*****************************************************
% Title:  QMUL_ppmwrite
% Input Parameters:
%                I: Matrix to write in ppm
%            (w,h): dimension of matrix
%                l: gray levels
%             mode: ASCII or Binary (1 for Ascii and 0 for Binary)
% Description: This file stores input matrix into a .ppm file

% open the file in read mode
if (mode == 1) ; % Ascii flag
    f= fopen('outascii.ppm','w');
    fprintf(f,'P3\n');
    fprintf(f,'#outascii.ppm\n');
    fprintf(f,'\n# image width\n');
    fprintf(f,'%i',w);
    fprintf(f,'\n# image height\n');
    fprintf(f,'%i',h);
    fprintf(f,'\n# Image Created by Salehe Erfanian Ebadi\n'); % insert author name
    fprintf(f,'\n# image level\n');
    fprintf(f,'%i',level);
    fprintf(f,'\n');
    
    for i=1:w
        for j=1:h
            fprintf(f,' %s ',num2str(I(i,j,1))); % %s string of characters
            fprintf(f,'\n');
            fprintf(f,' %s ',num2str(I(i,j,2))); % %s string of characters
            fprintf(f,'\n');
            fprintf(f,' %s ',num2str(I(i,j,3))); % %s string of characters
            fprintf(f,'\n');
        end
    end
    
else % Binary
    f= fopen('outbinary.ppm','w');
    fprintf(f,'P6\n');
    fprintf(f,'#outbinary.ppm\n');
    fprintf(f,'\n# image width\n');
    fprintf(f,'%i',w);
    fprintf(f,'\n# image height\n');
    fprintf(f,'%i',h);
    fprintf(f,'\n# image level\n');
    fprintf(f,'%i',level);
    fprintf(f,'\n');
    
    I = num2str(I);
    
    for i=1:w
        for j=1:h
            fprintf(f,'%c',I(i,j,1));   % %c single character
            fprintf(f,'%c',I(i,j,2));   % %c single character
            fprintf(f,'%c',I(i,j,3));   % %c single character
        end
    end
    
end

