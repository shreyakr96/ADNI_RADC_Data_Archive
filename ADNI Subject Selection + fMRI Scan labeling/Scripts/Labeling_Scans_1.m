[num,str,ADNI] = xlsread('ADNIMERGE.xlsx');

ADNI_sz = size(ADNI);

%%Identifying AD, MCI-NC and CN subjects (remain in the same diagnosis as
%%their baseline diagnosis throughout all visits), and then identifying
%%MCI_C Subjects (baseline diag = MCI, changes once to AD and stays in AD
%%throughout

i = 2;

AD = {};
MCI_NC ={};
CN = {};
MCI_C = {};

%%Subjects that did noy make it into any cohorts

AD_X = {}; %change from AD to some other diagnosis
CN_X = {}; %change from CN to some other diagnosis
MCI_CN = {}; %change from MCI to CN and stay in CN
MCI_multi ={}; %chagne from MCI to another diagnosis(AD/CN), and then make atleast 1 more change(to AD/CN or back to MCI)

while(i <= ADNI_sz(1,1))
    
    sub_ID = ADNI(i,2); %Subject ID
    baseline = ADNI(i,60); %BL_Diag ADNI(i,8) does not always match with ADNI(i,60)
    
%     baseline = ADNI(i,8); %Baseline Diagnosis
    
%     if strcmp(baseline,'EMCI') || strcmp(baseline,'LMCI') %renaming baseline Diagnosis in the same convention used in current diagnosis
%         baseline = 'MCI';
%     elseif strcmp(baseline,'AD')
%         baseline = 'Dementia';
%     end
%     
    dx_change = 0; %Checks if diagnosis changes from baseline for the subject in question
    sub_visits = {}; %create an empty cell array for storing details of this subject's visits
    sub_ctr = 1;
    
    diag_prev = baseline; %initiating previous diagnosis
    
    while(strcmp(ADNI(i,2),sub_ID)) %Traverses through different visits of the same subject
        
        %Storing essential information from subject's visit
        
        
        sub_visits{sub_ctr,1} = ADNI{i,1}; %RID
        sub_visits{sub_ctr,2} = ADNI{i,2}; %PTID
        sub_visits{sub_ctr,3} = baseline; %Dx_bl
        sub_visits{sub_ctr,4} = ADNI{i,112}; %month of visit
        sub_visits{sub_ctr,5} = ADNI{i,60}; %Diagnosis
        sub_visits{sub_ctr,6} = ADNI{i,112}./12 + ADNI{i,9}; %Age
        sub_visits{sub_ctr,7} = ADNI{i,10}; %Gender
        sub_visits{sub_ctr,7} = ADNI{i,7}; %Date of Visit
        sub_visits{sub_ctr,8} = ADNI{i,5}; %Current cohort
        
        %%Cognitive Scores Corresponding to Visits
        
        sub_visits{sub_ctr,9} = ADNI{i,23};  %ADAS-11   
        sub_visits{sub_ctr,10} = ADNI{i,24}; %ADAS-13
        sub_visits{sub_ctr,11} = ADNI{i,26}; %MMSE
        sub_visits{sub_ctr,12} = ADNI{i,22}; %CDRSB
        sub_visits{sub_ctr,13} = ADNI{i,27}; %RAVLT_Immediate
        sub_visits{sub_ctr,14} = ADNI{i,28}; %RAVLT_learn
        sub_visits{sub_ctr,15} = ADNI{i,29}; %RAVLT_forget
        sub_visits{sub_ctr,16} = ADNI{i,31}; %LDEL_total
        sub_visits{sub_ctr,17} = ADNI{i,32}; %Digit_SCore
        sub_visits{sub_ctr,18} = ADNI{i,42}; %ECog_Patient_Total
         
        sub_ctr = sub_ctr +1;
        
        nan_check = isnan(ADNI{i,60});
        
        %prev_nan_check = isnan(char(diag_prev(1,1))); %If the prev diagnosis does not match the current one as the previous one was empty, that's not a change
        
        if(~strcmp(diag_prev,ADNI{i,60}) && nan_check(1,1)~=1) %&&~isa(diag_prev,'double') %The diagnosis for a visit does not match the baseline, and additionally is not empty
            
            dx_change = dx_change + 1;
            
        end
        
        if(nan_check(1,1)~=1) % Only update previous diagnosis if current diagnosis is not NaN
            diag_prev = ADNI{i,60}; %storing previous diagnosis
        end
        
        i = i+1;
        
        if i > ADNI_sz(1,1)
            break;
        end
        
        
    end
    
    %At the end of the above loop, diag_prev is the last known diagnosis of
    %the subject
    
    sub_vis_size = size(sub_visits); %no of visits
    last_visit = sub_vis_size(1,1);  %index of the last visit
    
    if dx_change == 0 % Subject stays in same diagnosis throughout all visits
        
        if strcmp(baseline,'Dementia') %stayed in baseline diag as AD till last visit
            AD = cat(1,AD,sub_visits);
        elseif strcmp(baseline,'CN') %stayed in baseline diag as CN till last visit
            CN = cat(1,CN,sub_visits);
        elseif strcmp(baseline,'MCI') %stayed in baseline diag as MCI till last visit
            MCI_NC = cat(1,MCI_NC,sub_visits);
        end
        
    elseif strcmp(baseline,'MCI') && dx_change == 1 && strcmp(diag_prev,'Dementia' ) %strcmp(sub_visits{last_visit,5},'Dementia' %changed once from baseline visit as MCI, to AD and stayed AD till last visit
        MCI_C = cat(1,MCI_C,sub_visits);
        
        
    elseif strcmp(baseline,'MCI') && dx_change == 1 && strcmp(diag_prev,'CN') %strcmp(sub_visits{last_visit,5},'CN' %changed once from baseline visit as MCI, to CN and stayed CN till last visit
        MCI_CN = cat(1,MCI_CN,sub_visits);
        
    elseif  strcmp(baseline,'Dementia') && dx_change>0
        AD_X = cat(1,AD_X,sub_visits);
        
    elseif  strcmp(baseline,'CN') && dx_change>0
        CN_X = cat(1,CN_X,sub_visits);
        
    elseif  strcmp(baseline,'MCI') && dx_change>1
        MCI_multi = cat(1,MCI_multi,sub_visits);
        
    end
    
    
    
end

AD_IDs = unique(AD(:,2));
MCI_NC_IDs = unique(MCI_NC(:,2));
CN_IDs = unique(CN(:,2));
MCI_C_IDs = unique(MCI_C(:,2));
MCI_multi_IDs = unique(MCI_multi(:,2));
MCI_CN_IDs = unique(MCI_CN(:,2));
AD_X_IDs = unique(AD_X(:,2));
CN_X_IDs = unique(CN_X(:,2));


save('AD_Subject_Visits.mat','AD');
save('CN_Subject_Visits.mat','CN');
save('MCI-C_Subject_Visits.mat','MCI_C');
save('MCI-NC_Subject_Visits.mat','MCI_NC');

save('AD_X_Subject_Visits.mat','AD_X');
save('CN_X_Subject_Visits.mat','CN_X');
save('MCI-CN_Subject_Visits.mat','MCI_CN');
save('MCI-multi_Subject_Visits.mat','MCI_multi');


list = {'AD','CN', 'MCI_C', 'MCI_NC', 'AD_X', 'CN_X', 'MCI_multi', 'MCI_CN'};
sz = size(list);


for i = 1:8
    eval(sprintf('sz_j = size(%s_IDs)',list{1,i}));
    sz_j = sz_j(1,1);
    
    for j = 1:sz_j
        eval(sprintf('%s_IDs{j,2} = getVarName(%s)', list{1,i}, list{1,i}));
    end
 eval(sprintf('save(''%s_Subject_IDs.mat'',''%s_IDs'')',list{1,i},list{1,i}));   
     
end

% All subject ID's with corresponding cohorts/reasons for exclusion

All_Sub_Cohort = {};
All_Sub_Visit  = {};

for i = 1:8
    
    eval(sprintf('All_Sub_Cohort = cat(1,All_Sub_Cohort,%s_IDs)', list{1,i}));
    
end

for i = 1:8
    
    eval(sprintf('All_Sub_Visit = cat(1,All_Sub_Visit,%s)', list{1,i}));
    
end

save('All_Sub_Cohort.mat','All_Sub_Cohort');
save('All_Sub_Visit.mat','All_Sub_Visit');





