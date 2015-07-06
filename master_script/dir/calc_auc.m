% アラートからROC曲線表を計算する
addpath C:\Users\akihabara\Desktop\work\tamura\toolbox\
addpath C:\Users\akihabara\Desktop\work\tamura\grad_tools\
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

%% DTO(動的閾値)による変化点検出
%% 中心性を用いた異常スコア値に対するアラート %%
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
    % SDML(各ノード毎)
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

%% 各中心性毎のアラートを組み合わせる %%
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

%% 生データを用いた異常スコア値 %%
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