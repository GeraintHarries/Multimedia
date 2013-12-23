function varargout = UI(varargin)
% UI MATLAB code for UI.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI

% Last Modified by GUIDE v2.5 28-Nov-2013 18:45:25

% Begin initialization code - DO NOT EDIT



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
% End initialization code - DO NOT EDIT

% --- Executes just before UI is made visible.
function UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI (see VARARGIN)

global WAVEFILE;
WAVEFILE = '';
global WAVEFREQUENCY;
WAVEFREQUENCY = 0;
global FILENAME;
global PLOT;
global SOUNDPLAYER;

% Choose default command line output for UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OpenFile.
function OpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WAVEFILE;
global WAVEFREQUENCY;
global FILENAME;


[FileName,PathName] = uigetfile('*.wav','Select audio file');
[x, Fs]= wavread(FileName);
WAVEFILE = x;
WAVEFREQUENCY = Fs;
FILENAME = FileName;

plot(x);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WAVEFILE;
global PLOT;

%y = WAVEFILE;

%t = 1:size(WAVEFILE);

%[S,F,T] = spectrogram(y,512,256,512,1000,'yaxis');
%PLOT = pcolor(T,F,abs(S));
%colormap('HSV');
%set(PLOT,'Color','jet');
%xlabel('Time'); ylabel('Hz');

spectrogram(WAVEFILE, 512, 256, 512, 1000, 'yaxis');


%imshow(flipud(255*specy))
%colormap(hsv);

% --- Executes on button press in Flanger.
function Flanger_Callback(hObject, eventdata, handles)
% hObject    handle to Flanger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WAVEFILE;
run('Flanger.m');
pushbutton2_Callback(hObject,eventdata, handles);


% --- Executes on button press in WahWah.
function WahWah_Callback(hObject, eventdata, handles)
% hObject    handle to WahWah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('WahWah.m');

% --- Executes on button press in VolumeShaping.
function VolumeShaping_Callback(hObject, eventdata, handles)
% hObject    handle to VolumeShaping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Vibrato.
function Vibrato_Callback(hObject, eventdata, handles)
% hObject    handle to Vibrato (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global WAVEFILE;
% global WAVEFREQUENCY;
% 
% Width = 10;
% Delay = 10;
% Modfreq = 10;
% 
% ya_alt=0;
% Delay=Width; % basic delay of input sample in sec
% DELAY=round(Delay*WAVEFREQUENCY); % basic delay in # samples
% WIDTH=round(Width*WAVEFREQUENCY); % modulation width in # samples
% if WIDTH>DELAY
%     error('delay greater than basic delay !!!');
%     return;
% end;
% 
% MODFREQ=Modfreq/WAVEFREQUENCY; % modulation frequency in # samples
% LEN=length(WAVEFILE); % # of samples in WAV-file
% L=2+DELAY+WIDTH*2; % length of the entire delay
% Delayline=zeros(L,1); % memory allocation for delay
% y=zeros(size(WAVEFILE));
% for n=1:(LEN-1)
%     M=MODFREQ;
%     MOD=sin(M*2*pi*n);
%     ZEIGER=1+DELAY+WIDTH*MOD;
%     i=floor(ZEIGER);
%     frac=ZEIGER-i;
%     Delayline=[WAVEFILE(n);Delayline(1:pitL-1)];
%     %---Linear Interpolation-----------------------------
%     y(n,1)=Delayline(i+1)*frac+Delayline(i)*(1-frac);
%     %---Allpass Interpolation------------------------------
%     %y(n,1)=(Delayline(i+1)+(1-frac)*Delayline(i)-(1-frac)*ya_alt);
%     %ya_alt=ya(n,1);
% end
% 
% WAVEFILE = y;
% soundsc(WAVEFILE);


% --- Executes on button press in Phaser.
function Phaser_Callback(hObject, eventdata, handles)
% hObject    handle to Phaser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SOUNDPLAYER;
global WAVEFILE;
global WAVEFREQUENCY;

SOUNDPLAYER = audioplayer(WAVEFILE,WAVEFREQUENCY);
play(SOUNDPLAYER);

function Pitch_Callback(hObject, eventdata, handles)
% hObject    handle to Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pitch as text
%        str2double(get(hObject,'String')) returns contents of Pitch as a double
global WAVEFILE;

pitchValue = str2double(get(hObject, 'String'));
t = (0:1023'/1024);
hertzConvertValue = cos(pitchValue * 2 * pi * t);
WAVEFILE = (hilbert(WAVEFILE).*hilbert(hertzConvertValue));

% --- Executes during object creation, after setting all properties.
function Pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Edit.
function Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global WAVEFILE;

brush on


% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SOUNDPLAYER;
%global WAVEFILE;
%global WAVEFREQUENCY;

%SOUNDPLAYER = audioplayer(WAVEFILE,WAVEFREQUENCY);
pause(SOUNDPLAYER);

% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SOUNDPLAYER;
%global WAVEFILE;
%global WAVEFREQUENCY;

%SOUNDPLAYER = audioplayer(WAVEFILE,WAVEFREQUENCY);
resume(SOUNDPLAYER);

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SOUNDPLAYER;

stop(SOUNDPLAYER);


% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WAVEFILE;
global WAVEFREQUENCY;

WAVEFREQUENCY = 44100;
recObj = audiorecorder(WAVEFREQUENCY,24,1);
recordblocking(recObj, 5);
WAVEFILE = getaudiodata(recObj);
plot(WAVEFILE);


% --- Executes on button press in saveEdit.
function saveEdit_Callback(hObject, eventdata, handles)
% hObject    handle to saveEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WAVEFILE;

hBrushLine = findall(gca, 'tag', 'Brushing');
brushedData = get(hBrushLine, {'Xdata', 'Ydata'});

%WAVEFILE = WAVEFILE - brushedData;

display(brushedData{1});