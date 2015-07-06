function m=medin(X)


ss=sort(X(:));

ix=round((length(ss)+1)/2);

m=ss(ix);