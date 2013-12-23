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

figure(14)
subplot(4,3,1)
plot(y1(1:500))
title('Sine 220 Hz')
subplot(4,3,2)
plot(y2(1:500))
title('Sine 440 Hz')
subplot(4,3,3)
plot(y3(1:500))
title('Sine 880 Hz')

subplot(4, 3, 4)
plot(y4(1:500))
title('Cosine 220 Hz')
subplot(4, 3, 5)
plot(y5(1:500))
title('Cosine 440 Hz')
subplot(4,3,6)
plot(y6(1:500))
title('Cosine 880 Hz')

subplot(4,3,7)
plot(y7(1:500))
title('Square 220 Hz')
subplot(4,3,8)
plot(y8(1:500))
title('Square 440 Hz')
subplot(4,3,9)
plot(y9(1:500))
title('Square 880 Hz')

subplot(4,3,10)
plot(y10(1:500))
title('Sawtooth 220 Hz')
subplot(4,3,11)
plot(y11(1:500))
title('Sawtooth 440 Hz')
subplot(4,3,12)
plot(y12(1:500))
title('Sawtooth 880 Hz')


