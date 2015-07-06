function []=exportalert(fname, score)

% アラートをファイルにエクスポートする
% DTOの動的閾値パラメータを0.01--1.00の範囲で変化させたときのアラートをcsvに出力
% 各列がある閾値に対するアラート該当し、各行が時間に該当

N=20;           % 動的しきい値更新パラメータ：セル数
lambda=0.01;    % 動的しきい値更新パラメータ：学習パラメータ
r=0.05;         % 変化点検出パラメータ：忘却係数

%TODO: 全入力が0だった場合はアラートを全くあげない
% 今だとすべてに対してアラートが上がってしまう。。
if isempty(find(score, 1))
    alert = zeros(100, length(score));
else
    alert = [];
    for i = 1:100
        p = 0.01 * i;
        alert = vertcat(alert, alarm1(score, N, p, lambda, r));  
    end
end
exportscore2(fname, alert.');