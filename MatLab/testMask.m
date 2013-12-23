clc; clear; close all; imtool close all;

[x, Fs] = wavread('SexyParty.wav');



imwrite(spectrogram(x, 512, 256, 512, 1000, 'yaxis'),'jet','test.png', 'png');
imshow('test.png');

hFH = imfreehand();
binaryImage = hFH.createMask();

imshow(binaryImage);