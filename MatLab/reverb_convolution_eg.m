% reverb_convolution_eg.m
% Script to call implement Convolution Reverb


close all;
clear all;

% read the sample waveform
filename='acoustic.wav';
[x,Fs,bits] = wavread(filename);


% read the impilse response waveform


%filename='Spaces/IMreverbs1/French 18th Century Salon.wav';
filename='impulse_bathroom.wav';
%filename='impulse_cathedral.wav';
%filename='impulse_yeha.wav';
%filename='impulse_MM.wav';
%filename='impulse_mandolin.wav';
%filename='impulse_revcathedral.wav';

[imp,Fsimp,bitsimp] = wavread(filename);


% Do convolution with FFT
y = fconv(x,imp);


% write output
wavwrite(y,Fs,bits,'out_IRreverb.wav');

figure(1);
hold on
plot(x,'b');
plot(y,'r');
title('Impulse Response Reverberated Signal');

figure(2);

plot(imp);
title('Impulse Response');

sound(y);