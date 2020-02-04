clc; close all;

fileList = dir('data/*.json');

numFiles = length(fileList);
filePaths = cell(numFiles, 1);

for i = 1:numFiles
    filePaths{i} = fullfile(fileList(i).folder, fileList(i).name);
end

data = loadChartData(filePaths);

%---------chart settings----------
linewidth = 2;
labelsize = 8;
xlimits = [0, 50];
ylimits = [0, 50];
colorDistance = 0.2;
%--------------------------------

numLines = length(data);
legendCell = cell(numLines, 1);

figure

for i = 1:numLines
    lineData = data{i};
    numWords = lineData.n_spot_words;
    labels = string(lineData.df(:, 1));
    faVec = lineData.df(:, 3);
    mdVec = lineData.df(:, 4);
    
    x = 100 * faVec / numWords;
    y = 100 * mdVec / numWords;
    
    color = [0 0 0]+colorDistance*i; % grayscale
    
    %loglog(x,y, 'linewidth', linewidth,'Color',color); % logarithmic scale
    plot(x, y, 'linewidth', linewidth,'Color',color); % linear scale
    
    text(x,y,labels,'VerticalAlignment','top','HorizontalAlignment','right', "FontSize", labelsize)
    
    name = lineData.name;
    eer = ceil(lineData.eer);
    eerTh = round(lineData.eer_spot_threshold);
    legendCell{i} = sprintf('%s (#w=%d) EER=%d%% at th=%d', name, numWords, eer, eerTh);
    
    hold on
end

plot([0, 70],[0, 70],'--k')

xlim(xlimits);
ylim(ylimits);
title('KWS DET');
ylabel('MISSED DETECTIONS [%]');
xlabel('FALSE ALARMS [%]');
legend(legendCell);

grid on

hold off



