%READ FILE
[x, Fs] = wavread('acoustic.wav');

% CREATE SPECTROGRAM

    whos x;

    n = 512; % Window size
    nhop = n / 4; % Frame offset

    transformation = stft(x, n, n, nhop, Fs);
    %transformation = stft(x);
%DISPLAY SPEC
    
    spec = abs(transformation) / n;
    spec = flipud(255 * spec);

    h = imshow(spec, 'Parent', gca, 'XData', [0 1], 'YData', [0 .5]);
    set(h,'HitTest','Off');

    colormap(hsv);

% CREATE MASK

    [N, M] = size(transformation);
    
    whos transformation;
    
    mask = ones(N, M);
    
    mask(1:256, 100:128) = 0; 

% MAKE NEW SPECTROGRAM

    whos mask spec

    productMatrix = mask.*transformation;

    transformation = istft(productMatrix, n, n, nhop);
    
    %transformation = istft(productMatrix, 256, 256, floor(256/2));
    

%DISPLAY NEW SCPECTROGRAM

    n = 512; % Window size
    nhop = n / 4; % Frame offset

    %spec = abs(transformation) / n;
    %spec = flipud(255 * spec);

% This is necessary to make the axis responsive to mouse clicks, rather
% than the children.
    h = imshow(productMatrix, 'Parent', gca, 'XData', [0 1], 'YData', [0 .5]);
    set(h,'HitTest','Off');
    
    colormap(hsv);
    
    transformation = transformation';
    
    sound(transformation, Fs);
    
    whos productMatrix spec mask transformation
