function [Xtr,Ytr,Xte,Yte]=load_SPECT()

T=importdata('/data/uci/spect/SPECT.train');
Xtr=T(:,2:end);
Ytr=T(:,1)*2-1;

T=importdata('/data/uci/spect/SPECT.test');
Xte=T(:,2:end);
Yte=T(:,1)*2-1;
