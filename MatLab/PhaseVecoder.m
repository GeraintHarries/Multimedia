%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MATLAB INITIALISERS                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = PhaseVecoder(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PhaseVecoder_OpeningFcn, ...
                   'gui_OutputFcn',  @PhaseVecoder_OutputFcn, ...
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
function PhaseVecoder_OpeningFcn(hObject, eventdata, handles, varargin)
global WAVEFILE;
global WAVEFREQUENCY;
global NUMERATOR;
global DEBOMINATOR;


handles.output = hObject;
guidata(hObject, handles);
function varargout = PhaseVecoder_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          GET NUMERATOR                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Numerator_Callback(hObject, eventdata, handles)
global NUMERATOR;
NUMERATOR = str2double(get(hObject, 'String'));
function Numerator_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           GET DENOMINATOR                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Denominator_Callback(hObject, eventdata, handles)
global DENOMINATOR;
DENOMINATOR = str2double(get(hObject, 'String'));
function Denominator_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    GENERATE AND PLAY SOUND VOCODER                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% THIS FUNCTION PLAYS A HIGHER PITCHED BY SAME SPEED VERSION OF AN        %
% AUDIOFILE. IT GENERATES A SLOWER/ FASTER FILE USING PVOC                %
% (USING THE RATOI OF THE NUMBERATOR AND DENOMINATOR). IT THEN RESAMPLES  %
% THE AUDIOFILE USING THE RATIO OF DENOMINATOR AND NUMBERATOR.            %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function save_Callback(hObject, eventdata, handles)
global WAVEFILE;
global WAVEFREQUENCY;
global DENOMINATOR;
global NUMERATOR;

division                    = NUMERATOR/ DENOMINATOR;
ypvoc                       = pvoc(WAVEFILE, division); 
output                      = resample(ypvoc,DENOMINATOR,NUMERATOR); 

sound(output, WAVEFREQUENCY);
