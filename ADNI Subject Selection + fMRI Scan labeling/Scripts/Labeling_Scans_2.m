
load ('All_Sub_Visit.mat','All_Sub_Visit');
load ('All_Sub_Cohort.mat','All_Sub_Cohort');

[num,txt,fmri] =xlsread('ADNI2_ADNI3.xlsx');

sz_fmri = size(fmri);
sz_cohort = size(All_Sub_Cohort);
sz_visit = size(All_Sub_Visit);


%% Assisgning Cognitive Scores to Scans

for j =2: sz_fmri(1,1)
for i = 1 : sz_visit(1,1)
         if strcmp(All_Sub_Visit{i,2},fmri{j,1})% Sub_Ids match
            if abs(All_Sub_Visit{i,6}-fmri{j,7}) < 0.2 %if the scan occurs 0.2 years before or after the diagnosis visit, it is attributed to that visit
               
               fmri{j,11} = All_Sub_Visit{i,9};
               fmri{j,12} = All_Sub_Visit{i,10};
               fmri{j,13} = All_Sub_Visit{i,11};
               fmri{j,14} = All_Sub_Visit{i,12};
               fmri{j,15} = All_Sub_Visit{i,13};
               fmri{j,16} = All_Sub_Visit{i,14};
               fmri{j,17} = All_Sub_Visit{i,15};
               fmri{j,18} = All_Sub_Visit{i,16};
               fmri{j,19} = All_Sub_Visit{i,17};
               fmri{j,20} = All_Sub_Visit{i,18};
                           
            end
        end
    end
end


%% Assigning Cohorts/ Reasons for exclusion to Scans

for j =2: sz_fmri(1,1)
for i = 1 : sz_cohort(1,1)
         if strcmp(All_Sub_Cohort{i,1},fmri{j,1})% Sub_Ids match
             fmri{j,10} = All_Sub_Cohort{i,2};
         end
end
end
             
