% �l�b�g���[�N�ُ̈�X�R�A���v�Z����
addpath C:\Users\akihabara\Desktop\work\tamura\toolbox\
addpath C:\Users\akihabara\Desktop\work\tamura\grad_tools\
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

% ���s�ݒ��ǂݍ���
target_centrality = targetcentrality();
target_anomaly_score = targetanomalyscore();

%% ���S����p�����ُ�X�R�A�l %%
for c = target_centrality(1):target_centrality(2)
    D = importdata(strcat('./centrality/', centralityname(c), '/data.csv'));
    data = D.data;
    dsize = size(data);
    % Hirose
    if target_anomaly_score(1)
        score = hirose(data);
        fname = strcat('./anomaly_score/whole/hirose/centrality/', centralityname(c), '/score.csv');
        exportscore(fname, score);
        fname = strcat('./anomaly_score/whole/hirose/centrality/', centralityname(c), '/score.png');
        plotscore(fname, score);
    end
    % Ide
    if target_anomaly_score(2)
        score = ide(data);
        fname = strcat('./anomaly_score/whole/ide/centrality/', centralityname(c), '/score.csv');
        exportscore(fname, score);
        fname = strcat('./anomaly_score/whole/ide/centrality/', centralityname(c), '/score.png');
        plotscore(fname, score);
    end
    % SDML(�e�m�[�h��)
    if target_anomaly_score(3)
        score = [];
        for node = 1:dsize(2)
            cms = data(:,node);
            s = cms;
            if(~isempty(find(cms, 1))) 
                s = sdml(cms);
            end
            fname = strcat('./anomaly_score/node/centrality/', centralityname(c), '/', num2str(node), '.png');
            plotscore(fname, s);
            score = horzcat(score, s);
        end
        fname = strcat('./anomaly_score/node/centrality/', centralityname(c), '/score.csv');
        exportscore2(fname, score);
    end
end

%% ���f�[�^��p�����ُ�X�R�A�l %%
D = importdata('data_matrix.csv');
% Hirose
if target_anomaly_score(4)
    score = hirose_origin(D.data);
    fname = 'anomaly_score/whole/hirose/score.csv';
    exportscore(fname, score);
    fname = 'anomaly_score/whole/hirose/score.png';
    plotscore(fname, score);
end
% Ide
if target_anomaly_score(5)
    score = ide_origin(D.data);
    fname = 'anomaly_score/whole/ide/score.csv';
    exportscore(fname, score);
    fname = 'anomaly_score/whole/ide/score.png';
    plotscore(fname, score);
end