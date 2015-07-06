function [x]=normalize(data,T)

% ***機能***
% 与えられた一次元データ配列を，幅Tの窓を用いて平滑化する．

% ***入力***
% data:データ配列(一次元ベクトル)
% T:平滑化幅

% ***出力***
% x:平滑化されたデータ列．入力と長さは同じ．

% 質問等あればtosh.914@gmail.comにどうぞ．

x = zeros(size(data));
for i=1:T
    x(i)=nanmean(data(1:i));
end
for i=T+1:length(data)
    x(i)=nanmean(data(i-T+1:i));
end