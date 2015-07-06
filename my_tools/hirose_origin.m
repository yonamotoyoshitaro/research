function [score]=hirose_origin(data)

% 各ノードの中心性から相互相関行列を生成し、その固有値から異常スコアを計算するプログラム
% Hirose, Yamanishiらの手法
% cf. Network Anomaly Detection based on Eigen Equation Compression

%% 異常スコア列の計算 %%
%{
    t-1時点での多変量正規分布の密度関数を推定し、
    t時点の固有値ベクトルの異常スコアを、t-1時点で推定された密度関数からのレア度を持って表す
%}
M = 3;                                      % 上位いくつまでの固有値を利用するか
LAMDA = [];                                 % 固有値ベクトル(上位m個を並べたベクトル)を時系列順に並べたもの
dsize = size(data);                         % データサイズ
score = zeros(1, length(data)/dsize(2));    % スコア列
m = -1;                                     % (t-1時点における)平均
c = -1;                                     % (t-1時点における)共分散行列
for i = 1:length(data)/dsize(2)
    % 相関行列の生成
    A = data(1+dsize(2)*(i-1):dsize(2)*i,:);
    % 上位m個の固有値を利用したベクトル
    lamda =  eigs(A,M).';
    % 異常スコアの計算
    if i > 2  && det(c) ~= 0
        p = exp((-1/2)*(lamda-m)*(c\(lamda-m).'))/((2*pi)^(M/2)*det(c)^(1/2));
        if p > 0
            score(i) = real(-log(p));
            if score(i) == Inf || score(i) == -Inf
                score(i) = 0;
            end
        else
            score(i) = 0;
        end
    end
    % パラメータを更新
    LAMDA = vertcat(LAMDA,lamda);
    m = mean(LAMDA);
    c = cov(LAMDA);
end