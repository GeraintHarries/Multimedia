% the data
%img=imread('lena.bmp', 'bmp');
     [filename,path]=uigetfile();
     img = load('lena.bmp');
     imshow(uigetfile());
     [x,y,z]=peaks(64);
     [px,py]=gradient(z);
% the plot
     quiver(x,y,px,py);
     hold on;
     img=flipud(img.X);
     ih=imagesc([-1,2],[-1,3],img);
     alpha(ih,1);