F_s = 22015;
dur = nsec*F_s;
n = 0:dur;

y = rand(1,22015);
soundsc(y)

%LOW PASS

[B,A] = butter(1,0.04,'low');
yLowPass = filter(B,A,y);
soundsc(yLowPass)
figure(1)
plot(yLowPass(1:F_s))
title('White Noise Low Pass Filter')

%HIGH PASS

[B,A] = butter(1,0.5,'high');
yHighPass = filter(B,A,y);
soundsc(yHighPass)
figure(2)
plot(yHighPass(1:F_s))
title('White Noise High Pass Filter')

%BAND PASS

[B,A] = butter(1, [0.5,0.6], 'bandpass');
yBandPass = filter(B,A,y);
soundsc(yBandPass)
figure(3)
plot(yBandPass(1:F_s))
title('White Noise Band Pass Filter')

