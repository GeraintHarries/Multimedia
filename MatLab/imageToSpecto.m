function signal = imageToSpecto(path, format)

    % Read in the image and make it symmetric.
    
    image = imread(path, format);
    image = [image; flipud(image)];
    [row, column] = size(image);
    signal = [];

    % Take the ifft of each column of pixels and piece together the results.
    for i = 1 : column

    	spectrogramWindow = image(:, i);
    	signalWindow = real(ifft(spectrogramWindow));
    	signal = [signal; signalWindow];

        spectogram(signal)
        
    end
end