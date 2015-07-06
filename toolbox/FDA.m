function [W,dd]=FDA(Xtr,Ytr,lambda)

if ~exist('lambda','var') || isempty(lambda)
  lambda=0;
end

if size(Ytr,1)<size(Ytr,2)
  Ytr=Ytr';
end

if isequal(unique(Ytr),[-1;1])
  Ytr=double([Ytr>0, Ytr<0]);
end


[m,n]=size(Xtr);
nc=size(Ytr,2);


mm = mean(Xtr)';

Sw=zeros(n);
Sb=zeros(n);
for ii=1:nc
  ix=find(Ytr(:,ii)>0);
  mc = mean(Xtr(ix,:))';
  Sb = Sb + (mc-mm)*(mc-mm)';
  Sw = Sw + cov(Xtr(ix,:));
end

[W,D]=eig(Sb, Sw+lambda*eye(n));


dd=diag(D);

[ss,ix]=sort(-dd);

W=W(:,ix(1:nc-1));
dd=dd(ix(1:nc-1));