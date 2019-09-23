bin_path = './bin';
addpath(bin_path);

DirRawData = './cBioPortal_RawData';
CancerType = {'brca','blca'};
for i_cancer = 1:length(CancerType)
    file_dir = [DirRawData '/' CancerType{i_cancer} '_tcga_pub'];

    % load raw mutation data from "data_mutations_extended.txt"
    input_txt_file_Mut = [file_dir '/data_mutations_extended.txt'];
    [GeneSymbol_Mut,Sample_ID_Mut] = P01_LoadRawMut(input_txt_file_Mut);


    % load tested gene list
    load('./cBioPortal_RawData/TestedGeneList.mat','GeneSymbol')
    [SampleID_complete,X_mut] = P02_GenerateMutData(Sample_ID_Mut,...
        GeneSymbol_Mut,GeneSymbol);

    save(['./InputData/D' num2str(i_cancer,'%2.2d') '_' CancerType{i_cancer}],...
        'X_mut','SampleID_complete','GeneSymbol');
end

rmpath(bin_path);