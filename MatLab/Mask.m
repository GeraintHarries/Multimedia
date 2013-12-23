[x Fs] = wavread('SexyParty.wav');
spectrogram(x, 512, 256, 512, 1000, 'yaxis'); 

%spectrogram(x, 512, 256, 512, 1000, 'yaxis');

hold on 
 
im3 = repmat(im,[1 1 3]); %# Assuming image is grayscale
overlay = ( (1-alpha) .* im3 ) + ( alpha .* labels );
imshow(overlay); %# Or imwrite, etc.
%set(img, 'AlphaData', alpha);

% 
% img = imread('peppers.png');
% 
% image(0,0,img);        %# Plot the image