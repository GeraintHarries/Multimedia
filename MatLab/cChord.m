clear all;
close all;

% simple  example of Additive synthesis


Fs = 22050;

%Create 3 sine waves of different frequencies f1,f2,f3

f1 = 523.2511305;
f2 = 659.255114;
f3 = 783.9908721;
f4 = 932.327523;


y1 = synth(f1,2,0.9,Fs,'saw');



doit = input('\nPlay/Plot Raw Sine y1? Y/[N]:\n\n', 's');

if doit == 'y',
figure(1)
plot(y1(1:440));
sound(y1,Fs);
end



y2 = synth(f2,2,0.9,Fs,'sine');

doit = input('\nPlay/Plot Raw Sine y2? Y/[N]:\n\n', 's');


if doit == 'y',
figure(2)
plot(y2(1:440));
sound(y2,Fs);
end


y3 = synth(f3,2,0.9,Fs,'saw');


doit = input('\nPlay/Plot Raw Sine y3? Y/[N]:\n\n', 's');


if doit == 'y',
figure(3)
plot(y3(1:440));
sound(y3,Fs);
end

y4 = synth(f4,2,0.9,Fs,'sine');


doit = input('\nPlay/Plot Raw Sine y4? Y/[N]:\n\n', 's');


if doit == 'y',
figure(4)
plot(y4(1:440));
sound(y4,Fs);
end

%  Add Waves together

yadd = (y1 + y2 + y3 + y4)/4;


doit = input('\nPlay/Plot Additive Sines together? Y/[N]:\n\n', 's');

if doit == 'y',
figure(4)
plot(yadd(1:440));
sound(yadd,Fs);
end


