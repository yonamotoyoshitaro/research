function [x]=compress(data,T)

% ***機能***
% 与えられた一次元データ配列を，幅T毎に平均をとって離散化する．

% ***入力***
% data:データ配列(一次元ベクトル)
% T:平滑化幅

% ***出力***
% x:幅T毎の平均値の列．

% 質問等あればtosh.914@gmail.comにどうぞ．

n = ceil(length(data)/T);
m = length(data);
x = zeros(n,1);
for i=1:n-1
    x(i,1) = sum(data(T*(i-1)+1:T*i))/T;
end
x(n,1) = sum(data(T*(n-1)+1:m))/T;