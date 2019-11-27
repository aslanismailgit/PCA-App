function varargout = Results(varargin)
% RESULTS MATLAB code for Results.fig
%      RESULTS, by itself, creates a new RESULTS or raises the existing
%      singleton*.
%
%      H = RESULTS returns the handle to a new RESULTS or the handle to
%      the existing singleton*.
%
%      RESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTS.M with the given input arguments.
%
%      RESULTS('Property','Value',...) creates a new RESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Results_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Results_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Results

% Last Modified by GUIDE v2.5 15-Oct-2019 10:11:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Results_OpeningFcn, ...
                   'gui_OutputFcn',  @Results_OutputFcn, ...
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

% --- Executes just before Results is made visible.
function Results_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Results (see VARARGIN)

% Choose default command line output for Results
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Results wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Results_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


global Data
set (handles.text3,'String', (Data.NumberCompSelected));
set (handles.text5,'String', (Data.latentS(Data.NumberCompSelected)));
set (handles.uitable1,'Data', Data.coeff(:,1:Data.NumberCompSelected));
set (handles.uitable1,'RowName', Data.colheaders);
set (handles.uitable1,'ColumnName', Data.CompNames(1:Data.NumberCompSelected));

%% --- Executes on button press in pushbutton1.
% BACK
function pushbutton1_Callback(hObject, eventdata, handles)
close (handles.figure1);
run('PCA1');


%% --- Executes on button press in pushbutton2.
% CREATE REPORT
function pushbutton2_Callback(hObject, eventdata, handles)
global Data
[Data]=CreateTextReport(Data);


%%--- Executes on button press in pushbutton3.
% FINISH
function pushbutton3_Callback(hObject, eventdata, handles)
close (handles.figure1);

%% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global Data
figure()
plot(Data.score(:,1),Data.score(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global Data
figure()
h1 = biplot(double(Data.coeff(:,1:2)),'Scores',double(Data.score(:,1:2)),...
    'Color','b','Marker','.','VarLabels',Data.colheaders);
