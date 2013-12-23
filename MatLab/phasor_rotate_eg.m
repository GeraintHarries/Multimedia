% phasor_rotate_eg.m
% Simple Demo of the Power of Phasors for rotation of complex numbers

syms x;  % Create our symbolic variable

fcos = exp(i*0);  % A Phasor (cosine) with no phase.

% Rotate phaser by pi/4 radians  (45 degrees)
frot = fcos*exp(i*pi/4);

% convert back (check) to non-phasor way of thinking

fcos_angle = angle(fcos);  % It's zero!

frot_angle = angle(frot);  % Should be pi/4!