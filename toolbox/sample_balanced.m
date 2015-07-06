% sample_balanced - samples traing/test samples preserving the
%                   proportion of labels
%
% Example:
%  [Itr, Ite]=sample_balanced(folds, yy);
%
% Copyright (C) Ryota Tomioka 2010
function [Itr, Ite,ixdiv]=sample_balanced(folds, yy)

if length(folds)<3
  folds(3)=1;
end

if size(yy,1)==1 && size(yy,2)>1
  yy=yy';
end

if length(unique(yy))>1 && size(yy,2)==1
  yy=id2lab(yy);
end
  

[nn,nc]=size(yy);

Icls=cell(1,nc);
ncls=zeros(1,nc);
for ii=1:nc
  Icls{ii}=find(yy(:,ii))';
  ncls(ii)=length(Icls{ii});
end

ixdiv = [zeros(1,length(ncls)); round((1:folds(2))'*ncls/folds(2))];


nfolds=floor(folds(2)/folds(3));
Itr=cell([folds(1), nfolds]);
Ite=cell([folds(1), nfolds]);
for ii=1:folds(1)
  for kk=1:nc
    perm{kk}=Icls{kk}(randperm(ncls(kk)));
  end

  for jj=1:nfolds
    jf1=(jj-1)*folds(3)+1;
    jf2=jj*folds(3);
    ixte=[];
    for kk=1:nc
      ixte=[ixte, perm{kk}(ixdiv(jf1,kk)+1:ixdiv(jf2+1,kk))];
    end
    Itr{ii,jj}=setdiff(1:nn, ixte);
    Ite{ii,jj}=ixte;
  end
end


