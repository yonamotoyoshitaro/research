% id2lab - converts class id's into label matrix
%
% Example:
%  id2lab({'cat','dog','dog','dog','cat','dog','cat'})
%
% Copyright (C) Ryota Tomioka 2010
function lab=id2lab(id)

[uu,I,J]=unique(id(:));

lab=zeros(length(id),length(uu));

for ii=1:length(uu)
  lab(:,ii)=J==ii;
end

