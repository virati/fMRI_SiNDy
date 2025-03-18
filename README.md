README

The script proconesubj.sh processes one subject from surface HCP space into the 3D T1 space. It calls the surface2volume.sh script which does the actual transformation. 
The files required for this is given in the proconesubj.sh file.

Once processed, they are averaged according to the T1 parcellation in the preprocess_main.m matlab script for the 84 ROIs (Cortical and Subcortical) for the FSL DK atlas. 
We applied this on roughly a 1000 subjects for each Task category in HCP and then performed our analysis which is in SINDy_fmri python notebook.
