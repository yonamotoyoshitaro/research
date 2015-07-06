function X=fillnanmean(X)

mm=nanmean(X);

for ii=1:size(X,2)
  X(isnan(X(:,ii)),ii)=mm(ii);
end
