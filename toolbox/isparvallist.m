function b=isparvallist(L)

if ~iseven(length(L))
  b=0;
else
  b=all(cell2mat(foreach(@ischar, L(1:2:end-1))));
end
