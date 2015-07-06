% sample_fixed - samples fixed (total) amount of training examples
%                preserving the label balance and puts the rest in
%                the test set.
%
% Example:
%  [Itr, Ite]=sample_balanced(folds, yy);
%
% Copyright (C) Ryota Tomioka 2010
function [Itr, Ite]=sample_fixed(folds, yy)

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


Itr=cell(folds(1),1);
Ite=cell(folds(1),1);

for ii=1:folds(1)
  [fp,bp]=randpermfb(nc);
  ncls1=ncls(fp);
  nsamples=diff([0,round(cumsum(ncls1)*folds(2)/nn)]);
  nsamples=nsamples(bp);

  Itr{ii}=[];
  for jj=1:nc
    ind=randperm(ncls(jj)); ind=ind(1:nsamples(jj));
    Itr{ii}=[Itr{ii}, Icls{jj}(ind)]; 
  end
  Ite{ii}=setdiff(1:nn, Itr{ii});
end

