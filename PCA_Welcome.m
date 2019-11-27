function varargout = PCA_Welcome(varargin)
%PCA_WELCOME M-file for PCA_Welcome.fig
%      PCA_WELCOME, by itself, creates a new PCA_WELCOME or raises the existing
%      singleton*.
%
%      H = PCA_WELCOME returns the handle to a new PCA_WELCOME or the handle to
%      the existing singleton*.
%
%      PCA_WELCOME('Property','Value',...) creates a new PCA_WELCOME using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PCA_Welcome_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PCA_WELCOME('CALLBACK') and PCA_WELCOME('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PCA_WELCOME.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCA_Welcome

% Last Modified by GUIDE v2.5 09-Oct-2019 09:47:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCA_Welcome_OpeningFcn, ...
                   'gui_OutputFcn',  @PCA_Welcome_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before PCA_Welcome is made visible.
function PCA_Welcome_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for PCA_Welcome
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCA_Welcome wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PCA_Welcome_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% disp('NEXT')

close (handles.figure1);
run('Import_Data');


%% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% disp('CANCEL')
close (handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% Hint: delete(hObject) closes the figure
delete(hObject);
