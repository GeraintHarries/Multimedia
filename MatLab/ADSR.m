function ADSR(waveform, attack, delay, sustain, release, gain)

soundsc(waveform)

for i=0:attack,

   attackVector = linspace(0,1);

end

for i=0:delay,

   delayVector = linspace(1,0.5);

end

for i=0:sustain,

   sustainVector = linspace(0.5,0.5);
end


for i=0:release,

   releaseVector = linspace(0.5,0);

end

ADSR = [attackVector delayVector sustainVector releaseVector];
figure(5);
plot(ADSR)

newWaveForm = ADSR.* waveform;
newWaveForm = newWaveForm * gain;

figure(1);
plot(waveform)
figure(2);
plot(newWaveForm)

soundsc(newWaveForm)
