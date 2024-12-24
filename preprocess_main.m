

f_path_data = '/yourlab/HCP_NII/';
f_path_atlas = '/yourlab/HCP_NII/';
f_mid = '/atlas/aparc+aseg_resample.nii.gz';
%f_atlas_end = '.nii';



p_id = load('subj.txt'); %txt file of all subjects i.e 100307
n_patients = length(p_id);
%n_patients = 447;

%p_id = p_id(9:447);


scans = ["rfMRI_REST1_RL", "rfMRI_REST1_LR", "rfMRI_REST2_RL", "rfMRI_REST2_LR", "tfMRI_EMOTION_RL", "tfMRI_EMOTION_LR", "tfMRI_GAMBLING_RL", "tfMRI_GAMBLING_LR", "tfMRI_MOTOR_RL", "tfMRI_MOTOR_LR", "tfMRI_RELATIONAL_RL", "tfMRI_RELATIONAL_LR", "tfMRI_SOCIAL_RL", "tfMRI_SOCIAL_LR", "tfMRI_WM_RL", "tfMRI_WM_LR", "tfMRI_LANGUAGE_RL", "tfMRI_LANGUAGE_LR" ];




n_scans = 18;

n_voxP = 64984;
n_parc = 84;
n_time = 8680;

nparc_list = [1001:1035, 2001:2035, 8,10,11,12,13,17,18,26,47,49,50,51,52,53,54,58];
nparc_list(39) = [];
nparc_list(4) = [];



f_newPath = '/out/HCP_Native/';
mkdir(f_newPath);

for i =1:n_patients

    %i = A(ii);
    pat = num2str(p_id(i))


    f_atlas_full = strcat(strcat(f_path_atlas,num2str(p_id(i))),f_mid);
    atlas = niftiread(f_atlas_full);

    atlas_cell = cell(n_parc,1);
    for ll = 1:n_parc
      atlas_cell{ll} = find(atlas == nparc_list(ll));
    end

    full_W= []
    for j = 1:n_scans
         %j = B(ii);
         %scans(j)
         f_id = strcat('/',strcat(strcat(strcat(char(scans(j)), '/processed/'), char(scans(j))), '_native.nii.gz')); %%%change to match ur filepaths
         f_full_path = strcat(strcat(f_path_data, num2str(p_id(i)), f_id))

         try
                raw_data = niftiread(f_full_path);
                [xx, yy, zz, tt]= size(raw_data);
                raw_data = reshape(raw_data, [xx*yy*zz, tt]);
                
                parc_series = averageROI_Surface(raw_data, size(atlas), atlas_cell, n_parc); %avg roi
                f_data = myfilt(parc_series); %filter
                proc_data = zscore(f_data')'; %last normalize

                f_id2 = strcat('/',strcat(strcat(strcat(char(scans(j)), '/processed/'), char(scans(j))), '_parcellated_subcortcerbfixed.txt'));
                f_out = strcat(strcat(f_path_data, num2str(p_id(i)), f_id2));
                dlmwrite(f_out, proc_data, 'delimiter',' ');
                full_W = [full_W, proc_data];
                raw_data = [];
         catch e
            % rethrow(e);
             raw_data=[];
        end

    end

%    full_data(i,:,:) = full_W;
end



full_data = reshape(full_data, [n_patients, n_parc*n_time]);
dlmwrite(strcat(f_newPath, 'fmriwm2024.txt'), full_data, 'delimiter',' ');
