% 異常スコアからアラートをあげる
% 異常スコアをファイルから読み取り、スコア列に対してアラートを計算する
addpath C:\Users\akihabara\Desktop\work\tamura\toolbox\
addpath C:\Users\akihabara\Desktop\work\tamura\grad_tools\
addpath C:\Users\akihabara\Desktop\work\tamura\my_tools\

% 実行設定を読み込み
target_centrality = targetcentrality();
target_alert = targetalert();

%% DTO(動的閾値)による変化点検出
%% 中心性を用いた異常スコア値に対するアラート %%
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
    % SDML(各ノード毎)
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
        % 総ノード数を取得
        scores = importdata(strcat('./anomaly_score/node/centrality/', centralityname(c), '/score.csv'));
        dsize = size(scores);
        for node = 1:dsize(2)
            % 各ノードのアラートを読み込む
            a = importdata(strcat('./alert/dto/node/centrality/', centralityname(c), '/alert', num2str(node), '.csv'));
            as = size(a);
            if node == 1
                total_alert = zeros(dsize(2), as(1), as(2)); % ノード x 時間 x 閾値
            end
            total_alert(node,:,:) = a;
        end
        mix_alert_or = mixalertor(total_alert);
        fname = strcat('./alert/dto/whole/node_or/centrality/', centralityname(c), '/alert.csv');
        exportscore2(fname, mix_alert_or);
    end
end

%% 各中心性毎のアラートを組み合わせる %%
% Hirose OR
if target_alert(5)
    for c = 1:centralitynum()
        % 各中心性のアラートを読み込む
        a = importdata(strcat('./alert/dto/whole/hirose/centrality/', centralityname(c), '/alert.csv'));
        as = size(a);
        if c == 1
            total_alert = zeros(centralitynum(), as(1), as(2)); % 中心性 x 時間 x 閾値
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
        % 各中心性のアラートを読み込む
        a = importdata(strcat('./alert/dto/whole/ide/centrality/', centralityname(c), '/alert.csv'));
        as = size(a);
        if c == 1
            total_alert = zeros(centralitynum(), as(1), as(2)); % 中心性 x 時間 x 閾値
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
        % 各中心性のアラートを読み込む
        a = importdata(strcat('./alert/dto/whole/node_or/centrality/', centralityname(c), '/alert.csv'));
        as = size(a);
        if c == 1
            total_alert = zeros(centralitynum(), as(1), as(2)); % 中心性 x 時間 x 閾値
        end
        total_alert(c,:,:) = a;
    end
    mix_alert_or = mixalertor(total_alert);
    fname = strcat('./alert/dto/whole2/mix_alert/or/node_or/alert.csv');
    exportscore2(fname, mix_alert_or);
end

%% 生データを用いた異常スコア値 %%
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