function IEM_Unity_Test_Channel_Response(save_prefix,IEM_folder_prefix,search_prefix,sampling_rate,begin_time)

% Plot channel responses in specific time window
%% Load channel response
for load_post1_response = 1:1
    IEM_folder = fullfile(IEM_folder_prefix,save_prefix,'\IEM_result\');
    
    %% Load IEM result
    for load_and_save = 1:1
        for dir_folding = 1:1
            current_path = cd;
            cd(IEM_folder);
            listing_Pre=dir([search_prefix '*Pre*']);
            listing_Post1=dir([search_prefix '*Post1*']);
            listing_Post2=dir([search_prefix '*Post2*']);
            cd(current_path);
        end
    end
    
    Baseline_window = [1:(abs(begin_time - 0) / sampling_rate)];
    
    for subj = 1:length(listing_Pre)
        load(fullfile(listing_Pre(subj).folder,listing_Pre(subj).name,'Unity.mat'));
        len = size(chan_resp_cv_coeffs_shift,1)/4;
        Pre_chan_resp_cv_coeffs_shift_0(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(1:len,:,:),1));
        Pre_chan_resp_cv_coeffs_shift_30(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(len+1:len*2,:,:),1));
        Pre_chan_resp_cv_coeffs_shift_60(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(2*len+1:len*3,:,:),1));
        Pre_chan_resp_cv_coeffs_shift_90(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(3*len+1:len*4,:,:),1));  
    end
    
    for subj = 1:length(listing_Post1)
        load(fullfile(listing_Post1(subj).folder,listing_Post1(subj).name,'Unity.mat'));
        len = size(chan_resp_cv_coeffs_shift,1)/4;
        Post1_chan_resp_cv_coeffs_shift_0(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(1:len,:,:),1));
        Post1_chan_resp_cv_coeffs_shift_30(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(len+1:len*2,:,:),1));
        Post1_chan_resp_cv_coeffs_shift_60(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(2*len+1:len*3,:,:),1));
        Post1_chan_resp_cv_coeffs_shift_90(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(3*len+1:len*4,:,:),1));
    end
    
    for subj = 1:length(listing_Post2)
        load(fullfile(listing_Post2(subj).folder,listing_Post2(subj).name,'Unity.mat'));
        len = size(chan_resp_cv_coeffs_shift,1)/4;
        Post2_chan_resp_cv_coeffs_shift_0(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(1:len,:,:),1));
        Post2_chan_resp_cv_coeffs_shift_30(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(len+1:len*2,:,:),1));
        Post2_chan_resp_cv_coeffs_shift_60(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(2*len+1:len*3,:,:),1));
        Post2_chan_resp_cv_coeffs_shift_90(subj,:,:) = squeeze(mean(chan_resp_cv_coeffs_shift(3*len+1:len*4,:,:),1));
    end
end

%% Fixed time window
Time_window = [1:abs(begin_time)/sampling_rate];

Pre_0 = mean(Pre_chan_resp_cv_coeffs_shift_0(:,:,Time_window),3);
Pre_30 = mean(Pre_chan_resp_cv_coeffs_shift_30(:,:,Time_window),3);
Pre_60 = mean(Pre_chan_resp_cv_coeffs_shift_60(:,:,Time_window),3);
Pre_90 = mean(Pre_chan_resp_cv_coeffs_shift_90(:,:,Time_window),3);

Post1_0 = mean(Post1_chan_resp_cv_coeffs_shift_0(:,:,Time_window),3);
Post1_30 = mean(Post1_chan_resp_cv_coeffs_shift_30(:,:,Time_window),3);
Post1_60 = mean(Post1_chan_resp_cv_coeffs_shift_60(:,:,Time_window),3);
Post1_90 = mean(Post1_chan_resp_cv_coeffs_shift_90(:,:,Time_window),3);

Post2_0 = mean(Post2_chan_resp_cv_coeffs_shift_0(:,:,Time_window),3);
Post2_30 = mean(Post2_chan_resp_cv_coeffs_shift_30(:,:,Time_window),3);
Post2_60 = mean(Post2_chan_resp_cv_coeffs_shift_60(:,:,Time_window),3);
Post2_90 = mean(Post2_chan_resp_cv_coeffs_shift_90(:,:,Time_window),3);

%% Sliding time window
for sliding_window_end = [15:5:50]
    window_length = 5;
    Time_window = [sliding_window_end-window_length+1:sliding_window_end];
    Pre_0 = mean(Pre_chan_resp_cv_coeffs_shift_0(:,:,Time_window),3);
    Post1_0 = mean(Post1_chan_resp_cv_coeffs_shift_0(:,:,Time_window),3);
    Post2_0 = mean(Post2_chan_resp_cv_coeffs_shift_0(:,:,Time_window),3);
    Pre_90 = mean(Pre_chan_resp_cv_coeffs_shift_90(:,:,Time_window),3);
    Post1_90 = mean(Post1_chan_resp_cv_coeffs_shift_90(:,:,Time_window),3);
    Post2_90 = mean(Post2_chan_resp_cv_coeffs_shift_90(:,:,Time_window),3);
end
