
function [GeneSymbol_Mut,Sample_ID_Mut] = P01_LoadRawMut(filename)

    delimiter = '\t';

    startRow = 1;
    endRow = inf;

    formatSpec = '%s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

    fileID = fopen(filename,'r');

    dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
    for block=2:length(startRow)
        frewind(fileID);
        dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
        for col=1:length(dataArray)
            dataArray{col} = [dataArray{col};dataArrayBlock{col}];
        end
    end

    fclose(fileID);

    GeneSymbol_Mut = dataArray{:, 1};
    Sample_ID_Mut = dataArray{:, 2};

    test_str = dataArray{1,1}(1);
    if strcmp(test_str{1}(1),'#')
        GeneSymbol_Mut(1:2) = [];
        Sample_ID_Mut(1:2) = [];
    elseif strcmp(test_str,'Hugo_Symbol')
        GeneSymbol_Mut(1) = [];
        Sample_ID_Mut(1) = [];
    end

end


