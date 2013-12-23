function varargout = EnvelopeShaping(varargin)
% ENVELOPESHAPING MATLAB code for EnvelopeShaping.fig
%      ENVELOPESHAPING, by itself, creates a new ENVELOPESHAPING or raises the existing
%      singleton*.
%
%      H = ENVELOPESHAPING returns the handle to a new ENVELOPESHAPING or the handle to
%      the existing singleton*.
%
%      ENVELOPESHAPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENVELOPESHAPING.M with the given input arguments.
%
%      ENVELOPESHAPING('Property','Value',...) creates a new ENVELOPESHAPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EnvelopeShaping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EnvelopeShaping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EnvelopeShaping

% Last Modified by GUIDE v2.5 02-Dec-2013 23:47:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EnvelopeShaping_OpeningFcn, ...
                   'gui_OutputFcn',  @EnvelopeShaping_OutputFcn, ...
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


% --- Executes just before EnvelopeShaping is made visible.
function EnvelopeShaping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EnvelopeShaping (see VARARGIN)
global WAVEFILE;
global WAVEFREQUENCY;
global ATTACK;
global DELAY;
global SUSTAIN;
global RELEASE;

% Choose default command line output for EnvelopeShaping
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EnvelopeShaping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EnvelopeShaping_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function DelayLenth_Callback(hObject, eventdata, handles)
% hObject    handle to DelayLenth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DelayLenth as text
%        str2double(get(hObject,'String')) returns contents of DelayLenth as a double
global DELAY;
DELAY = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function DelayLenth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DelayLenth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global WAVEFILE;
global WAVEFREQUENCY;
global ATTACK;
global DELAY;
global SUSTAIN;
global RELEASE;

ATTACK = 1/ATTACK;
DELAY = 1/DELAY;
SUSTAIN = 1/SUSTAIN;
RELEASE = 1/RELEASE;



firstQuarter = linspace(0,1,(length(WAVEFILE)/ATTACK)+1);
secondQuarter = linspace(1,0.5,(length(WAVEFILE)/DELAY)+1);
thirdQuarter = linspace(0.5,0.5,(length(WAVEFILE)/SUSTAIN)+1);
fourthQuarter = linspace(0.5,0,(length(WAVEFILE)/RELEASE));

completeEvelope = [firstQuarter secondQuarter thirdQuarter fourthQuarter];

completeEvelope = completeEvelope';

WAVEFILE = completeEvelope.*WAVEFILE;
plot(WAVEFILE);


function AttackLength_Callback(hObject, eventdata, handles)
% hObject    handle to AttackLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AttackLength as text
%        str2double(get(hObject,'String')) returns contents of AttackLength as a double
global ATTACK;
ATTACK = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function AttackLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AttackLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SustainLength_Callback(hObject, eventdata, handles)
% hObject    handle to SustainLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SustainLength as text
%        str2double(get(hObject,'String')) returns contents of SustainLength as a double
global SUSTAIN;
SUSTAIN = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function SustainLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SustainLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ReleaseLength_Callback(hObject, eventdata, handles)
% hObject    handle to ReleaseLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ReleaseLength as text
%        str2double(get(hObject,'String')) returns contents of ReleaseLength as a double
global RELEASE;
RELEASE = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function ReleaseLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ReleaseLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
