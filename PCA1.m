function varargout = PCA1(varargin)
% PCA1 MATLAB code for PCA1.fig
%      PCA1, by itself, creates a new PCA1 or raises the existing
%      singleton*.
%
%      H = PCA1 returns the handle to a new PCA1 or the handle to
%      the existing singleton*.
%
%      PCA1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCA1.M with the given input arguments.
%
%      PCA1('Property','Value',...) creates a new PCA1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCA1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCA1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to the response to help PCA1

% Last Modified by GUIDE v2.5 09-Oct-2019 10:11:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCA1_OpeningFcn, ...
                   'gui_OutputFcn',  @PCA1_OutputFcn, ...
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


%% --- Executes just before PCA1 is made visible.
function PCA1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCA1 (see VARARGIN)

% Choose default command line output for PCA1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCA1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%% --- Outputs from this function are returned to the command line.
function varargout = PCA1_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


%% --- Executes on button press in pushbutton1.
% CALCULATE
function pushbutton1_Callback(hObject, eventdata, handles)
global Data

Col_Names1={'Variance', 'Perc Explained'};
Col_Names2=Data.colheaders;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cov or cor selection
b=get(handles.uipanel2,'SelectedObject');
switch get(b,'Tag'); % Get Tag of selected object.
    case 'radiobutton1'; % Cov
        [Data.coeff,Data.score,Data.latent,Data.tsquared,Data.explained,Data.mu] = pca(Data.data);
        Data.Method='Covariance';
    case 'radiobutton2';%Corr

        % PCA with Corr is the same result with 
        % Matlab's pca function with Normalized Data 
        Data.dataN=zscore(single(Data.data));
        [Data.coeff,Data.score,Data.latent,Data.tsquared,Data.explained,Data.mu] = pca(Data.dataN);
        Data.Method='Correlation';
        %R=corr(Data.data);
        %[Data.coeff,Data.latent,Data.explained] = pcacov(R);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data.IsPcaDone=1;
Data.latentS=100*cumsum(Data.latent)./sum(Data.latent);

set (handles.uitable1,'Data', [Data.latent Data.explained]);
set (handles.uitable1,'ColumnName',Col_Names1 );

set (handles.uitable2,'Data', Data.coeff);
set (handles.uitable2,'RowName', Col_Names2);
%create component1,2,3 as names
for i=1:size(Data.data,2)
    Data.CompNames{i}=['Component_' num2str(i)];
end
set (handles.uitable2,'ColumnName', Data.CompNames);

%Default value for number of component selenction edit box
set (handles.edit1,'String', size(Data.data,2));

% Draw scree plot
axes(handles.axes1);
plot(Data.latent);
hold on;
plot(Data.latent,'ob');
xlabel('Principal Component')
ylabel('Variance Explained (%)')
hold off;

% axes(handles.axes1);
% pareto(Data.explained)
% xlim([0 size(Data.explained,1)+1])
% xlabel('Principal Component')
% ylabel('Variance Explained (%)')



%% --- Executes on button press in pushbutton2.
% CREATE REPORTS
function pushbutton2_Callback(hObject, eventdata, handles)

% No component number selection is made at this step
% so below variables are as originally calculated.
global Data
if Data.IsPcaDone==0
   msgbox('Please Perform PCA First');
else
   Data.SelectedCompsCoeff=Data.coeff;
   Data.NumberCompSelected=size(Data.data,2);
   [Data]=CreateTextReport(Data);
end



%% --- Executes on button press in pushbutton3.
% dimensionality assessment
function pushbutton3_Callback(hObject, eventdata, handles)

global Data
Data.NumberCompSelected=str2num(get(handles.edit1,'String'));
Data.SelectedCompsCoeff=Data.coeff(:,1:Data.NumberCompSelected);

close (handles.figure1);
run ('Results');


%% --- Executes on button press in pushbutton4.
% BACK TO IMPORT DATA
function pushbutton4_Callback(hObject, eventdata, handles)
close (handles.figure1);
run('Import_Data');

%%
function edit1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

%% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%
