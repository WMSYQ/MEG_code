function IEM_Unity_Calculate(Information_file_name,save_prefix,subj_number,binned_data_folder_prefix,IEM_folder_prefix)

% Author Yongqian Song
% 2021.3.15
% 
% Calculate IEM matrix from binned data
% Save IEM result
% then train our model with half_pre_training and half_post_training
% test with half_pre_testing and half_post_testing separately

load(Information_file_name);
% n_trials = 30;
IEM_folder = fullfile(IEM_folder_prefix,save_prefix);
for subj = subj_number
    label_direction_subj = label_direction(subj,:);
    tic
    %% Load
    for load_folding = 1:1
        %% Load Post1 as training data and testing data
        pre_data=[];
        pre_label=[];
        label=[];          
        
        filename_pre = fullfile(binned_data_folder_prefix,subject_list(subj).name,'binary_1ms_bins_1ms_sampled.mat');
        load(filename_pre); 
        label_list = binned_labels.stim_ID{1};
        
%         Create IEM label from binned_labels.stim_ID{1}(from ABCD to directions in degree)
        for trial = 1:length(label_list)
            if label_list(trial) == 'A'
                label(trial) = label_direction_subj(1);
            elseif label_list(trial) == 'B'
                label(trial) = label_direction_subj(2);
            elseif label_list(trial) == 'C'
                label(trial) = label_direction_subj(3);
            elseif label_list(trial) == 'D'
                label(trial) = label_direction_subj(4);
            end
        end
        pre_label=label';

        for channel = 1:72
            pre_data(:,channel,:) = binned_data{channel};
        end
        
        clear binned_data binned_labels binned_site_info
        
        %% Load Post1 and Post2
        %% Post1
        for post1_folding = 1:1
            
            post1_data=[];
            post1_label=[];
            label=[];
            
            post1_filename = fullfile(binned_data_folder_prefix,subject_list(subj-2).name,'binary_1ms_bins_1ms_sampled.mat');
            load(post1_filename);

            for channel = 1:72
                post1_data(:,channel,:) = binned_data{channel};
            end

            label_list = binned_labels.stim_ID{1};
            for trial = 1:length(label_list)
                if label_list(trial) == 'A'
                    label(trial) = label_direction_subj(1);
                elseif label_list(trial) == 'B'
                    label(trial) = label_direction_subj(2);
                elseif label_list(trial) == 'C'
                    label(trial) = label_direction_subj(3);
                elseif label_list(trial) == 'D'
                    label(trial) = label_direction_subj(4);
                end
            end
            post1_label=label';
            clear binned_data binned_labels binned_site_info
        end
        %% Post2
        for post2_folding = 1:1
            
            post2_data=[];
            post2_label=[];
            label=[];
            
            post2_filename = fullfile(binned_data_folder_prefix,subject_list(subj-1).name,'binary_1ms_bins_1ms_sampled.mat');
            load(post2_filename);

            for channel = 1:72
                post2_data(:,channel,:) = binned_data{channel};
            end

            label_list = binned_labels.stim_ID{1};
            for trial = 1:length(label_list)
                if label_list(trial) == 'A'
                    label(trial) = label_direction_subj(1);
                elseif label_list(trial) == 'B'
                    label(trial) = label_direction_subj(2);
                elseif label_list(trial) == 'C'
                    label(trial) = label_direction_subj(3);
                elseif label_list(trial) == 'D'
                    label(trial) = label_direction_subj(4);
                end
            end
            post2_label=label';
            clear binned_data binned_labels binned_site_info
        end
    end
%     
    %% Equalize input data
    [pre_equalized_index post1_equalized_index] = my_equalize(pre_label,post1_label);
    pre_data = pre_data(~isnan(pre_equalized_index),:,:);
    pre_label = pre_label(~isnan(pre_equalized_index));
    post1_data = post1_data(~isnan(post1_equalized_index),:,:);
    post1_label = post1_label(~isnan(post1_equalized_index));
    
    [pre_equalized_index post2_equalized_index] = my_equalize(pre_label,post2_label);
    pre_data = pre_data(~isnan(pre_equalized_index),:,:);
    pre_label = pre_label(~isnan(pre_equalized_index));
    post2_data = post2_data(~isnan(post2_equalized_index),:,:);
    post2_label = post2_label(~isnan(post2_equalized_index));
    
    [post1_equalized_index post2_equalized_index] = my_equalize(post1_label,post2_label);
    post1_data = post1_data(~isnan(post1_equalized_index),:,:);
    post1_label = post1_label(~isnan(post1_equalized_index));
    post2_data = post2_data(~isnan(post2_equalized_index),:,:);
    post2_label = post2_label(~isnan(post2_equalized_index));

    for pool = 1:1
        trn = vertcat(pre_data,post1_data,post2_data);
        trng = vertcat(pre_label,post1_label,post2_label);
        belonging = vertcat(pre_label,post1_label+1,post2_label+2);

        [chan_resp_cv_coeffs_all chan_resp_cv_coeffs_shift_all belonging_cv] = IEM_matrix_pooled(trn,trng,belonging);

        %% Save Pre
        thisidx = mod(belonging_cv,10) == 0;
        chan_resp_cv_coeffs = chan_resp_cv_coeffs_all(thisidx,:,:);
        chan_resp_cv_coeffs_shift = chan_resp_cv_coeffs_shift_all(thisidx,:,:);
        trng = belonging_cv(thisidx,:,:);

        target_folder = fullfile(IEM_folder,'\IEM_result\',subject_list(subj).name,'\');
        if exist(target_folder,'dir')~=7
            eval(['mkdir ' target_folder])
        end
        save_file_name = fullfile(target_folder, 'Unity');
        save(save_file_name, 'chan_resp_cv_coeffs','chan_resp_cv_coeffs_shift','trng');

        %% Save Post1
        thisidx = mod(belonging_cv,10) == 1;
        chan_resp_cv_coeffs = chan_resp_cv_coeffs_all(thisidx,:,:);
        chan_resp_cv_coeffs_shift = chan_resp_cv_coeffs_shift_all(thisidx,:,:);
        trng = belonging_cv(thisidx,:,:)-1;

        target_folder = fullfile(IEM_folder,'\IEM_result\',subject_list(subj-2).name);
        if exist(target_folder,'dir')~=7
            eval(['mkdir ' target_folder])
        end
        save_file_name = fullfile(target_folder, 'Unity');
        save(save_file_name, 'chan_resp_cv_coeffs','chan_resp_cv_coeffs_shift','trng');
        
        %% Save Post2
        thisidx = mod(belonging_cv,10) == 2;
        chan_resp_cv_coeffs = chan_resp_cv_coeffs_all(thisidx,:,:);
        chan_resp_cv_coeffs_shift = chan_resp_cv_coeffs_shift_all(thisidx,:,:);
        trng = belonging_cv(thisidx,:,:)-2;
  
        target_folder = fullfile(IEM_folder,'\IEM_result\',subject_list(subj-1).name);
        if exist(target_folder,'dir')~=7
            eval(['mkdir ' target_folder])
        end
        save_file_name = fullfile(target_folder, 'Unity');
        save(save_file_name, 'chan_resp_cv_coeffs','chan_resp_cv_coeffs_shift','trng');
        
        trn = [];
        trng = [];
        belonging = [];
    end
        
    toc
    clearvars -except binned_data_folder_prefix IEM_folder subject_list label_direction subj subj_number
end