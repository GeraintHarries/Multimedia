% ring_mod.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filename='didntwork.wav';


% read the sample waveform
[x,Fs,bits] = wavread(filename);

index = 1:length(x);

% Ring Modulate with a sine wave frequency Fc

Fc = 440;

carrier= sin(2*pi*index*(Fc/Fs))'; 


y = x.*carrier;

% write output
wavwrite(y,Fs,bits,'out_ringmod.wav');

soundsc(y, Fs);

%soundsc(y, Fs);

%create a modulator sine wave frequency Fx

Fx = 200;

modulator = sin(2*pi*index*(Fx/Fs))'; 


% ring modulate with sine wave, freq. Fc

y = modulator.*carrier;

% write output
wavwrite(y,Fs,bits,'twosine_ringmod.wav');