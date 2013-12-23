filename='SexyParty.wav';
% read the sample waveform
[x,Fs,bits] = wavread(filename);
index = 1:length(x);
% Ring Modulate with a sine wave frequency Fc
Fc = 440;
carrier= sin(2*pi*index*(Fc/Fs))';
% Do Ring Modulation
y = x.*carrier;
% write output
wavwrite(y,Fs,bits,'out_ringmod.wav');
