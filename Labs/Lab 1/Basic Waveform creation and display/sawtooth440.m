amp = 1;
F_s = 11025;
F_w = 440;
nsec = 2;
dur = nsec*F_s;

n = 0:dur;

y = amp*sawtooth(2*pi*n*F_w/F_s);

figure(11)
plot(y(1:500))
title('A simple sawtooth wave of frequency 440 Hz')

soundsc(y, F_s)