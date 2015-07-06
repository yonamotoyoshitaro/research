function [Xtr,Ytr,Xte,Yte]=load_usps()

[Xtr,Ytr]=load_multiclass_yx('/data/elem/usps/zip.train');
[Xte,Yte]=load_multiclass_yx('/data/elem/usps/zip.test');


function [X,Y]=load_multiclass_yx(file)
S=importdata(file);
I=S(:,1);
uu=unique(I);

Y=zeros(length(I),length(uu));
for ii=1:length(I)
  Y(ii,find(uu==I(ii)))=1;
end

X=S(:,2:end);

