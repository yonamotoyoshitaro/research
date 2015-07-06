function ix=findmin_medin(L)

% obtain minimum value
mm=min(L);

% choose the median index
ix=medin(find(L==mm));
