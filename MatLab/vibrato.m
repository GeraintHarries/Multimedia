function y = vibrato(y, SAMPLERATE, modFreq, width)

ya_alt       = 0;

delay       = width;                                % BASIC DELAY OF INPUT
                                                    % IN SEC
DELAY       = round(delay*SAMPLERATE);              % BASIC DELAY IN #
                                                    % SAMPLES
WIDTH       = round(width*SAMPLERATE);              % MODULATION WIDTH IN
                                                    % # SAMPLES
                         
if WIDTH > DELAY
    error('delay greater than basic delay!');
    return;
end

MODFREQ     = modFreq/SAMPLERATE;                   % MODULATION FREQUENCY
                                                    % IN # SAMPLES
LEN         = length(x);                            % # OF SAMPLES IN WAV-
                                                    % FILE
L           = 2 + DELAY + WIDTH * 2;                % LENGTH OF ENTIRE 
                                                    % DELAY
DelayLine   = zeros(L,1);                           % MEMORY ALLOCATION FOR
                                                    % ENTIRE DELAY
y           = zeros(size(x));                       % MEMORY ALLOCATION FOR
                                                    % OUTPUT VECTOR

for n = 1: (LEN - 1)
    
    M           = MODFREQ;
    MOD         = sin(M*2*pi*n);
    TAP         = 1 + DELAY + WIDTH*MOD;
    i           = floor(TAP);
    frac        = TAP-i;
    DelayLine   = [x(n) ;DelayLine(1:L-1)];
        
                                                    % LINEAR INTERPOLATION
                                                    
    y(n,1) = DelayLine(i+1)*frac+DelayLaine(i)*(1-frac);
    
                                                    % ALLPASS INTERPOLATION
                                                    
    %y(n,1) = (DelayLine(i+1)+(1-frac)*DelayLine(i)-(1-frac)*ya_alt);
    %ya_alt = ya(n,1);
    
                                                    % SPLINE INTERPOLATION
                                                    
    %y(n,1) = DelayLine(i+1)*frac^3/6
    
        
end