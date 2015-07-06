function [alm]=alarm1(scores,N,rho,lam,r)

% ***機�?***
% 動的しき�??選�?詳細は高橋�?卒論参照)によりスコア�??タに
% 対してアラー�?��上げる関数??
% ***入�?**
% scores:スコア�??タ�?横ベクトル)
% N:セルの数
% rho:閾値パラメータ
% lam:推定パラメータ
% r:忘却係数

% ***出�?**
% alm:アラー�??オン・オフを表す�?クトル?��?力データ列と長さ�?同じ??
% 質問等あれ�?tosh.914@gmail.comにど�?��??
M = length(scores); % datasize
min = nanmin(scores);
%min = nanmean(scores)-3*nanstd(scores);
%max = nanmax(scores);
max = nanmean(scores)+3*nanstd(scores);
alm = zeros(1,M); % alarm on or off
q1 = zeros(1,N); % 
q1 = q1 + 1.0/N; % uniform distribution
w = (max-min)/(N-2); % cell width
b = zeros(1,N-1); % left border of the cells
% calculate left border of the cells
for i=1:N-2
    b(i) = min+w*(i-1);
end
b(N-1) = max;

for i=1:M
    q = (q1+lam)/(sum(q1)+N*lam);
    % find and calc threshold
    l=1;
    for j=1:N
        if sum(q(1:j)) < 1.0-rho
            l=j+1;
        end
    end
    if l == 1
        l = 2;
    end
    eta = b(l-1);
    % decide alarm or not
    if scores(i) >= eta
        alm(i) = 1;
    end
    % find the cell which the score drop in
    h = 1;
    for j=1:N-1
        if scores(i) >= b(j)
            h = j+1;
        end
    end
    % recalc probability of the cells
    q1 = (1.0-r)*q1;
    q1(h) = q1(h) + r;
end