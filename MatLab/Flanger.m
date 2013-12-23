function varargout = Flanger(varargin)
% FLANGER MATLAB code for Flanger.fig
%      FLANGER, by itself, creates a new FLANGER or raises the existing
%      singleton*.
%
%      H = FLANGER returns the handle to a new FLANGER or the handle to
%      the existing singleton*.
%
%      FLANGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLANGER.M with the given input arguments.
%
%      FLANGER('Property','Value',...) creates a new FLANGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Flanger_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Flanger_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Flanger

% Last Modified by GUIDE v2.5 27-Oct-2013 14:10:19

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Flanger_OpeningFcn, ...
                   'gui_OutputFcn',  @Flanger_OutputFcn, ...
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


% --- Executes just before Flanger is made visible.
function Flanger_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Flanger (see VARARGIN)



% Choose default command line output for Flanger
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global WAVEFILE;
global WAVEFREQUENCY;
global MAXTIMEDELAY;
global RATE;

% UIWAIT makes Flanger wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Flanger_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function MaxTimeDelay_Callback(hObject, eventdata, handles)
% hObject    handle to MaxTimeDelay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global MAXTIMEDELAY;
MaxTimeDelay = get(hObject,'Value');
MAXTIMEDELAY = MaxTimeDelay;

% --- Executes during object creation, after setting all properties.
function MaxTimeDelay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxTimeDelay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Amp_Callback(hObject, eventdata, handles)
% hObject    handle to Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global AMP;
amp = get(hObject, 'Value');
AMP = amp;

% --- Executes during object creation, after setting all properties.
function Amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in List.
function List_Callback(hObject, eventdata, handles)
% hObject    handle to List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns List contents as cell array
%        contents{get(hObject,'Value')} returns selected item from List
contents = cellstr(get(hObject,'String'));

global WAVETYPE;

selectedWave = contents{get(hObject, 'Value')};
WAVETYPE = selectedWave;
display(WAVETYPE)


% --- Executes during object creation, after setting all properties.
function List_CreateFcn(hObject, eventdata, handles)
% hObject    handle to List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DoFlanger();
close;



function RateValue_Callback(hObject, eventdata, handles)
% hObject    handle to RateValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RateValue as text
%        str2double(get(hObject,'String')) returns contents of RateValue as a double
value = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function RateValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RateValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DoFlanger()
global WAVEFILE;
global WAVEFREQUENCY;
global AMP;
global MAXTIMEDELAY;

x = WAVEFILE;
Fs = WAVEFREQUENCY;
amp = AMP;
max_time_delay = MAXTIMEDELAY;

rate = 1;
index=1:length(x);

sin_ref = (sin(2*pi*index*(rate/Fs)))';

max_samp_delay=round(max_time_delay*Fs);

y = zeros(length(x), 1);

y(1:max_samp_delay)=x(1:max_samp_delay);

for i = (max_samp_delay+1):length(x),
    cur_sin=abs(sin_ref(i));
    cur_delay=ceil(cur_sin*max_samp_delay);
    y(i) = (amp*x(i)) + amp*(x(i-cur_delay));
end

wavwrite(y,Fs,outfile);








