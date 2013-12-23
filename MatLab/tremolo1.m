% 
% tremolo1.m
% M Script that uses a low frequency AM   to provide a tremolo effect

filename='SexyParty.wav';


% read the sample waveform
[x,Fs,bits] = wavread(filename);


index = 1:length(x);

% using a sin wave at the moment, in practice is usually a 
% triangle wave or a square wave or a cross between the two

Fc = 10;
alpha = 0.9;

trem=(1+ alpha*sin(2*pi*index*(Fc/Fs)))';    % sin(2pi*fa/fs)





y = trem.*x;
    

soundsc(y, Fs);
% write output
%wavwrite(y,Fs,bits,'out_tremolo1.wav');