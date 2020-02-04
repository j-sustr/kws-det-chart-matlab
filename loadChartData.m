function dataArr = loadChartData(fpaths)
    nFiles = length(fpaths);
    dataArr = cell(nFiles, 1);
    
    for i = 1:nFiles
        dataArr{i} = loadJson(string(fpaths(i)));
        [~,name,~] = fileparts(string(fpaths(i)));
        dataArr{i}.name = name;
        df = dataArr{i}.df(2:end);
        dfLen = length(df);
        mat = zeros(dfLen, 4);
        
        for j = 1:dfLen
            mat(j, :) = cell2mat(df(j));
        end
        
        dataArr{i}.df = mat;
    end
end

