% select dateset from brca and blca
select_data = 1;
input_data_option = {'D01_brca','D02_blca'};
DirIn = ['./InputData/' input_data_option{select_data} '.mat'];
load(DirIn);

% parameter settings
lambda_Z = 0.001; lambda_W = 0.1;    
K_dim = 4;

% run DriverSub
[Mutation_Score,SubgroupSpec] = ...
    DriverSub(X_mut,K_dim,lambda_Z,lambda_W);

% select top ranked predicted genes
[~,ind_gene] = sort(Mutation_Score,'descend');
PredictedGenes = GeneSymbol_net(ind_gene(1:500));
SubgroupSp_indices = SubgroupSpec(ind_gene(1:500),:);

% save results
DirOut = './Output';
mkdir(DirOut);
save([DirOut '/result_' input_data_option{select_data} '.mat'],...
    'Mutation_Score','SubgroupSpec','PredictedGenes','SubgroupSp_indices');
