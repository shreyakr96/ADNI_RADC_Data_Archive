This sub-folder contains the following data:

1. ADNI Datasheets: This sub-folder contains 2 datasheets:

a. ADNIMERGE: This is a meta sheet, which is contains several key ADNI tables merged into one. This has several details of every visit of every subject - Cognitive scores, Demographic information (Age, Years of Education, Gender, Marital Status etc.), a Diagnosis label (MCI/AD/CN) etc. If you require data that isn't available in this sheet, look it up in the study data section as detailed in the Data Archive document.

b.ADNI2_ADNI3: This is a complete list of rest fMRI scans that are available for the ADNI2 and ADNi3 cohort, and also contains details of when each scan was acquired. The scan and diagnostic visit need not always be on the same day, thus the visit dates in ADNI2_ADNI3 and ADNIMERGE might not match. We assume that for a diagnostic and scan visit to be paired, they must be within 0.2 years of each other.

2. Cohort_Subject_IDs: This contains a complete list of subject IDs belonging to the cohorts we have classified the data into.For details of what each cohort label signifies, please consult the dictionary in sheet 2 of the 'ADNI all fMRI scans with Cognitive Scores' Excel Sheet.

3. Cohort_Visit_Wise_Scores: This contains details of all available visits of subjects within each cohort as identified above. These details include diagnosis labels and several behavioral test scores.

4. Scripts: This sub-folder contains 2 scripts which first identify the subjects belonging to each cohort from ADNIMERGE.xls (Labeling_Scans_1.m), and then assign labels to all available fMRI scans in ADNI2_ADNI3.xls (Labeling_Scans_2.m). Detailed comments within the scripts describe the Process.

5. Points to Note - ADNI Subject Selection - This document details the conditons we enlisted, to make sure a subject belongs to one of four cohorts - CN, AD, MCI-C and MCI-NC

6. ADNI All fMRI scans, with Cognitive Scores - This sheet contains the labels assigned to each scan, and the behavioral scores and diagnosis labels from the nearest diagnostic visit (within 0.2 years of the scan visit).