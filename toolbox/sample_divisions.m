% sample_divisions - samples traing/test samples
%
% Example (2x10folds):
%  [Itr, Ite]=sample_divisions([2 10], yy);
%
% Copyright (C) Ryota Tomioka 2010
function [divTr, divTe]=sample_divisions(nTrials, Y)

nn = length(Y);

divTr=cell(nTrials);
divTe=cell(nTrials);


for ii=1:nTrials(1)
  I=randperm(nn);
  i2=0;
  for jj=1:nTrials(2)
    i1=i2+1; i2=round(nn*jj/nTrials(2));
    Ite =sort(I(i1:i2));
    divTr{ii,jj} =setdiff(1:nn, Ite);
    divTe{ii,jj} =Ite;
  end
end
