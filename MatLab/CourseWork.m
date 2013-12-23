load handel;

n = 512;
nhop = n/4;
Y = stft(y,n,n,nhop);

specy = abs(Y)/n;

s = imshow(flipud(255*specy));
colormap(hsv);
hold on;

axis manual;
[x,y] = ginput(n);
plot(x,y);

%plot(rectangle('Position',[100,100,100,100]))
rect = getrect();
plot(rect);

h = imrect;
