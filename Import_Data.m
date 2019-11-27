function varargout = Import_Data(varargin)
% IMPORT_DATA MATLAB code for Import_Data.fig
%      IMPORT_DATA, by itself, creates a new IMPORT_DATA or raises the existing
%      singleton*.
%
%      H = IMPORT_DATA returns the handle to a new IMPORT_DATA or the handle to
%      the existing singleton*.
%
%      IMPORT_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_DATA.M with the given input arguments.
%
%      IMPORT_DATA('Property','Value',...) creates a new IMPORT_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Import_Data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Import_Data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Import_Data

% Last Modified by GUIDE v2.5 14-Oct-2019 18:15:22

%% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Import_Data_OpeningFcn, ...
                   'gui_OutputFcn',  @Import_Data_OutputFcn, ...
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


%% --- Executes just before Import_Data is made visible.
function Import_Data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Import_Data (see VARARGIN)

% Choose default command line output for Import_Data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Import_Data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% --- Outputs from this function are returned to the command line.
function varargout = Import_Data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% disp('SELECT FILE')

[file,path,indx] = uigetfile ('.txt');
filename=[path file];

D.file=file;
D.path=path;
D.filename=filename;

set (hObject, 'UserData', D);
set(handles.text4,'String',file);

%% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global Data
% disp('IMPORT DATA')

b=get(handles.pushbutton1);
D=b.UserData;

b=get(handles.uipanel3,'SelectedObject');
% choise=get(b,'String')
switch get(b,'String'); % Get Tag of selected object.
    case 'Tab';
%         display('Tab');
        delimiterIn = '\t';
    case 'Comma';
%         display('Comma');
        delimiterIn = ',';
    case 'Semicolon';
%         display('Semicolon');
        delimiterIn = ';';
    case 'Space';
%         display('Space');
        delimiterIn = ' ';
end
%% On ERROR
retry=true;
while retry
    try 
        Data=importdata(D.filename,delimiterIn);
        [a b]=size(Data.data);
        Data.IsPcaDone=0; %For reporting
        retry=false;
        Summary_Text1=['Number of variables   : ' num2str(b)];
        Summary_Text2=['Number of observation  :' num2str(a)];
        if length(Summary_Text1)==length(Summary_Text2)
            Summary_Text=[Summary_Text1;Summary_Text2];
        elseif length(Summary_Text1)>length(Summary_Text2)
            d=length(Summary_Text1)-length(Summary_Text2);
            t=' ';
            for i=1:d-1
                t=[t ' '];
            end
            Summary_Text=[Summary_Text1;[Summary_Text2 t]];
        elseif length(Summary_Text1)<length(Summary_Text2)
            d=length(Summary_Text2)-length(Summary_Text1);
            t=' ';
            for i=1:d-1
                t=[t ' '];
            end
            Summary_Text=[[Summary_Text1 t];Summary_Text2];
        end
        set(handles.text3,'String',Summary_Text);

        Data.filename=D.filename;
        Data.file=D.file;
        Data.path=D.path;
        %Er_save('Data.mat', 'Data');
%         display(Data)
       
    catch
        Title='ERROR MESSAGE';
        msgbox('Proper Data and/or Column seperator is not selected',...
            Title);
         retry=false;
    end
end
        




%% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% disp('BACK')
run('PCA_Welcome');
close (handles.figure1);



%% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% disp('CLEAR')
set(handles.text3,'String','Summary info about data will be shown here...');
set(handles.text4,'String','  - - -  ');


%% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% disp('NEXT')
global Data
close (handles.figure1);
run('PCA1');


%% --- Executes when selected object is changed in uipanel3.
function uipanel3_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel3 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%%


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Data
figure()
boxplot(Data.data,'Orientation','horizontal','Labels',Data.colheaders)
