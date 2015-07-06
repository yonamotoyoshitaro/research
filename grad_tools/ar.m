% ARモデルの次数を推定するための図をプロットするプログラム
% http://www.mathworks.co.jp/help/signal/ug/ar-order-assessmen-with-partial-autocorrelation-sequence.html
addpath ./toolbox/
addpath ./grad_tools/

D=importdata('./data/freq_week.csv');

[arcoefs,E,K] = aryule(D.data(:,14),25);

pacf = -K;
lag = 1:25;
stem(lag,pacf,'markerfacecolor',[0 0 1]);
xlabel('Lag'); ylabel('Partial Autocorrelation');
set(gca,'xtick',1:1:15)
lconf = -1.96/sqrt(1000)*ones(length(lag),1);
uconf = 1.96/sqrt(1000)*ones(length(lag),1);
hold on;
line(lag,lconf,'color',[1 0 0]);
line(lag,uconf,'color',[1 0 0]);