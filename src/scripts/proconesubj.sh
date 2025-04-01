#!/bin/bash

fmri=rfmri_REST1_RL
t=101309
fmrifile=/keilholz-lab/SharedFiles/HCP_NII/$t/$fmri/$fmri.nii.gz
t1acpc=/keilholz-lab/SharedFiles/HCP_DTI/$t/T1w/T1w_acpc_dc_restore_brain.nii.gz
xfms=/keilholz-lab/SharedFiles/HCP_T1/$t/standard2acpc_dc.nii.gz
sbref=/keilholz-lab/SharedFiles/HCP_NII/100307/atlas/ref.nii.gz
mask=/keilholz-lab/SharedFiles/HCP_NII/$t/atlas/mask_resample.nii.gz
./surface2volume.sh $t1acpc $fmrifile $xfms $sbref $mask $t $fmri &
