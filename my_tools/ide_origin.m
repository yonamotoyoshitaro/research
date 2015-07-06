function [score]=ide_origin(data)

% 各ノードの中心性から相互相関行列を生成し、その固有値ベクトルから異常スコアを計算するプログラム
% Ideらの手法

%% 異常スコア列の計算 %%
W2 = 6;                                     % 特徴ベクトル列から過去をさかのぼる時間幅
dsize = size(data);                         % データサイズ
score = zeros(1, length(data)/dsize(2));    % スコア列
U = [];                                     % 特徴ベクトル(最大固有値に対応する最大固有ベクトル(ノルム１))行列(Node×W2)
r = -1;                                     % t-1時点における上記特徴ベクトルの特徴ベクトル                             
for i = 1:length(data)/dsize(2)
    % 相関行列の生成
    A = data(1+dsize(2)*(i-1):dsize(2)*i,:);
    % 特徴ベクトル計算
    [uu, s] =  eig(A);
    u = uu(:,1);
    U = horzcat(u,U);
    % スコアの計算
    if(i >= W2)
        if r ~= -1
            score(i) = 1 - abs(r'*u);
        end
        % 論文の式11-13にそってr(t)を計算
        [vv, cc] =  eig(U'*U);
        v = vv(:,W2); % 右に最大固有値とそれに対応するベクトルがある
        c = 1/sqrt(cc(W2,W2));
        r = c*U*v;
        U(:,W2) = []; % １番古い特徴ベクトルは追い出す
    end
end