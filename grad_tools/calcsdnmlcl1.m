function cls=calcsdnmlcl1(data,k,r)

% ***機能***
% 忘却型逐次的最尤推定法(SDNML)に従って，時系列に対して符号長を与える．
% 誤差分散の推定量tauに忘却を入れない，[Rissanen et al. 2010]の更新
% 式を用いたバージョン．

% ***入力***
% data:データ配列(一次元ベクトル)
% k:ARモデルの次数
% r:忘却係数

% ***出力***
% cls:SDNML符号長の列

% 質問等あればtosh.914@gmail.comにどうぞ．

l=length(data);

eh=zeros(l,1);
th=zeros(l,1);
cls=zeros(l,1);

kk=k+find(-(isnan(data))+1,1,'first')-1;
m=kk;
eh(1:kk)=NaN;
eh(1:kk)=NaN;
cls(1:kk)=NaN;

%%% t=k+1のパラメータを得る %%%
t=kk+1;
x=data(t);
xb=data(t-1:-1:t-k);
%Vt=pinv(r*xb*xb');
Vt=eye(k);
Vt=Vt/(xb'*xb+1e-12);
%M=r*xb*x;
M=xb*x;
At=Vt*M;
eh(t)=x-At'*xb;
th(t)=eh(t)^2;
cls(t)=NaN;

%%% t=k+2からループ開始 %%%
for t=kk+2:l
    x=data(t);
    xb=data(t-1:-1:t-k);
    M=(1-r)*M+r*xb*x;
    ct=r*xb'*Vt*xb;
    Vt=Vt/(1-r)-(r/(1-r))*Vt*xb*xb'*Vt/(1-r+ct);
    At=Vt*M;
    dt=ct/(1-r+ct);
    eh(t)=x-At'*xb;
    th(t)=(t-m-1)*th(t-1)/(t-m)+(eh(t)^2)/(t-m);

    a=t-m;
    b=t-m-1;
    lnK=log(pi)/2+log(b)/2-log(1-dt)-a*log(b)/2+a*log(a)/2+gammaln(b/2)-gammaln(a/2);
    sdnmlcl = lnK + a*log(th(t))/2 - b*log(th(t-1))/2;
    if sdnmlcl<inf&&sdnmlcl>-inf
        cls(t)=sdnmlcl;
    else
        cls(t)=NaN;
    end
end