function out=apply_linear(C, X)

if length(C.bias)==1
  out=X*C.w+C.bias;
else
  out=X*C.w+C.bias(ones(size(X,1),1),:);
end

