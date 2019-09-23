
% load DriveSub results for breast cancer data
load('./Output/result_D01_brca.mat', 'W_mat');
K_dim = size(W_mat,2);

% load sample IDs of input data
load('./InputData/D01_brca.mat', 'SampleID_complete');

% load ground truth subgroup annotations
load('./SubgroupAnnotations/GT01_brca.mat','SubgroupAnnotations');

% sample ID alignment
NoLabel_ID = setdiff(SampleID_complete,SubgroupAnnotations(:,1));
[~,ind_AnnotatedID,ind_sampleID] = ...
    intersect([SubgroupAnnotations(:,1); NoLabel_ID],SampleID_complete);
Anno_Truth = SubgroupAnnotations(ind_AnnotatedID(ind_sampleID),2); % Uni_PAM50

% get ground truth annotation list
[Uni_Anno,~,List_Truth] = unique(Anno_Truth);


% train a map from parameter matrix W to subgroups 
ind_invalid = strcmp(SubgroupAnnotations(:,2),'');
prior_vec = hist(List_Truth,K_dim); prior_vec = prior_vec/sum(prior_vec);
map_subgroups = fitcnb(W_mat(~ind_invalid,:),List_Truth(~ind_invalid,:),...
    'Prior',prior_vec,'DistributionNames','kernel','Kernel','box');

type_infer = 1;
% get inferred subgroup list
switch type_infer
    case 1 % by map from parameter matrix W to subgroups 
        List_Pred = predict(map_subgroups,W_mat);
    case 2 % by simply retrieving maximum elements of parameter matrix W
        [~,List_Pred] = min(W_mat,[],2);
end

% Chi-squared test for association study
[Composition,chi2,p_value] = crosstab(List_Truth,List_Pred);
disp(['p-value = ' num2str(p_value,'%2.2e')]);

% Plot assessment results of subgroup prediction performance
bar(Composition','stacked');
XTickLabel_vec = {'Sub 1','Sub 2','Sub 3','Sub 4'}; % for K_dim = 4
set(gca,'XTick',1:4,'XTickLabel',XTickLabel_vec); xlim([-1 4.8]);
xlabel('Inferred subgroups'); ylabel('Number of samples');
colormap(parula); grid on; view(90,90);
if isempty(Uni_Anno{1})
    Uni_Anno{1} = 'Unknown';
end
legend(Uni_Anno,'Location','North','Orientation','Horizontal');
title(['Subgroups inferred from parameter matrix of samples W '...
    '(chi-squared test p-value = ' num2str(p_value,'%2.2e') ')']);

set(gcf,'PaperPositionMode','manual');
set(gcf,'PaperUnits','points');
set(gcf,'PaperPosition',[0 50 600 170])
print('-dpng','-r600', './Fig_SubgroupAssessment.png');