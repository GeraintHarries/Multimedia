%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%     STUDENT NAME:    GERAINT HARRIES;     STUDENT NUMBER: 1100682       %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MATLAB INITIALISERS                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = reverb(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @reverb_OpeningFcn, ...
                   'gui_OutputFcn',  @reverb_OutputFcn, ...
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
function reverb_OpeningFcn(hObject, eventdata, handles, varargin)
global GAIN;
global DELAY;
global WAVEFILE;

handles.output = hObject;
guidata(hObject, handles);
function varargout = reverb_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               GET GAIN                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gain_Callback(hObject, eventdata, handles)
global GAIN;
GAIN = str2double(get(hObject, 'String'));
function gain_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               GET DELAY                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Delay_Callback(hObject, eventdata, handles)
global DELAY;
DELAY = str2double(get(hObject, 'String'));
function Delay_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           	APPLY REVERB                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% THIS FUNCTION CREATES A REVERB AFFECT DICTATED BY THE USERS INPUT.      %
% IT CREATES A DELAY VECTOR WHICH USING THE DELAY AND GAIN. IT THEN ADDS  %
% THIS TO THE ORIGINAL AUDIO FILE.                                        %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Apply_Callback(hObject, eventdata, handles)
global WAVEFILE;
global DELAY;
global GAIN;

output                                  = WAVEFILE;
d                                       = DELAY * 5000;

for i = 1:3,
    b =[GAIN zeros(1,round(d/i)) 1];
    a =[1 zeros(1,round(d/i)) GAIN];
    output = filter(b, a, output);
end

WAVEFILE                                  = WAVEFILE + output;
