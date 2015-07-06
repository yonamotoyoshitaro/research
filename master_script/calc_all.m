% �A���[�g����ROC�Ȑ��\���v�Z����
addpath C:\Users\akihabara\Desktop\work\tamura\toolbox\
addpath C:\Users\akihabara\Desktop\work\tamura\grad_tools\
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

% ���s�ݒ��ǂݍ���
target_centrality = targetcentrality();
target_anomaly_score = targetanomalyscore();
target_alert = targetalert();

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

%% DTO(���I臒l)�ɂ��ω��_���o
%% ���S����p�����ُ�X�R�A�l�ɑ΂���A���[�g %%
for c = target_centrality(1):target_centrality(2)
    % Hirose
    if target_alert(1)
        score = importdata(strcat('./anomaly_score/whole/hirose/centrality/', centralityname(c), '/score.csv'));
        fname = strcat('./alert/dto/whole/hirose/centrality/', centralityname(c), '/alert.csv');
        exportalert(fname, score);
    end
    % Ide
    if target_alert(2)
        score = importdata(strcat('./anomaly_score/whole/ide/centrality/', centralityname(c), '/score.csv'));
        fname = strcat('./alert/dto/whole/ide/centrality/', centralityname(c), '/alert.csv');
        exportalert(fname, score);
    end
    % SDML(�e�m�[�h��)
    if target_alert(3)
        scores = importdata(strcat('./anomaly_score/node/centrality/', centralityname(c), '/score.csv'));
        dsize = size(scores);
        for node = 1:dsize(2)
            fname = strcat('./alert/dto/node/centrality/', centralityname(c), '/alert', num2str(node), '.csv');
            score = scores(:,node);
            exportalert(fname, score);
        end
    end
    % Node OR
    if target_alert(4)
        % ���m�[�h�����擾
        scores = importdata(strcat('./anomaly_score/node/centrality/', centralityname(c), '/score.csv'));
        dsize = size(scores);
        for node = 1:dsize(2)
            % �e�m�[�h�̃A���[�g��ǂݍ���
            a = importdata(strcat('./alert/dto/node/centrality/', centralityname(c), '/alert', num2str(node), '.csv'));
            as = size(a);
            if node == 1
                total_alert = zeros(dsize(2), as(1), as(2)); % �m�[�h x ���� x 臒l
            end
            total_alert(node,:,:) = a;
        end
        mix_alert_or = mixalertor(total_alert);
        fname = strcat('./alert/dto/whole/node_or/centrality/', centralityname(c), '/alert.csv');
        exportscore2(fname, mix_alert_or);
    end
end

%% �e���S�����̃A���[�g��g�ݍ��킹�� %%
% Hirose OR
if target_alert(5)
    for c = 1:centralitynum()
        % �e���S���̃A���[�g��ǂݍ���
        a = importdata(strcat('./alert/dto/whole/hirose/centrality/', centralityname(c), '/alert.csv'));
        as = size(a);
        if c == 1
            total_alert = zeros(centralitynum(), as(1), as(2)); % ���S�� x ���� x 臒l
        end
        total_alert(c,:,:) = a;
    end
    mix_alert_or = mixalertor(total_alert);
    fname = strcat('./alert/dto/whole2/mix_alert/or/hirose/alert.csv');
    exportscore2(fname, mix_alert_or);
end

% Ide OR
if target_alert(6)
    for c = 1:centralitynum()
        % �e���S���̃A���[�g��ǂݍ���
        a = importdata(strcat('./alert/dto/whole/ide/centrality/', centralityname(c), '/alert.csv'));
        as = size(a);
        if c == 1
            total_alert = zeros(centralitynum(), as(1), as(2)); % ���S�� x ���� x 臒l
        end
        total_alert(c,:,:) = a;
    end
    mix_alert_or = mixalertor(total_alert);
    fname = strcat('./alert/dto/whole2/mix_alert/or/ide/alert.csv');
    exportscore2(fname, mix_alert_or);
end

% SDML
if target_alert(7)
    for c = 1:centralitynum()
        % �e���S���̃A���[�g��ǂݍ���
        a = importdata(strcat('./alert/dto/whole/node_or/centrality/', centralityname(c), '/alert.csv'));
        as = size(a);
        if c == 1
            total_alert = zeros(centralitynum(), as(1), as(2)); % ���S�� x ���� x 臒l
        end
        total_alert(c,:,:) = a;
    end
    mix_alert_or = mixalertor(total_alert);
    fname = strcat('./alert/dto/whole2/mix_alert/or/node_or/alert.csv');
    exportscore2(fname, mix_alert_or);
end

%% ���f�[�^��p�����ُ�X�R�A�l %%
% Hirose
if target_alert(8)
    score = importdata('./anomaly_score/whole/hirose/score.csv');
    fname = './alert/dto/whole/hirose/alert.csv';
    exportalert(fname, score);
end
% Ide
if target_alert(9)
    score = importdata('./anomaly_score/whole/ide/score.csv');
    fname = './alert/dto/whole/ide/alert.csv';
    exportalert(fname, score);
end

%% ROC %%
for c = 1:centralitynum()
    % Hirose
    alert = importdata(strcat('./alert/dto/whole/hirose/centrality/', centralityname(c), '/alert.csv'));
    fname = strcat('./roc/dto/whole/hirose/centrality/', centralityname(c), '/roc.csv');
    exportroc(fname, alert);
    % Ide
    alert = importdata(strcat('./alert/dto/whole/ide/centrality/', centralityname(c), '/alert.csv'));
    fname = strcat('./roc/dto/whole/ide/centrality/', centralityname(c), '/roc.csv');
    exportroc(fname, alert);
    % SDML(�e�m�[�h��)
    scores = importdata(strcat('./anomaly_score/node/centrality/', centralityname(c), '/score.csv'));
    dsize = size(scores);
    for node = 1:dsize(2)
        alert = importdata(strcat('./alert/dto/node/centrality/', centralityname(c), '/alert', num2str(node), '.csv'));
        fname = strcat('./roc/dto/node/centrality/', centralityname(c), '/roc', num2str(node), '.csv');
        exportroc(fname, alert);
    end
    % Node OR
    alert = importdata(strcat('./alert/dto/whole/node_or/centrality/', centralityname(c), '/alert.csv'));
    fname = strcat('./roc/dto/whole/node_or/centrality/', centralityname(c), '/roc.csv');
    exportroc(fname, alert);
end

%% �e���S�����̃A���[�g��g�ݍ��킹�� %%
% Hirose
alert = importdata(strcat('./alert/dto/whole2/mix_alert/or/hirose/alert.csv'));
fname = strcat('./roc/dto/whole2/mix_alert/or/hirose/roc.csv');
exportroc(fname, alert);
% Ide
alert = importdata(strcat('./alert/dto/whole2/mix_alert/or/ide/alert.csv'));
fname = strcat('./roc/dto/whole2/mix_alert/or/ide/roc.csv');
exportroc(fname, alert);
% SDML
alert = importdata(strcat('./alert/dto/whole2/mix_alert/or/node_or/alert.csv'));
fname = strcat('./roc/dto/whole2/mix_alert/or/node_or/roc.csv');
exportroc(fname, alert);

%% ���f�[�^��p�����ُ�X�R�A�l %%
% Hirose
alert = importdata('./alert/dto/whole/hirose/alert.csv');
fname = strcat('./roc/dto/whole/hirose/roc.csv');
exportroc(fname, alert);
% Ide
alert = importdata('./alert/dto/whole/ide/alert.csv');
fname = strcat('./roc/dto/whole/ide/roc.csv');
exportroc(fname, alert);

%% AUC %%
for c = 1:centralitynum()
    % Hirose
    roc = importdata(strcat('./roc/dto/whole/hirose/centrality/', centralityname(c), '/roc.csv'));
    fname = strcat('./auc/dto/whole/hirose/centrality/', centralityname(c), '/auc.csv');
    exportauc(fname, roc);
    fname = strcat('./auc/dto/whole/hirose/centrality/', centralityname(c), '/roc.png');
    plotroc(fname, roc);
    % Ide
    roc = importdata(strcat('./roc/dto/whole/ide/centrality/', centralityname(c), '/roc.csv'));
    fname = strcat('./auc/dto/whole/ide/centrality/', centralityname(c), '/auc.csv');
    exportauc(fname, roc);
    fname = strcat('./auc/dto/whole/ide/centrality/', centralityname(c), '/roc.png');
    plotroc(fname, roc);
    % SDML(�e�m�[�h��)
    scores = importdata(strcat('./anomaly_score/node/centrality/', centralityname(c), '/score.csv'));
    dsize = size(scores);
    for node = 1:dsize(2)
        roc = importdata(strcat('./roc/dto/node/centrality/', centralityname(c), '/roc', num2str(node), '.csv'));
        fname = strcat('./auc/dto/node/centrality/', centralityname(c), '/auc', num2str(node), '.csv');
        exportauc(fname, roc);
        fname = strcat('./auc/dto/node/centrality/', centralityname(c), '/roc', num2str(node), '.png');
        plotroc(fname, roc);
    end
    % Node OR
    roc = importdata(strcat('./roc/dto/whole/node_or/centrality/', centralityname(c), '/roc.csv'));
    fname = strcat('./auc/dto/whole/node_or/centrality/', centralityname(c), '/auc.csv');
    exportauc(fname, roc);
    fname = strcat('./auc/dto/whole/node_or/centrality/', centralityname(c), '/roc.png');
    plotroc(fname, roc);
end

%% �e���S�����̃A���[�g��g�ݍ��킹�� %%
% Hirose
roc = importdata(strcat('./roc/dto/whole2/mix_alert/or/hirose/roc.csv'));
fname = './auc/dto/whole2/mix_alert/or/hirose/auc.csv';
exportauc(fname, roc);
fname = './auc/dto/whole2/mix_alert/or/hirose/roc.png';
plotroc(fname, roc);
% Ide
roc = importdata(strcat('./roc/dto/whole2/mix_alert/or/ide/roc.csv'));
fname = './auc/dto/whole2/mix_alert/or/ide/auc.csv';
exportauc(fname, roc);
fname = './auc/dto/whole2/mix_alert/or/ide/roc.png';
plotroc(fname, roc);
% SDML
roc = importdata(strcat('./roc/dto/whole2/mix_alert/or/node_or/roc.csv'));
fname = './auc/dto/whole2/mix_alert/or/node_or/auc.csv';
exportauc(fname, roc);
fname = './auc/dto/whole2/mix_alert/or/node_or/roc.png';
plotroc(fname, roc);

%% ���f�[�^��p�����ُ�X�R�A�l %%
% Hirose
roc = importdata('./roc/dto/whole/hirose/roc.csv');
fname = './auc/dto/whole/hirose/auc.csv';
exportauc(fname, roc);
fname = './auc/dto/whole/hirose/roc.png';
plotroc(fname, roc);
% Ide
roc = importdata('./roc/dto/whole/ide/roc.csv');
fname = './auc/dto/whole/ide/auc.csv';
exportauc(fname, roc);
fname = './auc/dto/whole/ide/roc.png';
plotroc(fname, roc);