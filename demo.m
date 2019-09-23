% select dateset from brca and blca
for i_cancer = 1:2
    input_data_option = {'D01_brca','D02_blca'};
    DirIn = ['./InputData/' input_data_option{select_data} '.mat'];
    load(DirIn);

    % parameter settings
    lambda_Z = 0.001; lambda_W = 0.1;    
    K_dim = 4;

    % load initial W_init for validation with the results in the paper.
    % If the variable "W_init" is not included in function DriverSub, 
    % then it will generates a random matrix for initialization of W.
    load(['./InitW/InitW_' input_data_option{select_data} '.mat'],'W_init');

    % run DriverSub
    [Mutation_Score,SubgroupSpec,Z_mat,W_mat] = ...
        DriverSub(X_mut,K_dim,lambda_Z,lambda_W,'L1',W_init);

    % select top ranked predicted genes
    [~,ind_gene] = sort(Mutation_Score,'descend');
    Predicted_Driver_Genes = GeneSymbol(ind_gene(1:500));
    SubgroupSp_Predicted_Genes = SubgroupSpec(ind_gene(1:500),:);

    % save results
    DirOut = './Output';
    if ~exist(DirOut,'dir')
        mkdir(DirOut);
    end
    save([DirOut '/result_' input_data_option{select_data} '.mat'],...
        'Mutation_Score','SubgroupSpec','Predicted_Driver_Genes',...
        'SubgroupSp_Predicted_Genes','Z_mat','W_mat');
end