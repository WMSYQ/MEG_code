function varargout = Decoding_by_NDT(varargin)
% DECODING_BY_NDT MATLAB code for Decoding_by_NDT.fig
%      DECODING_BY_NDT, by itself, creates a new DECODING_BY_NDT or raises the existing
%      singleton*.
%
%      H = DECODING_BY_NDT returns the handle to a new DECODING_BY_NDT or the handle to
%      the existing singleton*.
%
%      DECODING_BY_NDT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECODING_BY_NDT.M with the given input arguments.
%
%      DECODING_BY_NDT('Property','Value',...) creates a new DECODING_BY_NDT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decoding_by_NDT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decoding_by_NDT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decoding_by_NDT

% Last Modified by GUIDE v2.5 13-Jan-2021 11:18:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decoding_by_NDT_OpeningFcn, ...
                   'gui_OutputFcn',  @Decoding_by_NDT_OutputFcn, ...
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


% --- Executes just before Decoding_by_NDT is made visible.
function Decoding_by_NDT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decoding_by_NDT (see VARARGIN)

% Choose default command line output for Decoding_by_NDT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decoding_by_NDT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Decoding_by_NDT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in binned_data.
function binned_data_Callback(hObject, eventdata, handles)
[folder_prefix] = uigetdir([],'Choose your folder of saved data');
disp(['You selected ',folder_prefix, ' as your data folder']);
handles.folder_prefix = folder_prefix;
guidata(hObject,handles);



function bin_width_input_Callback(hObject, eventdata, handles)
bin_width =str2double(get(hObject,'String'));
disp(['bin width: ',num2str(bin_width)]);
handles.bin_width = bin_width;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function bin_width_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bin_width_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function step_size_input_Callback(hObject, eventdata, handles)
step_size =str2double(get(hObject,'String'));
disp(['step size: ',num2str(step_size)]);
handles.step_size = step_size;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function step_size_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_size_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function conditions_input_Callback(hObject, eventdata, handles)
my_conditions = strsplit(get(hObject,'String'),',')
handles.my_conditions = my_conditions;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function conditions_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conditions_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cv_input_Callback(hObject, eventdata, handles)
cv =str2double(get(hObject,'String'));
disp(['cv: ',num2str(cv)]);
handles.cv = cv;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function cv_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cv_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nAvg_input_Callback(hObject, eventdata, handles)
nAvg =str2double(get(hObject,'String'));
disp(['Number of trials to average: ',num2str(nAvg)]);
handles.nAvg = nAvg;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function nAvg_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nAvg_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Permutation_test.
function Permutation_test_Callback(hObject, eventdata, handles)
if ( get(hObject,'Value') )
    permutation_flag = 1;
    disp(['Calculate null distributions']);
else
    permutation_flag = 0;
end
handles.permutation_flag = permutation_flag;
guidata(hObject,handles);


% --- Executes on button press in target_folder.
function target_folder_Callback(hObject, eventdata, handles)
[target_folder_prefix] = uigetdir([],'Choose your folder to save decoding results');
disp(['You selected ',target_folder_prefix, ' to save decoding results']);
handles.target_folder_prefix = target_folder_prefix;
guidata(hObject,handles);


% --- Executes on button press in GO.
function GO_Callback(hObject, eventdata, handles)

alphabet=['ABCDEFGHIJKLMNOPQRSTUVWXYZ'];
label_names_to_use =[];
for i = 1:length(handles.my_conditions)
    for j = 1:length(handles.conditions_list)
        if handles.my_conditions{i} == handles.conditions_list{j}
            label_names_to_use = [label_names_to_use, alphabet(j)];
        end
    end
end

%create Decoding_by_NDT result
for subj = 1:length(handles.subject_list)
    subject_name = handles.subject_list(subj).name;
    binned_folder = fullfile(handles.folder_prefix,'binned_data',subject_name);
    target_folder = fullfile(handles.target_folder_prefix,'Decoding_Results',subject_name);
    if exist(target_folder,'dir')~=7
        eval(['mkdir ' target_folder])
    end
    binned_data_file_name = fullfile (binned_folder,['binary_' num2str(handles.bin_width) 'ms_bins_' num2str(handles.step_size) 'ms_sampled.mat']);
    save_file_name = fullfile (target_folder, ['MTT_results_' num2str(handles.bin_width) 'msbins_' num2str(handles.step_size) 'mssteps']);
    my_run_decoding_NDT(binned_data_file_name,save_file_name,label_names_to_use,handles.cv,handles.nAvg);
end

% calculate null distributions for permutation test
if handles.permutation_flag ==1
    for subj = 1:length(handles.subject_list)
        subject_name = handles.subject_list(subj).name;
        binned_folder = fullfile(handles.folder_prefix,'binned_data',subject_name);
        distribution_folder = fullfile(handles.target_folder_prefix,'Null_Distributions',subject_name);
        if exist(distribution_folder,'dir')~=7
            eval(['mkdir ' distribution_folder])
        end
        
        binned_data_file_name = fullfile (binned_folder,['binary_' num2str(handles.bin_width) 'ms_bins_' num2str(handles.step_size) 'ms_sampled.mat']);

        for test_time = 1:20
            save_file_name = fullfile (distribution_folder,[subject_name '_' num2str(test_time)]);
            my_run_decoding_NDT_null_distribution(binned_data_file_name,save_file_name,label_names_to_use,handles.cv,handles.nAvg);
        end
    end
end

% --- Executes on button press in subject_list.
function subject_list_Callback(hObject, eventdata, handles)
[subject_list_filename,subject_list_filepath] = uigetfile('*.mat','Choose your subject list (.mat)');
if isequal(subject_list_filename,0)
   disp('Please select your subject list again');
else
   disp(['You selected subject list: ', fullfile(subject_list_filepath,subject_list_filename)]);
end
load(fullfile(subject_list_filepath,subject_list_filename));
handles.subject_list = subject_list;
guidata(hObject,handles);

function all_conditions_input_Callback(hObject, eventdata, handles)
conditions_list = strsplit(get(hObject,'String'),',')
handles.conditions_list = conditions_list;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function all_conditions_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to all_conditions_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function my_run_decoding_NDT(binned_data_file_name,save_file_name,label_names_to_use,cv,navg) 
% Decoding_by_NDT binned data by NDT
% author: Yongqian Song
% 2020.10.27

%% create classifier
the_classifier = libsvm_CL;
the_feature_preprocessors{1} = zscore_normalize_FP;
the_feature_preprocessors{2} = select_or_exclude_top_k_features_FP;
the_feature_preprocessors{2}.num_features_to_use = 25;
% the_feature_preprocessors{2}.save_extra_info = 1;

%% create the CV object
num_cv_splits = cv;
specific_labels_names_to_use = 'stim_ID';
nAvg = navg;
ds = avg_DS(binned_data_file_name, specific_labels_names_to_use, num_cv_splits, nAvg);
ds.num_times_to_repeat_each_label_per_cv_split = navg;
ds.create_simultaneously_recorded_populations = 1;
ds.label_names_to_use = label_names_to_use;

the_cross_validator = standard_resample_CV(ds, the_classifier, the_feature_preprocessors);
the_cross_validator.num_resample_runs = 50;
the_cross_validator.test_only_at_training_times = 1;

%% run the Decoding_by_NDT analysis
DECODING_RESULTS = the_cross_validator.run_cv_decoding;
save(save_file_name, 'DECODING_RESULTS')

function my_run_decoding_NDT_null_distribution(binned_data_file_name,save_file_name,label_names_to_use,cv,navg) 
% Decoding_by_NDT binned data by NDT
% author: Yongqian Song
% 2020.10.27

%% create classifier
the_classifier = libsvm_CL;
the_feature_preprocessors{1} = zscore_normalize_FP;
the_feature_preprocessors{2} = select_or_exclude_top_k_features_FP;
the_feature_preprocessors{2}.num_features_to_use = 25;

%% create the CV object
num_cv_splits = cv;
specific_labels_names_to_use = 'stim_ID';
nAvg = navg;
ds = avg_DS(binned_data_file_name, specific_labels_names_to_use, num_cv_splits, nAvg);
ds.num_times_to_repeat_each_label_per_cv_split = navg;
ds.create_simultaneously_recorded_populations = 1;
ds.label_names_to_use = label_names_to_use;

ds.randomly_shuffle_labels_before_running = 1;  

the_cross_validator = standard_resample_CV(ds, the_classifier, the_feature_preprocessors);
the_cross_validator.num_resample_runs = 50;
the_cross_validator.test_only_at_training_times = 1;

%% run the Decoding_by_NDT analysis
DECODING_RESULTS = the_cross_validator.run_cv_decoding;
save(save_file_name, 'DECODING_RESULTS')
