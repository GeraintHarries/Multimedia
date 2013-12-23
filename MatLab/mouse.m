function varargout = mouse(varargin)
% MOUSE MATLAB code for mouse.fig
%      MOUSE, by itself, creates a new MOUSE or raises the existing
%      singleton*.
%
%      H = MOUSE returns the handle to a new MOUSE or the handle to
%      the existing singleton*.
%
%      MOUSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOUSE.M with the given input arguments.
%
%      MOUSE('Property','Value',...) creates a new MOUSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mouse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mouse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mouse

% Last Modified by GUIDE v2.5 03-Dec-2013 19:15:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mouse_OpeningFcn, ...
                   'gui_OutputFcn',  @mouse_OutputFcn, ...
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


% --- Executes just before mouse is made visible.
function mouse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mouse (see VARARGIN)

% Choose default command line output for mouse
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mouse wait for user response (see UIRESUME)
% uiwait(handles.fig_mouse);


% --- Outputs from this function are returned to the command line.
function varargout = mouse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse motion over figure - except title and menu.
function fig_mouse_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to fig_mouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos = get(hObject, 'currentPoint');
x = pos(1); y = pos(2);
set(handles.x_loc, 'String', ['x loc:' num2str(x)]);
set(handles.y_loc, 'String', ['x loc:' num2str(y)]);



