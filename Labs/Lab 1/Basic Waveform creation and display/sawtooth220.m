amp = 1;
F_s = 11025;
F_w = 220;
nsec = 2;
dur = nsec*F_s;

n = 0:dur;

y = amp*sawtooth(2*pi*n*F_w/F_s);

figure(10)
plot(y(1:500))
title('A simple sawtooth wave of frequency 220 Hz')

soundsc(y,11025);

soundsc(y, F_s)