amp = 1;
F_s = 11025;
F_w = 220;
nsec = 2;
dur = nsec*F_s;

n = 0:dur;

y = amp*cos(2*pi*n*F_w/F_s);

figure(4)
plot(y(1:500))
title('A simple cosine wave of frequency 220 Hz')

soundsc(y, F_s)