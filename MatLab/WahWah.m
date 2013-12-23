%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MATLAB INITIALISERS                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = WahWah(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WahWah_OpeningFcn, ...
                   'gui_OutputFcn',  @WahWah_OutputFcn, ...
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
function WahWah_OpeningFcn(hObject, eventdata, handles, varargin)
global WAVEFILE;
global FILENAME;
global DAMP;
global MINCUTOFF;
global MAXCUTOFF;
global FREQUENCY;
global WAVEFREQUENCY;

handles.output = hObject;
guidata(hObject, handles);
function varargout = WahWah_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           GET MAX CUTOFF                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function MinCutOff_Callback(hObject, eventdata, handles)
global MINCUTOFF;
MINCUTOFF = str2double(get(hObject, 'String'));
function MinCutOff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           GET MIN CUTOFF                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function MaxCutOff_Callback(hObject, eventdata, handles)
global MAXCUTOFF;
MAXCUTOFF = str2double(get(hObject, 'String'));
function MaxCutOff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              GET DAMP                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Damp_Callback(hObject, eventdata, handles)
global DAMP;
DAMP = str2double(get(hObject, 'String'));
function Damp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           GET FREQUENCY                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Frequency_Callback(hObject, eventdata, handles)
global FREQUENCY;
FREQUENCY = str2double(get(hObject, 'String'));
function Frequency_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               DO WAH WAH                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% THIS FUNCTION RUNS THE WAH WAH EFFECT ON THE AUDIOFILE. IT DOES SO BY   %
% CREATING A MOVING BAND PASS VECTOR AND APPLYING IT TO THE AUDIOFILE.    %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pushbutton1_Callback(hObject, eventdata, handles)
global WAVEFILE;
global WAVEFREQUENCY;

global DAMP;
global MAXCUTOFF;
global MINCUTOFF;
global FREQUENCY;

x                                       = WAVEFILE;
Fs                                      = WAVEFREQUENCY;
damp                                    = DAMP;
minf                                    = MINCUTOFF;
maxf                                    = MAXCUTOFF;
Fw                                      = FREQUENCY;
delta                                   = Fw/Fs;
Fc                                      = minf:delta:maxf;

while(length(Fc) < length(x))
    Fc= [ Fc (maxf:-delta:minf) ];
    Fc= [ Fc (minf:delta:maxf) ];
end

Fc                                      = Fc(1:length(x));
F1                                      = 2*sin((pi*Fc(1))/Fs);
Q1                                      = 2*damp;

yh                                      =zeros(size(x));
yb                                      =zeros(size(x));
yl                                      =zeros(size(x));

yh(1)                                   = x(1);
yb(1)                                   = F1*yh(1);
y1(1)                                   = F1*yb(1);

for n=2:length(x),
    yh(n) = x(n) - y1(n-1) - Q1*yb(n-1);
    yb(n) = F1*yh(n) + yb(n-1);
    y1(n) = F1*yb(n) + y1(n-1);
    F1 = 2*sin((pi*Fc(n))/Fs);
end

maxyb                                   = max(abs(yb));
yb                                      = yb/maxyb;
WAVEFILE                                = yb;

close;


