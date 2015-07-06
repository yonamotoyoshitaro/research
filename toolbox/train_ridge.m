function C=train_ridge(Xtr,Ytr,lambda,opt)

if ~exist('lambda','var') || isempty(lambda)
  lambda=0;
end

if ~isfield(opt,'center')
  opt.center=1;
end



if size(Ytr,1)<size(Ytr,2) && size(Ytr,2)==size(Xtr,1)
  Ytr=Ytr';
end

[m,n]=size(Xtr);

if opt.center
  mm=mean(Xtr);
  Xtr=Xtr-mm(ones(m,1),:);
else
  mm=zeros(1,n);
end


if n<m
  w=(Xtr'*Xtr+lambda*eye(n))\(Xtr'*Ytr);
else
  w=Xtr'*((Xtr*Xtr'+lambda*eye(m))\Ytr);
end

C=struct('w',w,'bias',-mm*w);
