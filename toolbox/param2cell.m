function C=param2cell(P1, P2)

nd=2;

sz=[length(P1), length(P2)];

C=cell(sz);

for ind=1:prod(sz)
  [ii,jj]=ind2sub(sz, ind);
  C{ind}=[P1(ii), P2(jj)];
end
