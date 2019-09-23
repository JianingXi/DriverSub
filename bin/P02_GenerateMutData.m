
function [SampleID_complete,X_Mut] = P02_GenerateMutData(Sample_ID_Mut,...
    GeneSymbol_Mut,TestedGeneSymbol)

LenGeneNet = length(TestedGeneSymbol);

% [C,ia,ic] = unique(A) also returns index vectors ia and ic.
% If A is a vector, then C = A(ia) and A = C(ic).
Sample_ID_Mut = cellfun(@(x) x(1:12),Sample_ID_Mut,'UniformOutput',0);

[Sample_ID_Mut_uni,~,Ind_Sample_uni] = unique(Sample_ID_Mut);
[GeneSymbol_Mut_uni,~,Ind_Gene_uni] = unique(GeneSymbol_Mut);

SampleID_complete = intersect(Sample_ID_Mut_uni,Sample_ID_Mut);
SampleID_complete = cellfun(@(x) x(1:12),SampleID_complete,'UniformOutput',0);
LenSampleCom = length(SampleID_complete);

X_Mut_raw = sparse(Ind_Sample_uni,Ind_Gene_uni,1);

[~,Ind_comp,Ind_Mut] = intersect(SampleID_complete,Sample_ID_Mut_uni);
if norm(Ind_comp - (1:length(Ind_comp))',2) ~= 0
    error('Mut data sample ID mismatch.');
end
X_Mut_samp = X_Mut_raw(Ind_Mut,:);

% C = A(ia) and C = B(ib).
X_Mut = sparse(LenSampleCom,LenGeneNet);
[~,Ind_Mut,Ind] = intersect(GeneSymbol_Mut_uni,TestedGeneSymbol);
X_Mut(:,Ind) = X_Mut_samp(:,Ind_Mut);
% -- Mut end --

end
