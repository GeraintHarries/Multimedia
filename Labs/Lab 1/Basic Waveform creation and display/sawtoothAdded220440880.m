amp = 1;
F_s = 11025;
F_w1 = 220;
F_w2 = 440;
F_w3 = 880;

nsec = 2;
dur = nsec*F_s;

n = 0:dur;

y1 = amp*sawtooth(2*pi*n*F_w1/F_s);
y2 = amp*sawtooth(2*pi*n*F_w2/F_s);
y3 = amp*sawtooth(2*pi*n*F_w3/F_s);

ytot = y1+y2+y3

figure(13)
plot(ytot(1:500))
title('3 sawtooth waves at frequencies 220, 440, 880 Hz added together')

soundsc(ytot, F_s)