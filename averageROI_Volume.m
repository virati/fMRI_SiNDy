function [ dparc ] = averageROI_Volume( data, bb, my_parc_in , n_parc)
%This function takes in data and a parcellation file both in cifti format
%and computes the the ROI timeseries for each parcellation
%as well as creates a projected version back in the larger spatial
%dimension of the averaged data

[n_vox, n_time]= size(data);


dparc = zeros(n_parc ,n_time);

for i = 1:n_parc



    %[x y z] = ind2sub(bb, my_parc_in{i});
    %n_len = length(my_parc_in{i});
    %temp = zeros(n_len, n_time);
    %for j=1:n_len
    %   temp(j,:) = squeeze(double(data(x(j),y(j),z(j),:)))';
    %end
    filter_d = myfilt(double(squeeze(data(my_parc_in{i},:))));
    z_data = zscore(filter_d')';
    dparc(i,:) = mean(z_data, 1);


end

end
