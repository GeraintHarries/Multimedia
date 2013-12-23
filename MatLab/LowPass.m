Fs = 22050;
y = synth(440, 2, 0.9,Fs,'saw');

soundsc(y,Fs)

[B,A] = butter(1,0.04,'low');
yf = filter(B,A,y);
soundsc(yf,Fs)

[B,A] = butter(4,0.04,'low');
yf2 = filter(B,A,y);
soundsc(yf2,Fs)

amp = 1;
F_s = 11025;
F_w = 220;
nsec = 2;
dur = nsec*F_s;

n = 0:dur;

y = amp*square(2*pi*n*F_w/F_s);

soundsc(y,Fs)

[B,A] = butter(1,0.04,'low');
yf = filter(B,A,y);
soundsc(yf,Fs)

[B,A] = butter(4,0.04,'low');
yf2 = filter(B,A,y);
soundsc(yf2,Fs)




