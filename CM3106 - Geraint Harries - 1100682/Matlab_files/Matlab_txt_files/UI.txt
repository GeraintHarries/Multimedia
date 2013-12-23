%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%     STUDENT NAME:    GERAINT HARRIES;     STUDENT NUMBER: 1100682       %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MATLAB INITIALISERS                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = UI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
function UI_OpeningFcn(hObject, eventdata, handles, varargin)

global WAVEFILE;
WAVEFILE = '';
global WAVEFREQUENCY;
WAVEFREQUENCY = 0;
global FILENAME;
global PLOT;
global SOUNDPLAYER;
global h;
global SPEC;
global EDITEDSPEC;

handles.output = hObject;

guidata(hObject, handles);
function varargout = UI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           OPEN FILE FUNCTION                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function OpenFile_Callback(hObject, eventdata, handles)
global WAVEFILE;
global WAVEFREQUENCY;
global FILENAME;

[FileName,PathName]             = uigetfile('*.wav','Select audio file');
[x, Fs]                         = wavread(FileName);
WAVEFILE                        = x;
WAVEFREQUENCY                   = Fs;
FILENAME                        = FileName;

plot(x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       COMPUTER FOURIER TRANSFORM                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function computeFourier_Callback(hObject, eventdata, handles)
global WAVEFILE;
global TRANS;
global SPEC;

n           = 512;
nhop        = n / 4;
TRANS       = stft(WAVEFILE);
SPEC        = abs(TRANS) / n;
SPEC        = (255 * SPEC);
h           = imshow(SPEC, 'Parent', gca, 'XData', [0 1], 'YData', [0 .5]);

set(h,'HitTest','Off');
colormap(hsv);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           WAH WAH FUNCTION                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function WahWah_Callback(hObject, eventdata, handles)
run('WahWah.m');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           VOLUME SHAPING                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %      
% THIS FUNCTION GENERATES A VOLMUE SHAPED AUDIO FILE USING ADSR. IT       %
% CREATES AN ADSR VECTOR AND MULTIPLIES THE AUDIOFILE BY IT.              %
%                                                                         %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function VolumeShaping_Callback(hObject, eventdata, handles)
global WAVEFILE;

firstQuarter                    = linspace(0,1,(length(WAVEFILE)/4));
secondQuarter                   = linspace(1,0.5,(length(WAVEFILE)/4));
thirdQuarter                    = linspace(0.5,0.5,(length(WAVEFILE)/4));
fourthQuarter                   = linspace(0.5,0,(length(WAVEFILE)/4));


% WHEN DIVIDED THE WAVEFILE LENGTH GIVES A REAL NUMBER THIS MAY OFFSET THE
% ENVELOPE LENGTH WHEN CONCATENATED. ADDING THESE VALUES WILL MAKE SURE THE
% LENGTHS ARE THE SAME
if rem(length(WAVEFILE), 4) == 1
    completeEvelope = [firstQuarter secondQuarter thirdQuarter fourthQuarter 0];
elseif rem(length(WAVEFILE), 4) == 2
    completeEvelope = [firstQuarter secondQuarter thirdQuarter fourthQuarter 0 0];
elseif rem(length(WAVEFILE), 4) == 3
    completeEvelope = [firstQuarter secondQuarter thirdQuarter fourthQuarter 0 0 0];
else
    completeEvelope = [firstQuarter secondQuarter thirdQuarter fourthQuarter];

end

completeEvelope                 = completeEvelope';
WAVEFILE                        = completeEvelope.*WAVEFILE;

plot(WAVEFILE);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           EDIT FUNCTION                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %              
% THIS FUNCTION ALLOWS THE USER TO EDIT THE SPECTROGRAM. IT DOES THIS BY  %
% CREATING MASK THE SAME SIZE AS THE TRANSFORMED WAVEFILE. IT THEN ALLOWS %
% THE USER TO DRAW ON THE MASK. THE BINARY IMAGE OF THE MASK IS THEN      %
% MULTIPLIED BY THE ORIGINAL SPECTROGRAM AND THEN DISPLAYED.              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Edit_Callback(hObject, eventdata, handles)
global TRANS;
global SPEC;
global EDITEDSPEC;

imshow(SPEC, 'Parent', gca, 'XData', [0 1], 'YData', [0 .5]);
colormap(hsv);

hFH                     = imfreehand();
binaryImage             = hFH.createMask();
EDITEDSPEC              = binaryImage.*TRANS;

imshow(EDITEDSPEC);
colormap(hsv);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       AUDIO PLAYBACK FUNCTIONS                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           PLAY FUNCTION                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Play_Callback(hObject, eventdata, handles)
global SOUNDPLAYER;
global WAVEFILE;
global WAVEFREQUENCY;

SOUNDPLAYER = audioplayer(WAVEFILE,WAVEFREQUENCY);
play(SOUNDPLAYER);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           PAUSE FUNCTION                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pause_Callback(hObject, eventdata, handles)
global SOUNDPLAYER;

pause(SOUNDPLAYER);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           RESUME FUNCTION                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function resume_Callback(hObject, eventdata, handles)
global SOUNDPLAYER;

resume(SOUNDPLAYER);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           STOP FUNCTION                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function stop_Callback(hObject, eventdata, handles)
global SOUNDPLAYER;

stop(SOUNDPLAYER);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           RECORD FUNCTION                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function record_Callback(hObject, eventdata, handles)
global WAVEFILE;
global WAVEFREQUENCY;

WAVEFREQUENCY           = 44100;
recObj                  = audiorecorder(WAVEFREQUENCY,24,1);

recordblocking(recObj, 5);
WAVEFILE = getaudiodata(recObj);

plot(WAVEFILE);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             LOOP FUNCTION                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Loop_Callback(hObject, eventdata, handles)
global WAVEFILE;
global WAVEFREQUENCY;

n=0;
while n ~= 1;
    sound(WAVEFILE, WAVEFREQUENCY);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           REVERSE FUNCTION                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Reverse_Callback(hObject, eventdata, handles)
global WAVEFILE;
global WAVEFREQUENCY;
global SOUNDPLAYER;

WAVEFILE            = flipud(WAVEFILE);
SOUNDPLAYER         = audioplayer(WAVEFILE,WAVEFREQUENCY);
play(SOUNDPLAYER);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           SAVE FUNCTION                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %              
% THIS FUNCTION ALLOWS THE USER TO SAVE THE EDITED SEPCTROGRAM            %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function saveEdit_Callback(hObject, eventdata, handles)
global WAVEFILE;
global EDITEDSPEC;

WAVEFILE = istft(EDITEDSPEC, 256, 256, floor(256/2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           REVERB FUNCTION                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function reverb_Callback(hObject, eventdata, handles)
run('reverb.m');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           RINGMOD FUNCTION                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% THIS FUNCTION ALLOWS THE USER TO APPLY RING MODULATION TO THEIR AUDIO   %
% FILE. A CARRIER VECTOR IS CREATED AND THEN MULTIPLIED WITH THE          %
% AUDIOFILE                                                               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RingMod_Callback(hObject, eventdata, handles)
global WAVEFILE;
global WAVEFREQUENCY;

index               = 1:length(WAVEFILE);
carrier             = sin(2*pi*index*(440/WAVEFREQUENCY))';
WAVEFILE            = WAVEFILE.*carrier;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           TREMOLO FUNCTION                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Tremolol_Callback(hObject, eventdata, handles)
run('trem.m');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           KRAKEN FUNCTION                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pushbutton42_Callback(hObject, eventdata, handles)
h = warndlg('The Kraken Awakes!');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           REVERB CONVOLUTION FUNCTION                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% THIS FUNCTION ALLOWS THE USER TO SELECT A FILE TO GENERATE REVERB       %
% CONVOLUTION ON. THE FUNCTION SIMPLY CALCULATES THE DOT PRODUCT AND      %
% SAVES IT.                                                               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ReverbConvolution_Callback(hObject, eventdata, handles)
global WAVEFILE;

[FileName,PathName]             = uigetfile('*.wav','Select audio file');
[x, Fs]                         = wavread(FileName);
ImpulseWaveFile                 = x;
WAVEFILE                        = fconv(WAVEFILE, ImpulseWaveFile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       USER INPUT PHASE VOCODER FUNCTION                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PhaseVocoder_Callback(hObject, eventdata, handles)
run('PhaseVecoder.m');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       SPECIFIC PHASE VOCODER FUNCTION                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% THIS FUNCTION TAKES IN TWO ARGUEMENTS, NUMERATOR AND DENOMINATOR. THESE %
% THEN CREATE A PITCH VALUE TO BE PLAYED. IT IS PLAYED BACK AT REAL TIME. %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SetPhaseVocoder(Numerator, Denominator)
global WAVEFILE;
global WAVEFREQUENCY;

division                    = Denominator/ Numerator;
ypvoc                       = pvoc(WAVEFILE, division); 
output                      = resample(ypvoc,Denominator,Numerator);

sound(output, WAVEFREQUENCY);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           SPECIFIC NOTE FUNCTIONS                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function B3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(2048,2187);
function A3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(5000,6000);
function G3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(125,169);
function F3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(2,3);
function E3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(4098,6561);
function ASharp3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(8,9);
function GSharp3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(64,81);
function FSharp3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(512,729);
function DSharp3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(16,27);
function D3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(32768,59046);
function C3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(1,2);
function CSharp3_Callback(hObject, eventdata, handles)
SetPhaseVocoder(128,243);
function B4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(243,128);
function A4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(27,16);
function G4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(3,2);
function F4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(169,125);
function E4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(81,64);
function ASharp4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(59046,32768);
function GSharp4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(6561,4098);
function FSharp4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(729,512);
function DSharp4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(6000,5000);
function D4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(9,8);
function C4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(1,1);
function CSharp4_Callback(hObject, eventdata, handles)
SetPhaseVocoder(2187,2048);
function C5_Callback(hObject, eventdata, handles)
SetPhaseVocoder(2,1);
