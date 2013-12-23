amp = 1;
F_s = 11025;
F_w1 = 220;
F_w2 = 440;
F_w3 = 880;

nsec = 2;
dur = nsec*F_s;

n = 0:dur;

y1 = amp*square(2*pi*n*F_w1/F_s);
y2 = amp*square(2*pi*n*F_w2/F_s);
y3 = amp*square(2*pi*n*F_w3/F_s);

figure(14)
subplot(3,1,1)
plot(y1(1:500))
title('220 Hz')
subplot(3,1,2)
plot(y2(1:500))
title('440 Hz')
subplot(3,1,3)
plot(y3(1:500))
title('880 Hz')