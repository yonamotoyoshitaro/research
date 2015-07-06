function [score]=ide(data)

% 各ノードの中心性から相互相関行列を生成し、その固有値ベクトルから異常スコアを計算するプログラム
% Ideらの手法

%% 異常スコア列の計算 %%
W1 = 5;         % 時系列データから相関行列をつくる時間幅
W2 = 6;         % 特徴ベクトル列から過去をさかのぼる時間幅
score = zeros(1, length(data));   % スコア列
U = [];                                 % 特徴ベクトル(最大固有値に対応する最大固有ベクトル(ノルム１))行列(Node×W2)
r = -1;                                  % t-1時点における上記特徴ベクトルの特徴ベクトル 
dsize = size(data);
N = dsize(2);
for i = 1:length(data)-W1
    % 相関行列の作成
    f = i;
    t = i+W1;
    T = data(f:t, 1:N);
    A = abs(corrcoef(T));
    % NAN → 0変換
    for a = 1:N
        for b = 1:N
            if(isnan(A(a,b)))
                A(a,b) = 0;
            end
        end
    end
    % 特徴ベクトル計算
    [uu, s] =  eig(A);
    u = uu(:,1);
    U = horzcat(u,U);
    % スコアの計算
    if(i >= W2)
        if r ~= -1
            score(t) = 1 - abs(r'*u);
        end
        % 論文の式11-13にそってr(t)を計算
        [vv, cc] =  eig(U'*U);
        v = vv(:,W2); % 右に最大固有値とそれに対応するベクトルがある
        c = 1/sqrt(cc(W2,W2));
        r = c*U*v;
        U(:,W2) = []; % １番古い特徴ベクトルは追い出す
    end
end