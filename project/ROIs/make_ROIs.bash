# FLIRT FAQ: http://web.mit.edu/fsl_v5.0.10/fsl/doc/wiki/FLIRT(2f)FAQ.html
# fslmaths: https://mandymejia.com/fsl-maths-commands/

## atlas-based ROI masks
## transform ROI from FSL MNI space to fMRIPrep MNI space
# right amgydala
flirt -in harvardoxford-subcortical_prob_RightAmygdala.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-subcortical_prob_RightAmygdala_transformed
fslmaths harvardoxford-subcortical_prob_RightAmygdala_transformed.nii.gz -thr 50 -bin RightAmygdala_mask
# left amygdala
flirt -in harvardoxford-subcortical_prob_LeftAmygdala.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-subcortical_prob_LeftAmygdala_transformed
fslmaths harvardoxford-subcortical_prob_LeftAmygdala_transformed.nii.gz -thr 50 -bin LeftAmygdala_mask
# bilateral amygdala
fslmaths LeftAmygdala_mask -add RightAmygdala_mask bilateral_Amygdala_mask
# ACC
flirt -in harvardoxford-cortical_prob_anterior_cingulate_gyrus.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-cortical_prob_anterior_cingulate_gyrus_transformed
fslmaths harvardoxford-cortical_prob_anterior_cingulate_gyrus_transformed.nii.gz -thr 50 -bin anterior_cingulate_mask
# dACC (following Shackman et al. 2011: https://www-nature-com.stanford.idm.oclc.org/articles/nrn2994/boxes/bx1; Rotge et al. 2014: https://academic.oup.com/scan/article/10/1/19/2736956)
fslmaths anterior_cingulate_mask -roi 0 97 0 81 0 97 0 1 dACC_mask
# vACC
fslmaths anterior_cingulate_mask -roi 0 97 81 100 0 97 0 1 vACC_mask
# PCC
flirt -in harvardoxford-cortical_prob_posterior_cingulate_gyrus.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-cortical_prob_posterior_cingulate_gyrus_transformed
fslmaths harvardoxford-cortical_prob_posterior_cingulate_gyrus_transformed.nii.gz -thr 50 -bin posterior_cingulate_mask
# mPFC
flirt -in harvardoxford-cortical_prob_medial_frontal_cortex.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-cortical_prob_medial_frontal_cortex_transformed
fslmaths harvardoxford-cortical_prob_medial_frontal_cortex_transformed.nii.gz -thr 50 -bin mPFC_mask
# OFC
flirt -in harvardoxford-cortical_prob_orbital_frontal_cortex.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-cortical_prob_orbital_frontal_cortex_transformed
fslmaths harvardoxford-cortical_prob_orbital_frontal_cortex_transformed.nii.gz -thr 50 -bin OFC_mask
# bilateral hippocampus
flirt -in harvardoxford-subcortical_prob_left_hippocampus.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-subcortical_prob_left_hippocampus_transformed
flirt -in harvardoxford-subcortical_prob_right_hippocampus.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-subcortical_prob_right_hippocampus_transformed
fslmaths harvardoxford-subcortical_prob_left_hippocampus_transformed.nii.gz -thr 50 -bin left_hippocampus_mask
fslmaths harvardoxford-subcortical_prob_right_hippocampus_transformed.nii.gz -thr 50 -bin right_hippocampus_mask
fslmaths left_hippocampus_mask -add right_hippocampus_mask bilateral_hippocampus_mask
# insula
flirt -in harvardoxford-cortical_prob_insular_cortex.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-cortical_prob_insular_cortex_transformed
fslmaths harvardoxford-cortical_prob_insular_cortex_transformed.nii.gz -thr 50 -bin insula_mask
# frontal pole
flirt -in harvardoxford-cortical_prob_frontal_pole.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-cortical_prob_frontal_pole_transformed
fslmaths harvardoxford-cortical_prob_frontal_pole_transformed.nii.gz -thr 50 -bin frontal_pole_mask
# inferior frontal gyrus, pars triangularis  
flirt -in harvardoxford-cortical_prob_inferior_frontal_gyrus.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-cortical_prob_inferior_frontal_gyrus_transformed
fslmaths harvardoxford-cortical_prob_inferior_frontal_gyrus_transformed.nii.gz -thr 50 -bin inferior_frontal_gyrus_mask

# Atlas by Sallet et al. 2013 JNeuro: http://www.rbmars.dds.nl/pubs/Sallet2013JN.pdf
# supplemental motor area (SMA)
flirt -in harvardoxford-cortical_prob_Supplementary_Motor_Cortex.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out harvardoxford-cortical_prob_Supplementary_Motor_Cortex_transformed
fslmaths harvardoxford-cortical_prob_Supplementary_Motor_Cortex_transformed.nii.gz -thr 50 -bin SMA_mask
# pre-SMA
fslmaths DorsalFrontal_thr50_summaryimage_1mm.nii.gz -thr 2 -uthr 2 -bin pre_SMA_mask
flirt -in pre_SMA_mask.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out pre_SMA_mask
# vmPFC
fslmaths DorsalFrontal_thr50_summaryimage_1mm.nii.gz -thr 4 -uthr 4 -bin vmPFC_mask
flirt -in vmPFC_mask.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out vmPFC_mask
# dlPFC
fslmaths DorsalFrontal_thr50_summaryimage_1mm.nii.gz -thr 5 -uthr 5 -bin dlPFC_mask
flirt -in dlPFC_mask.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out dlPFC_mask
# vlPFC
fslmaths DorsalFrontal_thr50_summaryimage_1mm.nii.gz -thr 7 -uthr 7 -bin vlPFC_mask
flirt -in vlPFC_mask.nii.gz -ref bg_image.nii.gz -applyxfm -usesqform -out vlPFC_mask


## box or sphere ROI
fslmaths bg_image.nii.gz -mul 0 -add 1 -roi 39 15 81 25 27 18 0 1 mPFC_box -odt float

# patient vs. controls: contrast 3 (BC_IAPS_reactivity)
fslmaths /oak/stanford/groups/gross/work/Spiegel_U01/feat_outputs_smoothed_delay_corrected_3more_confounds/group_analysis/patient_vs_control/contrast3_BC_IAPS.gfeat/cope1.feat/cluster_mask_zstat1.nii.gz -thr 4 cluster4_patient-control_contrast3
fslmaths /oak/stanford/groups/gross/work/Spiegel_U01/feat_outputs_smoothed_delay_corrected_3more_confounds/group_analysis/patient_vs_control/contrast3_BC_IAPS.gfeat/cope1.feat/cluster_mask_zstat1.nii.gz -thr 3 -uthr 3 cluster3_patient-control_contrast3
fslmaths /oak/stanford/groups/gross/work/Spiegel_U01/feat_outputs_smoothed_delay_corrected_3more_confounds/group_analysis/patient_vs_control/contrast3_BC_IAPS.gfeat/cope1.feat/cluster_mask_zstat1.nii.gz -thr 1 -uthr 2 cluster1_2_patient-control_contrast3

# non-BLM vs. BLM: contrast 6 (BC_IAPS_regulation)
fslmaths /oak/stanford/groups/gross/work/Spiegel_U01/feat_outputs/group_analysis/BLM_vs_non_BLM/contrast6_BC_IAPS_reap.gfeat/cope1.feat/cluster_mask_zstat2.nii.gz -thr 1 -uthr 1 cluster1_nonBLM-BLM_contrast6
fslmaths /oak/stanford/groups/gross/work/Spiegel_U01/feat_outputs/group_analysis/BLM_vs_non_BLM/contrast6_BC_IAPS_reap.gfeat/cope1.feat/cluster_mask_zstat2.nii.gz -thr 2 -uthr 2 cluster2_nonBLM-BLM_contrast6