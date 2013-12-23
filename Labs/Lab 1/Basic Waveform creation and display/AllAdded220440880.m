amp = 1;
F_s = 11025;
F_w1 = 220;
F_w2 = 440;
F_w3 = 880;

nsec = 2;
dur = nsec*F_s;

n = 0:dur;

y1 = amp*sin(2*pi*n*F_w1/F_s);
y2 = amp*sin(2*pi*n*F_w2/F_s);
y3 = amp*sin(2*pi*n*F_w3/F_s);

y4 = amp*cos(2*pi*n*F_w1/F_s);
y5 = amp*cos(2*pi*n*F_w2/F_s);
y6 = amp*cos(2*pi*n*F_w3/F_s);

y7 = amp*square(2*pi*n*F_w1/F_s);
y8 = amp*square(2*pi*n*F_w2/F_s);
y9 = amp*square(2*pi*n*F_w3/F_s);

y10 = amp*sawtooth(2*pi*n*F_w1/F_s);
y11 = amp*sawtooth(2*pi*n*F_w2/F_s);
y12 = amp*sawtooth(2*pi*n*F_w3/F_s);

ytot = y1+y2+y3+y4+y5+y6+y7+y8+y9+y10+y11+y12;

figure(14)
plot(ytot(1:500))
title('sine, cosine, square and sawtooth waves at 220, 440, 880, Hz Added')

soundsc(ytot, F_s)


