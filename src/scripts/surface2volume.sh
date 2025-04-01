#!/bin/sh



t1acpc=$1
fmri=$2
xfms=$3
sbref=$4
mask=$5
subj=$6
task=$7

pathout=/yourlab/

mkdir $pathout
cd $pathout
flirt -interp spline -in $t1acpc -ref $sbref -applyxfm -out T1w_acpc_dc_restore.2.nii.gz
flirt -interp nearestneighbour -in $mask -ref $sbref -applyxfm -out mask.2.nii.gz
echo startwarp
applywarp --interp=spline -i $fmri -r T1w_acpc_dc_restore.2.nii.gz -w $xfms -m mask.2.nii.gz -o ${task}_native2.nii.gz   



