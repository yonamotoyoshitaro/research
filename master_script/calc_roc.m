% アラートからROC曲線表を計算する
addpath C:\Users\akihabara\Desktop\work\tamura\toolbox\
addpath C:\Users\akihabara\Desktop\work\tamura\grad_tools\
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

%% DTO(動的閾値)による変化点検出
%% 中心性を用いた異常スコア値に対するアラート %%
for c = 1:centralitynum()
    % Hirose
    alert = importdata(strcat('./alert/dto/whole/hirose/centrality/', centralityname(c), '/alert.csv'));
    fname = strcat('./roc/dto/whole/hirose/centrality/', centralityname(c), '/roc.csv');
    exportroc(fname, alert);
    % Ide
    alert = importdata(strcat('./alert/dto/whole/ide/centrality/', centralityname(c), '/alert.csv'));
    fname = strcat('./roc/dto/whole/ide/centrality/', centralityname(c), '/roc.csv');
    exportroc(fname, alert);
    % SDML(各ノード毎)
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

%% 各中心性毎のアラートを組み合わせる %%
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

%% 生データを用いた異常スコア値 %%
% Hirose
alert = importdata('./alert/dto/whole/hirose/alert.csv');
fname = strcat('./roc/dto/whole/hirose/roc.csv');
exportroc(fname, alert);
% Ide
alert = importdata('./alert/dto/whole/ide/alert.csv');
fname = strcat('./roc/dto/whole/ide/roc.csv');
exportroc(fname, alert);